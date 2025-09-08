#!/bin/sh

commands_and_expected_outputs='
  date +"%Z"#UTC
  locale | awk -F= "/LC_COLLATE/{print \$2}" | tr -d \"#en_US.UTF-8
'

case "$DOCKER_DEFAULT_PLATFORM" in
  linux/amd64) expected_arch="x86_64" ;;
  linux/arm64) expected_arch="aarch64" ;;
  *) echo "Unknown platform $DOCKER_DEFAULT_PLATFORM"; exit 3 ;;
esac

commands_and_expected_outputs="${commands_and_expected_outputs}uname -m#$expected_arch"

# Split by newline.
IFS="
"
for command_and_output in $commands_and_expected_outputs; do
  # Split the command and expected output using the "#" separator.
  command=$(echo "$command_and_output" | cut -d "#" -f 1)
  expected_output=$(echo "$command_and_output" | cut -d "#" -f 2)

  output=$(eval "docker run --rm -t "${CI_REGISTRY_IMAGE}:${TAG}" $command")

  if [ $? -ne 0 ]; then
    echo "Error: \"$command\" failed"
    exit 1
  fi

  # Remove any trailing whitespace characters from the output.
  output=$(echo "$output" | sed 's/[[:space:]]*$//')

  if [ "$output" != "$expected_output" ]; then
    echo "Error: Output for \"$command\" does not match expected output"
    echo "Actual output: $output"
    echo "Expected output: $expected_output"
    exit 2
  fi
done

exit 0
