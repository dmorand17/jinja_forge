import json
import pathlib
from pprint import pp

import click
import jinja2
import yaml

"""
This script will take a yaml file and jinja template and render the yaml file into a jinja template.
"""


def check_file_type(file_path):
    with open(file_path, "r") as file:
        content = file.read()

    # Try parsing as JSON
    try:
        json.loads(content)
        return "JSON"
    except json.JSONDecodeError:
        pass

    # Try parsing as YAML
    try:
        yaml.safe_load(content)
        return "YAML"
    except yaml.YAMLError:
        pass

    # If neither parsing succeeded
    return "Unknown"


def load_data(input_file):
    """
    Loads the input file based on the file extension (JSON or YAML)
    """
    loader_map = {"JSON": json.load, "YAML": yaml.safe_load}

    file_type = check_file_type(input_file)
    # file_ext = pathlib.Path(input_file).suffix

    if file_type not in loader_map:
        raise ValueError("Unsupported file format")

    with open(input_file, "r") as f:
        return loader_map[file_type](f)


# Add a click command
@click.command(no_args_is_help=True)
@click.option(
    "--input",
    "-i",
    required=True,
    type=click.Path(exists=True, dir_okay=False),
    help="Input yaml/json file",
)
@click.option(
    "--template",
    "-t",
    required=True,
    type=click.Path(exists=True, dir_okay=False),
    help="Jinja template to use for rendering",
)
@click.option(
    "--output",
    "-o",
    required=False,
    type=click.Path(exists=False, dir_okay=False),
    help="Output file",
)
def render_template(input, template, output):
    """
    Simple program that renders jinja template
    """

    data = load_data(input)
    # Render the template
    template_text = pathlib.Path(template).read_text()
    env = jinja2.Environment(loader=jinja2.BaseLoader())
    template = env.from_string(template_text)
    rendered_template = template.render(data)

    if output:
        # Write the output file
        print(f"[-] Writing output to {output}")
        with open(output, "w") as f:
            f.write(rendered_template)
    else:
        print(f"{rendered_template}", end="")


if __name__ == "__main__":
    render_template()
    print("[-] Finished!")
