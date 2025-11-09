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
- Ask for the port (default: 8080)
- Update all configuration files
- Configure Docker containers
- Generate APP_KEY
- Set up database names

**Note**: Vite port is automatically calculated as APP_PORT + 1000

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
```

## Available Commands

```bash
make help              # Show all available commands
make init              # Initialize project (run first!)
make change-port       # Change application port
make up                # Start containers
make down              # Stop containers
make restart           # Restart containers
make shell             # Access PHP container shell
make install           # Install dependencies
make migrate           # Run migrations
make test              # Run backend tests
make test-frontend     # Run frontend tests
```

## Managing Multiple Projects

This boilerplate supports running multiple projects simultaneously on different ports:

### Changing Ports

If you need to run multiple projects at the same time, or if the default port is already in use:

```bash
make change-port
```

This will:
1. Show current port configuration
2. Ask for the new port
3. Stop running containers
4. Update configuration files
5. Ready to restart with new port

Example workflow for running multiple projects:
```bash
# Project 1 on port 8080
cd /path/to/project1
make init  # Choose port 8080
make build && make up

# Project 2 on port 8081
cd /path/to/project2
make init  # Choose port 8081
make build && make up

# Now both projects run simultaneously:
# - Project 1: http://localhost:8080
# - Project 2: http://localhost:8081
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
