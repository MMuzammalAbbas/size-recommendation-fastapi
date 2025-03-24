# Use an official Python image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy all files to the container
COPY . /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set environment variables for Matplotlib, cache, and rembg models
ENV MPLCONFIGDIR=/tmp/matplotlib
ENV XDG_CACHE_HOME=/tmp
ENV U2NET_HOME=/tmp/u2net  
# Ensure rembg can download models to a writable directory

# Ensure necessary directories exist and have the right permissions
RUN mkdir -p /tmp/matplotlib /tmp/numba_cache /tmp/u2net && \
    chmod -R 777 /tmp/matplotlib /tmp/numba_cache /tmp/u2net

# Expose port 7860 (Hugging Face default)
EXPOSE 7860

# Run FastAPI using Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]