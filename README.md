# Laravel + Vue + TypeScript + MongoDB Boilerplate

Modern full-stack boilerplate for building web applications with Laravel 12, Vue 3, TypeScript, and MongoDB.

## Features

- **Backend**: Laravel 12 with MongoDB support
- **Frontend**: Vue 3 with TypeScript
- **State Management**: Pinia
- **Routing**: Vue Router with authentication guards
- **Authentication**: JWT-based authentication
- **Styling**: Tailwind CSS 4
- **Build Tool**: Vite with HMR support
- **Testing**: PHPUnit (backend) + Vitest (frontend)
- **Docker**: Complete Docker setup for development and production
- **Code Quality**: ESLint, Prettier, Laravel Pint

## Stack

- **PHP**: 8.2+
- **Laravel**: 12.x
- **Vue**: 3.5.x
- **TypeScript**: 5.7.x
- **MongoDB**: 7.0
- **Node**: 20.x
- **Vite**: 7.x

## Prerequisites

- Docker and Docker Compose
- Git

## Quick Start

### 1. Initialize the Project

Run the initialization script to configure your project name and settings:

```bash
make init
```

This script will:
- Ask for your project name
- Ask for the application port (default: 8080)
- Ask for the Vite HMR port (default: APP_PORT + 1000)
- Ask for the MongoDB port (default: 27017)
- **Automatically detect ports already in use** and suggest free alternatives
- Update all configuration files
- Configure Docker containers
- Generate APP_KEY
- Set up database names

**Note**: The script suggests APP_PORT + 1000 for Vite by default, but you can customize it

### 2. Build and Start Docker Containers

```bash
make build
make up
```

### 3. Install Dependencies

```bash
make install
```

### 4. Run Migrations

```bash
make migrate
```

### 5. Access the Application

The application will be available at the port you configured during initialization:

- **Application**: http://localhost:YOUR_PORT (default: 8080)
- **Vite HMR**: http://localhost:YOUR_PORT+1000 (default: 5173)

To check your configured ports, run:
```bash
grep APP_PORT .env
grep VITE_PORT .env
grep DB_PORT .env
```

**⚠️ IMPORTANT**: Make sure to access the correct port! If you have multiple projects running, each will have a different port. The `make up` command displays the correct URL for your application.

## Available Commands

```bash
make help              # Show all available commands
make init              # Initialize project (run first!)
make change-port       # Change application port
make verify            # Run automated verification tests
make up                # Start containers
make down              # Stop containers
make restart           # Restart containers
make shell             # Access PHP container shell
make install           # Install dependencies (also fixes permissions)
make migrate           # Run migrations
make fix-permissions   # Fix storage and cache permissions
make test              # Run backend tests
make test-frontend     # Run frontend tests
```

## Automated Verification

To verify that the boilerplate is working correctly with proper port configuration:

```bash
make verify
```

This automated script will:
1. Check currently running containers and ports in use
2. Automatically select free ports for the application
3. Initialize and start the project with those ports
4. Run comprehensive tests:
   - MongoDB connection and CRUD operations (insert, query, update, delete)
   - Web server response and HTML rendering
   - Vite HMR server functionality
   - Port configuration verification
5. Display a detailed test report
6. **Automatically clean up**: Remove all containers, volumes, and restore original .env

The script ensures that multiple projects can run simultaneously without port conflicts and leaves your system clean after verification.

## Managing Multiple Projects

This boilerplate supports running multiple projects simultaneously on different ports:

### Port Detection

The initialization script (`make init`) automatically detects if ports are already in use and suggests free alternatives. This prevents conflicts when running multiple projects.

### Changing Ports

If you need to run multiple projects at the same time, or if the default port is already in use:

```bash
make change-port
```

This will:
1. Show current port configuration (app, vite, and MongoDB)
2. Ask for the new application port
3. Ask for the new Vite HMR port
4. Ask for the new MongoDB port
5. Stop running containers
6. Update configuration files
7. Ready to restart with new ports

### Example Workflow

Running multiple projects simultaneously:
```bash
# Project 1 on port 8080, Vite 9080, MongoDB 27017
cd /path/to/project1
make init
# → App port: 8080
# → Vite port: 9080 (default 9080)
# → MongoDB port: 27017
make build && make up
# Access: http://localhost:8080

# Project 2 on port 9090, Vite 10090, MongoDB 27019
cd /path/to/project2
make init
# → App port: 9090
# → Vite port: 10090 (default 10090)
# → MongoDB port: 27019
make build && make up
# Access: http://localhost:9090

# Now both projects run simultaneously without port conflicts:
# - Project 1: App 8080, Vite 9080, MongoDB 27017
# - Project 2: App 9090, Vite 10090, MongoDB 27019
```

### ⚠️ Common Issue: Wrong Port

If you see content from another project, you're likely accessing the wrong port. Always check the output of `make up` to see the correct URL, or run:
```bash
grep APP_PORT .env
```

## Project Structure

```
├── resources/js/          # Vue application
│   ├── components/        # Vue components
│   ├── pages/            # Page components
│   ├── router/           # Vue Router config
│   ├── stores/           # Pinia stores
│   └── types/            # TypeScript types
├── docker/               # Docker configuration
├── routes/               # Laravel routes
└── app/                  # Laravel application
```

## License

Open-source software licensed under the [MIT license](https://opensource.org/licenses/MIT).
