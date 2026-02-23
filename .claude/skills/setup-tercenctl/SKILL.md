# Setup tercenctl & MCP Server

Install (or update) the `tercenctl` CLI and configure the MCP server for Claude Code.

---

## What this does

1. Downloads the latest `tercenctl` binary from GitHub releases (`tercen/sci`)
2. Installs it to `~/.local/bin/tercenctl`
3. Creates `.mcp.json` in the project root for Claude Code MCP integration

---

## Steps

### 1. Download latest tercenctl

```bash
# Get the latest release tag
LATEST_TAG=$(gh release list --repo tercen/sci --limit 1 | awk '{print $3}')

# Download the linux binary
rm -f /tmp/tercenctl-linux-x64
gh release download "$LATEST_TAG" --repo tercen/sci --pattern "tercenctl-linux-x64" --dir /tmp/

# Install
chmod +x /tmp/tercenctl-linux-x64
mv /tmp/tercenctl-linux-x64 ~/.local/bin/tercenctl
```

Verify installation:

```bash
tercenctl --help
```

### 2. Create `.mcp.json` in the project root

Write this file at the root of the current project (next to `CLAUDE.md`):

```json
{
  "mcpServers": {
    "tercen-sci-local": {
      "type": "stdio",
      "command": "tercenctl",
      "args": [
        "mcp",
        "--transport",
        "stdio"
      ],
      "env": {}
    }
  }
}
```

### 3. Confirm

- Print the installed tercenctl version info (`tercenctl --help` first line)
- Print the `.mcp.json` path
- Tell the user to restart Claude Code for the MCP server to be available
