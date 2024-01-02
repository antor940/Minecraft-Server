# Use the official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install basic packages
RUN apt-get update && \
    apt-get install -y \
    sudo \
    curl \
    wget \
    git \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set a default user (optional)
RUN useradd -ms /bin/bash myuser
USER myuser

# Set the working directory
WORKDIR /home/myuser/app

# Example: Copy files into the container
COPY . .

# Your additional configurations and commands go here

# Start a command or service
CMD ["bash"]
