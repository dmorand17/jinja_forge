#!/bin/bash

# Default values
IMAGE_NAME="dmorand17/j2forge"
TAG="latest"
# TAG="dev"

# Function to display usage information
usage() {
    docker run --rm \
        $IMAGE_NAME:$TAG
    exit 1
}

# Parse command-line arguments
while getopts ":t:i:o:h" opt; do
    case ${opt} in
        t )
            template_file=$OPTARG
            ;;
        i )
            input_file=$OPTARG
            ;;
        o )
            output_file=$OPTARG
            ;;
        h )
            usage
            ;;
        \? )
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Check if input file and output directory are provided
if [ -z "${template_file}" ] || [ -z "${input_file}" ]; then
    usage
fi

# Additional arguments to pass to the Docker container
additional_args="$@"

# Run the Docker container
# docker run --rm \
#     -v "$(pwd)/${input_file}:/app/input_file" \
#     -v "$(pwd)/${output_file}:/app/output_file" \
#     $IMAGE_NAME:$TAG \
#     -t ${template_file} \
#     -i ${input_file}

# Build command
CMD="docker run --rm"
CMD+=" -v \"$(pwd)/${input_file}:/app/input_file\""
CMD+=" -v \"$(pwd)/${template_file}:/app/template_file\""

if [ -n "${output_file}" ]; then
    touch "$(pwd)/${output_file}"
    CMD+=" -v \"$(pwd)/${output_file}:/app/output_file\""
fi

CMD+=" $IMAGE_NAME:$TAG"
CMD+=" -t /app/template_file"
CMD+=" -i /app/input_file"

if [ -n "${output_file}" ]; then
    CMD+=" -o /app/output_file"
fi

# Add any extra arguments
for arg in "${additional_args[@]}"; do
    CMD+=" $arg"
done

# echo "[+] Executing command: '$CMD'"
eval $CMD
