# Cinna Mesh Agent MCP Server

A Model Context Protocol (MCP) server that connects to the Cinna Mesh APIs, enabling Claude to interact with advanced blockchain and Web3 tools.

Cinna Mesh is an open, modular network of specialized AI agents designed for tasks like token intelligence, smart contract analysis, market tracking, and onchain discovery. This system allows developers and researchers to plug into a growing catalog of interoperable agents across the decentralized ecosystem.

---

## Features

- Native integration with the Cinna Mesh API
- Preloaded agents for Web3, crypto, and onchain data analysis
- SSE and stdio transport supported
- Compatible with Claude (Cursor, Claude Desktop, and others)
- Unified access via one API key across all supported services

You can build custom MCP servers on demand through the Cinna Mesh MCP Portal. Select your preferred agents and deploy personalized swarms for real-time applications.

---

## Hosted SSE Endpoint

We provide a public SSE endpoint:

```
https://sequencer-v2.cinnazk.app/mcp/sse
```

This endpoint includes agents such as:

- CoinGeckoTokenInfoAgent
- ElfaTwitterIntelligenceAgent
- ExaSearchAgent
- DexScreenerTokenInfoAgent
- ZerionWalletAnalysisAgent

This is a shared server, so performance may vary depending on load.

---

## Requirements

- Python 3.10 or higher
- UV package manager (recommended) or Docker
- Cinna API key (obtain free access at https://cinnazk.app)

---

## Installation

### Using UV

```bash
git clone https://github.com/cinna-network/cinna-mesh-mcp-server.git
cd cinna-mesh-mcp-server
uv pip install -e .
```

### Using Docker

```bash
git clone https://github.com/cinna-network/cinna-mesh-mcp-server.git
cd cinna-mesh-mcp-server
docker build -t mesh-tool-server .
```

---

## Usage

### Option 1: stdio Transport (for Claude Desktop)

Update your `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "cinna-mesh-agent": {
      "command": "uv",
      "args": [
        "--directory",
        "/path/to/cinna-mesh-mcp-server/mesh_mcp_server",
        "run",
        "mesh-tool-server"
      ],
      "env": {
        "CINNA_API_KEY": "your-api-key-here"
      }
    }
  }
}
```

Or with Docker:

```json
{
  "mcpServers": {
    "mesh-agent": {
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "-i",
        "-e", "TRANSPORT=stdio",
        "-e", "CINNA_API_KEY=your-api-key-here",
        "mesh-tool-server"
      ]
    }
  }
}
```

Replace the placeholders with your actual path and key.

---

### Option 2: SSE Transport (for Cursor)

Create and configure your `.env` file:

```bash
cp .env.example .env
```

Inside `.env`:

```
CINNA_API_KEY=your-api-key-here
```

Start the server:

**Using UV:**

```bash
uv run mesh-tool-server --transport sse --port 8000
```

**Using Docker:**

```bash
docker run -p 8000:8000 -e PORT=8000 mesh-tool-server
```

In Cursor, set MCP Server URL:  
```
http://0.0.0.0:8000/sse
```

---

## Available Tools

Explore all supported tools at:

- https://mesh.cinnazk.app/metadata.json  
- https://mcp.cinnazk.app/

---

## Default Agents

```python
DEFAULT_AGENTS = [
    "CoinGeckoTokenInfoAgent",
    "DexScreenerTokenInfoAgent",
    "ElfaTwitterIntelligenceAgent",
    "ExaSearchAgent",
    "FirecrawlSearchAgent",
    "GoplusAnalysisAgent",
    "NewAgent"
]
```

To customize, edit the `Config` class in `server.py` and modify the list above.

---

## License

This project is licensed under the MIT License. You are free to use, modify, and distribute this software under the terms outlined in the license.
