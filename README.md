# Remote Shell in Google Cloud Build Pipeline

This repository provides a method to establish a remote shell within a Google Cloud Build pipeline, enabling real-time debugging and inspection of build processes. It utilizes Google Cloud Build for running builds and ngrok, a secure tunneling tool, to expose a temporary SSH server to the internet.

## How It Works

A custom Docker image is built that includes an SSH server and ngrok, allowing an encrypted connection to the build environment. The Cloud Build configuration (`cloudbuild.yaml`) orchestrates the build steps, including setting up the SSH server. The ngrok service is initiated within the Cloud Build environment to create a secure tunnel to the SSH server.

## Setting Up

1. Replace the `mykey.pub` file with your own public SSH key to ensure secure access.
2. Use the `gcloud builds submit` command to trigger the build, passing your ngrok auth token via substitutions:

```bash
gcloud builds submit --config=cloudbuild.yaml --substitutions=_NGROK_AUTH_TOKEN=your_ngrok_auth_token
```

3. Monitor the build logs in the Google Cloud Console or via the gcloud command output to find the ngrok tunnel hostname and port. Look for a line similar to:

```
Step #1 - "ssh-and-ngrok": t=2024-01-09T03:11:48+0000 lvl=info msg="started tunnel" obj=tunnels name=command_line addr=//localhost:22 url=tcp://2.tcp.us-cal-1.ngrok.io:10104
```


## Connecting to the Remote Shell

To access the remote shell, use the SSH command with the provided ngrok hostname and port:

```bash
ssh ssh://root@2.tcp.us-cal-1.ngrok.io:10104
```