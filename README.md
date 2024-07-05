# Jinja Forge

Simple project to generate output from [jinja](https://palletsprojects.com/p/jinja/) templates.

## 🏁 Getting Started

Add j2_forge.sh to PATH

example of adding to ~/.local/bin which is typically on PATH:

```bash
ln -s /path/to/checkout/j2_forge.sh ~/.local/bin/j2_forge.sh
```

## 🚀 Usage

```
Usage: main.py [OPTIONS]

  Simple program that renders jinja template

Options:
  -t, --template FILE  Jinja template to use for rendering  [required]
  -i, --input FILE     Input yaml/json file  [required]
  -o, --output FILE    Output file
  --help               Show this message and exit.
```

## 🧪 Examples

Testing the samples

_Creating a cloudformation template and output to console_

```bash
./j2_forge.sh -i samples/cloudformation/buckets.yaml -t samples/cloudformation/cf-template.j2
```

_Creating a cloudformation template and output to file_

```bash
./j2_forge.sh -i samples/cloudformation/buckets.yaml -t samples/cloudformation/cf-template.j2 -o template.yml
```

## 🛠️ Development

1/ Create a virtual environment

```bash
python3 -m venv .venv
source .venv/bin/activate
```

2/ Install requirements

```bash
pip install -r requirements.txt
```

### Packages

- [click](https://click.palletsprojects.com/en/8.1.x/)
- [jinja2](https://jinja.palletsprojects.com/en/3.1.x/)

### Image development

```bash
docker build -f Dockerfile.dev -t j2_forge:dev .
docker push j2_forge:dev <username>/j2forge:dev
```

OR

```bash
DOCKERHUB_USERNAME=<username>
make build-and-push-dev DOCKER_IMAGE_NAME=$DOCKERHUB_USERNAME/j2forge \
```

## 🛠️ Build

1/ Login to dockerhub

docker users

```bash
docker login -u <username> -p <password>
```

podman users

```bash
podman login docker.io
```

2/ Build image

```bash
docker build -t j2_forge .
```

3/ Push image

```bash
DOCKERHUB_USERNAME=<username>
docker push $DOCKERHUB_USERNAME/j2forge
```

### Using Makefile

```bash
DOCKERHUB_USERNAME=<username>
make build-and-push DOCKER_IMAGE_NAME=$DOCKERHUB_USERNAME/j2forge \
```
