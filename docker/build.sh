#!/usr/bin/env bash
# Build script for development environment Docker image

set -euo pipefail

build_dev_env() {
    local base_image="$1"
    local tag_name="$2"
    local user_id="${3:-$(id -u)}"
    local group_id="${4:-$(id -g)}"
    local username="${5:-$(whoami)}"
    
    echo "Building development environment:"
    echo "  Base image: $base_image"
    echo "  User ID: $user_id"
    echo "  Group ID: $group_id"
    echo "  Username: $username"
    
    docker build \
        --build-arg BASE_IMAGE="$base_image" \
        --build-arg USER_ID="$user_id" \
        --build-arg GROUP_ID="$group_id" \
        --build-arg USERNAME="$username" \
        -t "$tag_name" \
        .
    
    echo "Build complete: $tag_name"
}

# Build with defaults
build_dev_env "debian:bookworm" "jd/devenv:latest"

echo ""
echo "Usage examples:"
echo ""
echo "# Quick build with current user:"
echo "./build.sh && docker run -it --rm -v \$(pwd):/workspace jd/devenv:latest"
echo ""
echo "# Or call quick_build function:"
echo "quick_build debian:bookworm jd/devenv:latest"
echo ""
echo "# Run with volume mounting for development:"
echo "docker run -it --rm -v \$(pwd):/workspace -w /workspace jd/devenv:latest"
echo ""
echo "# Run with multiple volume mounts:"
echo "docker run -it --rm \\"
echo "  -v \$(pwd):/workspace \\"
echo "  -v \$HOME/.ssh:/home/\$(whoami)/.ssh:ro \\"
echo "  -v \$HOME/.gitconfig:/home/\$(whoami)/.gitconfig:ro \\"
echo "  jd/devenv:latest"
