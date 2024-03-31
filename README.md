# Jinja Forge

Simple project to generate output from [jinja](https://palletsprojects.com/p/jinja/) templates.

## ✏️ Getting Started

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
  -i, --input FILE     Input yaml/json file  [required]
  -t, --template FILE  Jinja template to use for rendering  [required]
  -o, --output FILE    Output file
  --help               Show this message and exit.
```

## Examples

list some examples here of calling the script

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
