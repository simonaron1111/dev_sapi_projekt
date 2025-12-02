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