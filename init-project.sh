#!/bin/bash

# Boilerplate initialization script for Laravel + Vue + TypeScript + MongoDB
# This script configures the project with a custom name

set -e

echo "=========================================="
echo "  Boilerplate Initialization"
echo "  Laravel 12 + Vue 3 + TypeScript + MongoDB"
echo "=========================================="
echo ""

# Request project name
read -p "Enter project name (e.g., MyProject): " PROJECT_NAME

# Validate not empty
if [ -z "$PROJECT_NAME" ]; then
    echo "Error: Project name cannot be empty"
    exit 1
fi

# Convert to snake_case for container and database names
PROJECT_SNAKE=$(echo "$PROJECT_NAME" | sed 's/\([A-Z]\)/_\1/g' | sed 's/^_//' | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr '-' '_')

# Function to check if port is in use
check_port() {
    local port=$1
    if command -v lsof &> /dev/null; then
        lsof -i ":$port" > /dev/null 2>&1
        return $?
    elif command -v netstat &> /dev/null; then
        netstat -tuln | grep ":$port " > /dev/null 2>&1
        return $?
    else
        # If neither command is available, assume port is free
        return 1
    fi
}

# Function to suggest next free port
suggest_free_port() {
    local start_port=$1
    local test_port=$start_port
    while [ $test_port -le 65535 ]; do
        if ! check_port $test_port; then
            echo $test_port
            return
        fi
        test_port=$((test_port + 1))
    done
    echo $start_port
}

# Request application port
echo ""
DEFAULT_APP_PORT=8080
if check_port $DEFAULT_APP_PORT; then
    SUGGESTED_PORT=$(suggest_free_port 8081)
    echo "⚠️  Warning: Port $DEFAULT_APP_PORT is already in use!"
    echo "Suggested free port: $SUGGESTED_PORT"
    read -p "Enter web application port (default $SUGGESTED_PORT): " APP_PORT
    APP_PORT=${APP_PORT:-$SUGGESTED_PORT}
else
    read -p "Enter web application port (default $DEFAULT_APP_PORT): " APP_PORT
    APP_PORT=${APP_PORT:-$DEFAULT_APP_PORT}
fi

# Validate port is a number
if ! [[ "$APP_PORT" =~ ^[0-9]+$ ]]; then
    echo "Error: Port must be a number"
    exit 1
fi

# Validate port range
if [ "$APP_PORT" -lt 1024 ] || [ "$APP_PORT" -gt 65535 ]; then
    echo "Error: Port must be between 1024 and 65535"
    exit 1
fi

# Check if selected port is in use
if check_port $APP_PORT; then
    echo "⚠️  Warning: Port $APP_PORT is already in use by another process!"
    echo "You may encounter conflicts. Consider using a different port."
    read -p "Continue anyway? (y/N): " continue_anyway
    if [[ ! "$continue_anyway" =~ ^[Yy]$ ]]; then
        echo "Initialization cancelled."
        exit 1
    fi
fi

# Request Vite port
echo ""
DEFAULT_VITE_PORT=$((APP_PORT + 1000))
if check_port $DEFAULT_VITE_PORT; then
    SUGGESTED_VITE_PORT=$(suggest_free_port $((APP_PORT + 1000)))
    echo "⚠️  Warning: Calculated Vite port $DEFAULT_VITE_PORT is already in use!"
    echo "Suggested free port: $SUGGESTED_VITE_PORT"
    read -p "Enter Vite HMR port (default $SUGGESTED_VITE_PORT): " VITE_PORT
    VITE_PORT=${VITE_PORT:-$SUGGESTED_VITE_PORT}
else
    read -p "Enter Vite HMR port (default $DEFAULT_VITE_PORT): " VITE_PORT
    VITE_PORT=${VITE_PORT:-$DEFAULT_VITE_PORT}
fi

# Validate port is a number
if ! [[ "$VITE_PORT" =~ ^[0-9]+$ ]]; then
    echo "Error: Port must be a number"
    exit 1
fi

# Validate port range
if [ "$VITE_PORT" -lt 1024 ] || [ "$VITE_PORT" -gt 65535 ]; then
    echo "Error: Port must be between 1024 and 65535"
    exit 1
fi

# Check if selected Vite port is in use
if check_port $VITE_PORT; then
    echo "⚠️  Warning: Port $VITE_PORT is already in use by another process!"
    echo "You may encounter conflicts. Consider using a different port."
    read -p "Continue anyway? (y/N): " continue_vite
    if [[ ! "$continue_vite" =~ ^[Yy]$ ]]; then
        echo "Initialization cancelled."
        exit 1
    fi
fi

# Request MongoDB port
echo ""
DEFAULT_DB_PORT=27017
if check_port $DEFAULT_DB_PORT; then
    SUGGESTED_DB_PORT=$(suggest_free_port 27018)
    echo "⚠️  Warning: MongoDB port $DEFAULT_DB_PORT is already in use!"
    echo "Suggested free port: $SUGGESTED_DB_PORT"
    read -p "Enter MongoDB port (default $SUGGESTED_DB_PORT): " DB_PORT
    DB_PORT=${DB_PORT:-$SUGGESTED_DB_PORT}
else
    read -p "Enter MongoDB port (default $DEFAULT_DB_PORT): " DB_PORT
    DB_PORT=${DB_PORT:-$DEFAULT_DB_PORT}
fi

# Validate port is a number
if ! [[ "$DB_PORT" =~ ^[0-9]+$ ]]; then
    echo "Error: Port must be a number"
    exit 1
fi

# Validate port range
if [ "$DB_PORT" -lt 1024 ] || [ "$DB_PORT" -gt 65535 ]; then
    echo "Error: Port must be between 1024 and 65535"
    exit 1
fi

# Check if selected MongoDB port is in use
if check_port $DB_PORT; then
    echo "⚠️  Warning: Port $DB_PORT is already in use by another process!"
    echo "You may encounter conflicts. Consider using a different port."
    read -p "Continue anyway? (y/N): " continue_db
    if [[ ! "$continue_db" =~ ^[Yy]$ ]]; then
        echo "Initialization cancelled."
        exit 1
    fi
fi

echo ""
echo "Configuring project: $PROJECT_NAME"
echo "Technical name: $PROJECT_SNAKE"
echo "Application port: $APP_PORT"
echo "Vite port: $VITE_PORT"
echo "MongoDB port: $DB_PORT"
echo ""

# 1. Update .env
echo "1. Configuring environment variables..."
if [ -f .env ]; then
    sed -i "s/APP_NAME=.*/APP_NAME=$PROJECT_NAME/" .env
    sed -i "s/DB_CONNECTION=.*/DB_CONNECTION=mongodb/" .env
    sed -i "s/# DB_HOST=.*/DB_HOST=mongodb/" .env
    sed -i "s/# DB_PORT=.*/DB_PORT=27017/" .env
    sed -i "s/# DB_DATABASE=.*/DB_DATABASE=$PROJECT_SNAKE/" .env
    sed -i "s/# DB_USERNAME=.*/DB_USERNAME=/" .env
    sed -i "s/# DB_PASSWORD=.*/DB_PASSWORD=/" .env

    # Add Docker variables if they don't exist
    if ! grep -q "APP_PORT" .env; then
        echo "" >> .env
        echo "# Docker" >> .env
        echo "APP_PORT=$APP_PORT" >> .env
        echo "VITE_PORT=$VITE_PORT" >> .env
        echo "DB_PORT=$DB_PORT" >> .env
    else
        sed -i "s/APP_PORT=.*/APP_PORT=$APP_PORT/" .env
        sed -i "s/VITE_PORT=.*/VITE_PORT=$VITE_PORT/" .env
        # Add DB_PORT if doesn't exist in Docker section
        if ! grep -q "^DB_PORT=" .env; then
            sed -i "/^VITE_PORT=/a DB_PORT=$DB_PORT" .env
        else
            sed -i "s/^DB_PORT=.*/DB_PORT=$DB_PORT/" .env
        fi
    fi
else
    echo "Error: .env file not found"
    exit 1
fi

# 2. Update .env.example
echo "2. Updating .env.example..."
if [ -f .env.example ]; then
    sed -i "s/APP_NAME=.*/APP_NAME=$PROJECT_NAME/" .env.example
    sed -i "s/DB_CONNECTION=.*/DB_CONNECTION=mongodb/" .env.example
    sed -i "s/# DB_HOST=.*/DB_HOST=mongodb/" .env.example
    sed -i "s/# DB_PORT=.*/DB_PORT=27017/" .env.example
    sed -i "s/# DB_DATABASE=.*/DB_DATABASE=$PROJECT_SNAKE/" .env.example

    # Add Docker variables if they don't exist
    if ! grep -q "APP_PORT" .env.example; then
        echo "" >> .env.example
        echo "# Docker" >> .env.example
        echo "APP_PORT=8080" >> .env.example
        echo "VITE_PORT=5173" >> .env.example
        echo "DB_PORT=27017" >> .env.example
    fi
fi

# 3. Update docker-compose.yml
echo "3. Configuring Docker Compose..."
if [ -f docker-compose.yml ]; then
    sed -i "s/container_name: bambu_/container_name: ${PROJECT_SNAKE}_/g" docker-compose.yml
    sed -i "s/bambu_network/${PROJECT_SNAKE}_network/g" docker-compose.yml
    sed -i "s/DB_DATABASE:-bambu/DB_DATABASE:-$PROJECT_SNAKE/g" docker-compose.yml
    sed -i "s/MONGO_INITDB_DATABASE: .*bambu/MONGO_INITDB_DATABASE: \${DB_DATABASE:-$PROJECT_SNAKE}/" docker-compose.yml
fi

# 4. Generate APP_KEY
echo "4. Generating APP_KEY..."
if [ ! -f artisan ]; then
    echo "Error: artisan file not found"
    exit 1
fi

# Generate key without running composer (due to missing extensions)
php -r "echo 'base64:' . base64_encode(random_bytes(32));" | sed 's/^/APP_KEY=/' | sed -i "s/APP_KEY=.*/$(cat)/" .env

echo ""
echo "=========================================="
echo "  ✓ Project configured successfully"
echo "=========================================="
echo ""
echo "Project name: $PROJECT_NAME"
echo "Technical name: $PROJECT_SNAKE"
echo "Database: $PROJECT_SNAKE"
echo ""
echo "Ports Configuration:"
echo "-------------------"
echo "• Application:  http://localhost:$APP_PORT"
echo "• Vite HMR:     http://localhost:$VITE_PORT"
echo "• MongoDB:      mongodb://localhost:$DB_PORT"
echo ""
echo "Containers: ${PROJECT_SNAKE}_app, ${PROJECT_SNAKE}_nginx, ${PROJECT_SNAKE}_mongodb, ${PROJECT_SNAKE}_vite"
echo ""
echo "=========================================="
echo "  Next steps:"
echo "=========================================="
echo ""
echo "1. Build and start Docker containers:"
echo "   make build && make up"
echo ""
echo "2. Install dependencies (will also fix permissions):"
echo "   make install"
echo ""
echo "3. Run migrations:"
echo "   make migrate"
echo ""
echo "4. Access the application at:"
echo "   ⭐ http://localhost:$APP_PORT ⭐"
echo ""
echo "⚠️  IMPORTANT: Make sure to access the correct port!"
echo "   Your application is on port $APP_PORT"
if check_port 8080 && [ "$APP_PORT" != "8080" ]; then
    echo "   (Note: Port 8080 has a different application)"
fi
echo ""
echo "Note: If you encounter permission issues, run: make fix-permissions"
echo ""
echo "See more available commands with: make help"
echo ""
