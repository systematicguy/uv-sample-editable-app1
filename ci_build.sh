# assume uv is installed

# eliminate editable devclone dependencies because they are not checked out in the pipeline
uvx --from toml-cli toml set --toml-path pyproject.toml "dependency-groups.devclone" --to-array "[]"

uv lock
uv sync --locked --no-install-project --no-group devclone --group exact

# if we have pytest:
uv run --no-sync pytest