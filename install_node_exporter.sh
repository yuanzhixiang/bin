#!/bin/bash

# Exit script on any command failure
set -eo

# Define variables
NODE_EXPORTER_VERSION="1.8.2"
NODE_EXPORTER_BINARY="/usr/local/bin/node_exporter"
DOWNLOAD_URL="https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"
SERVICE_FILE="/etc/systemd/system/node_exporter.service"
TEMP_DIR="/tmp/node_exporter"

# Check if node_exporter is already installed
if [ -f "$NODE_EXPORTER_BINARY" ]; then
    echo "Node Exporter is already installed at $NODE_EXPORTER_BINARY."
    exit 0
fi

# Create a temporary directory for node_exporter installation files
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR" || exit 1

# Download node_exporter tar.gz from GitHub
echo "Downloading Node Exporter v${NODE_EXPORTER_VERSION}..."
wget "$DOWNLOAD_URL"

# Extract the downloaded archive
echo "Extracting Node Exporter files..."
tar xvfz "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"

# Copy node_exporter to /usr/local/bin
echo "Installing Node Exporter binary to /usr/local/bin..."
sudo cp "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter" "$NODE_EXPORTER_BINARY"

# Clean up by removing temporary files
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

# Create a system user for running node_exporter with restricted privileges
if ! id "node_exporter" &>/dev/null; then
    echo "Creating node_exporter user..."
    sudo useradd -rs /bin/false node_exporter
fi

# Create a systemd service file for node_exporter
echo "Creating systemd service for Node Exporter..."
sudo tee "$SERVICE_FILE" <<EOF
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=$NODE_EXPORTER_BINARY

[Install]
WantedBy=multi-user.target
EOF

# Make sure the node_exporter binary is executable
echo "Setting executable permissions for Node Exporter binary..."
sudo chmod +x "$NODE_EXPORTER_BINARY"

# Start and enable the node_exporter service using systemctl
echo "Starting and enabling Node Exporter service..."
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

# Verify that node_exporter is running
echo "Checking Node Exporter service status..."
# sudo systemctl status node_exporter

curl localhost:9100/metrics

echo "Node Exporter has been successfully installed and started."
