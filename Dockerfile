FROM ubuntu:24.04

# Informative here: expose through docker run -p 8888:8888
EXPOSE 8888

# Install with apt and clean-up, create an env python
RUN apt-get update  \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       ca-certificates curl wget build-essential \
       python3 python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/* \
    && python3 -m venv /opt/venv

# Install python
ENV PATH="/opt/venv/bin:$PATH"
RUN echo "source /opt/venv/bin/activate" >> /root/.bashrc \
    && pip install --no-cache-dir jupyterlab notebook matplotlib \
    && python3 -m pip cache purge || true


# Set current directory in the container
WORKDIR /work

# Default command when docker run is executed
CMD ["bash", "-lc", "jupyter lab --ip=0.0.0.0 --no-browser --allow-root"]
