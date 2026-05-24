#!/bin/bash

echo "Enabling and starting tailord service..."
sudo systemctl enable tailord.service
sudo systemctl start tailord.service
echo "Tailord service configured successfully!"