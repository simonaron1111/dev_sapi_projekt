# Sapi projekt development environment
## Prerequisites
- Docker Desktop (https://www.docker.com/products/docker-desktop/)
- Git

## Download
```bash
git clone git@github.com:simonaron1111/dev_sapi_projekt.git --recurse-submodules
```

## Build and run
```bash
docker-compose up
```

## Access the application
Navigate to `http://localhost:4080` in your browser.
The backend is available at `http://localhost:4080/api/furniture/all`.
The frontend is available at `http://localhost:4080/draw`.

## Run end-to-end tests
```bash
docker-compose --profile e2e up furniture_frontend_e2e
```

## Run backend tests
```bash
docker-compose --profile test up furniture_backend_test
```