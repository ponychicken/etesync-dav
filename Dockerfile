FROM python:3.10

ENV ETESYNC_DATA_DIR "/data"
ENV ETESYNC_SERVER_HOSTS "0.0.0.0:37358,[::]:37358"

# Install Rust and create an application virtual environment with uv
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN pip install uv && uv venv /opt/venv
ENV VIRTUAL_ENV="/opt/venv"
ENV PATH="/opt/venv/bin:/root/.cargo/bin:${PATH}"

# Make this file a build dep for the next steps
COPY requirements.txt /app/
RUN uv pip install -r /app/requirements.txt --compile

# Install etebase from git
RUN uv pip install "git+https://github.com/etesync/etebase-py.git"

COPY . /app
RUN uv pip install /app

RUN set -ex ;\
        useradd etesync ;\
        mkdir -p /data ;\
        chown -R etesync: /data

VOLUME /data
EXPOSE 37358

USER etesync

ENTRYPOINT ["etesync-dav"]
