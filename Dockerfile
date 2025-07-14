# Base image with uv and Python 3.10 pre-installed  
FROM ghcr.io/astral-sh/uv:python3.10-bookworm-slim  

# Set working directory  
WORKDIR /app  

# Copy only the necessary files to install dependencies first for better cache efficiency  
COPY uv.lock pyproject.toml README.md ./  

# Install Python dependencies with cache optimization  
RUN --mount=type=cache,target=/root/.cache/uv \
    uv pip install --system .  

# Copy the rest of the application code  
COPY . .  

# Environment variables for uv optimization  
ENV UV_LINK_MODE=copy  
ENV UV_COMPILE_BYTECODE=1  

# Default application environment variables  
ENV PORT=8000  
ENV TRANSPORT=sse  

# Expose the application port (optional but good practice)  
EXPOSE 8000  

# Define default command with environment variable expansion  
ENTRYPOINT ["sh", "-c", "uv run mesh-tool-server --transport ${TRANSPORT} --port ${PORT}"]  
