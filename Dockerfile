# Use Debian as the base image
FROM debian:buster

# Install SSH server
RUN apt-get update && \
    apt-get install -y openssh-server curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir /var/run/sshd

# Create the SSH directory and copy the public key
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh

# Copy the public key
COPY mykey.pub /root/.ssh/authorized_keys

# Set the correct permissions
RUN chmod 600 /root/.ssh/authorized_keys

# Install ngrok
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
    apt update && apt install ngrok

# Copy entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh

# Set the entrypoint script to be executable
RUN chmod +x /entrypoint.sh

# Use the entrypoint script as the entrypoint
ENTRYPOINT ["/entrypoint.sh"]