# setup functions

# Usage of the add_lines_to_file function
# add_lines_to_file "$file_path" "${lines_to_add[@]}"
add_lines_to_file() {
  local lines_to_add=("$@")
  local file_path="$1"

  # Shift to remove the file_path from the array
  shift

  # Check if each line exists in the file before appending
  for line in "${lines_to_add[@]}"; do
    if ! grep -qF "$line" "$file_path"; then
      echo "$line" | sudo tee -a "$file_path"
    else
      echo "Line already exists: $line"
    fi
  done
  source "$file_path"
}

clone_or_check_repo() {
  local github_repo_url="$1"
  local directory_path="$2"

  # Check if the directory exists
  if [ -d "$directory_path" ]; then
    echo "Directory already exists: $directory_path"
  else
    # Clone the GitHub repository
    git clone "$github_repo_url" "$directory_path"
    echo "Cloned GitHub repository to: $directory_path"
  fi
}
