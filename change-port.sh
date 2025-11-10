#!/bin/bash

# Script to change port of an existing project
# This script stops containers, updates the port and prepares to restart them

set -e

echo "=========================================="
echo "  Change Project Port"
echo "=========================================="
echo ""

# Verify .env file exists
if [ ! -f .env ]; then
    echo "Error: .env file not found"
    echo "Make sure you are in the project root directory"
    exit 1
fi

# Get current ports
CURRENT_PORT=$(grep "^APP_PORT=" .env | cut -d'=' -f2)
CURRENT_VITE_PORT=$(grep "^VITE_PORT=" .env | cut -d'=' -f2)
CURRENT_DB_PORT=$(grep "^DB_PORT=" .env | cut -d'=' -f2)

if [ -z "$CURRENT_PORT" ]; then
    echo "Error: APP_PORT not found in .env file"
    exit 1
fi

echo "Current application port: $CURRENT_PORT"
echo "Current Vite port: $CURRENT_VITE_PORT"
echo "Current MongoDB port: ${CURRENT_DB_PORT:-27017}"
echo ""

# Request new port
read -p "Enter new web application port: " NEW_PORT

# Validate not empty
if [ -z "$NEW_PORT" ]; then
    echo "Error: Port cannot be empty"
    exit 1
fi

# Validate port is a number
if ! [[ "$NEW_PORT" =~ ^[0-9]+$ ]]; then
    echo "Error: Port must be a number"
    exit 1
fi

# Validate port range
if [ "$NEW_PORT" -lt 1024 ] || [ "$NEW_PORT" -gt 65535 ]; then
    echo "Error: Port must be between 1024 and 65535"
    exit 1
fi

# Validate new port is different from current
if [ "$NEW_PORT" -eq "$CURRENT_PORT" ]; then
    echo "Error: New port is the same as current port"
    exit 1
fi

# Request new Vite port
DEFAULT_NEW_VITE_PORT=$((NEW_PORT + 1000))
read -p "Enter new Vite HMR port (default $DEFAULT_NEW_VITE_PORT): " NEW_VITE_PORT
NEW_VITE_PORT=${NEW_VITE_PORT:-$DEFAULT_NEW_VITE_PORT}

# Validate port is a number
if ! [[ "$NEW_VITE_PORT" =~ ^[0-9]+$ ]]; then
    echo "Error: Port must be a number"
    exit 1
fi

# Validate port range
if [ "$NEW_VITE_PORT" -lt 1024 ] || [ "$NEW_VITE_PORT" -gt 65535 ]; then
    echo "Error: Port must be between 1024 and 65535"
    exit 1
fi

# Request new MongoDB port
echo ""
read -p "Enter new MongoDB port (default ${CURRENT_DB_PORT:-27017}): " NEW_DB_PORT
NEW_DB_PORT=${NEW_DB_PORT:-${CURRENT_DB_PORT:-27017}}

# Validate port is a number
if ! [[ "$NEW_DB_PORT" =~ ^[0-9]+$ ]]; then
    echo "Error: Port must be a number"
    exit 1
fi

# Validate port range
if [ "$NEW_DB_PORT" -lt 1024 ] || [ "$NEW_DB_PORT" -gt 65535 ]; then
    echo "Error: Port must be between 1024 and 65535"
    exit 1
fi

echo ""
echo "New application port: $NEW_PORT"
echo "New Vite port: $NEW_VITE_PORT"
echo "New MongoDB port: $NEW_DB_PORT"
echo ""

# Confirm change
read -p "Do you want to continue with port change? (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "Operation cancelled"
    exit 0
fi

echo ""
echo "Starting port change..."
echo ""

# 1. Stop containers if running
echo "1. Stopping containers..."
if command -v docker-compose &> /dev/null || docker compose version &> /dev/null; then
    if docker compose ps 2>/dev/null | grep -q "Up"; then
        docker compose down
        echo "   ✓ Containers stopped"
    else
        echo "   ℹ No containers running"
    fi
else
    echo "   ⚠ Docker Compose not available, skipping this step"
fi

# 2. Update ports in .env
echo "2. Updating .env file..."
sed -i "s/^APP_PORT=.*/APP_PORT=$NEW_PORT/" .env
sed -i "s/^VITE_PORT=.*/VITE_PORT=$NEW_VITE_PORT/" .env
# Add DB_PORT if doesn't exist, otherwise update it
if ! grep -q "^DB_PORT=" .env; then
    sed -i "/^VITE_PORT=/a DB_PORT=$NEW_DB_PORT" .env
else
    sed -i "s/^DB_PORT=.*/DB_PORT=$NEW_DB_PORT/" .env
fi
echo "   ✓ .env file updated"

# 3. Update .env.example if exists
if [ -f .env.example ]; then
    echo "3. Updating .env.example file..."
    if grep -q "^APP_PORT=" .env.example; then
        sed -i "s/^APP_PORT=.*/APP_PORT=$NEW_PORT/" .env.example
        sed -i "s/^VITE_PORT=.*/VITE_PORT=$NEW_VITE_PORT/" .env.example
        # Add DB_PORT if doesn't exist, otherwise update it
        if ! grep -q "^DB_PORT=" .env.example; then
            sed -i "/^VITE_PORT=/a DB_PORT=$NEW_DB_PORT" .env.example
        else
            sed -i "s/^DB_PORT=.*/DB_PORT=$NEW_DB_PORT/" .env.example
        fi
        echo "   ✓ .env.example file updated"
    else
        echo "   ℹ .env.example does not contain APP_PORT, skipping"
    fi
fi

echo ""
echo "=========================================="
echo "  ✓ Ports changed successfully"
echo "=========================================="
echo ""
echo "Previous application port: $CURRENT_PORT → New port: $NEW_PORT"
echo "Previous Vite port: $CURRENT_VITE_PORT → New port: $NEW_VITE_PORT"
echo "Previous MongoDB port: ${CURRENT_DB_PORT:-27017} → New port: $NEW_DB_PORT"
echo ""
echo "To apply changes, run:"
echo "   make up"
echo ""
echo "Access the application at:"
echo "   http://localhost:$NEW_PORT"
echo ""
