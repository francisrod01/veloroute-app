# FILE: ./Makefile
# Utility script to streamline development workflows and container management.

# Initialise the project by fetching dependencies and pulling Docker images
setup:
	flutter pub get
	docker-compose pull

# Run the full suite of automated tests for the Flutter application
test:
	flutter test

# Start the PostgreSQL and PostgREST backend services in detached mode
run-backend:
	docker-compose up -d

# Deploy the application to the default connected device (e.g., S24 Ultra or macOS Desktop)
run-app:
	flutter run

# Comprehensive development command: Reset volumes, start backend, and launch app
dev-reset:
	docker-compose down -v
	docker-compose up -d
	flutter run
