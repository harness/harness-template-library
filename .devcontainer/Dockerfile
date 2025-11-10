FROM ghcr.io/opentofu/opentofu:1-minimal AS tf
FROM quay.io/terraform-docs/terraform-docs:0.20.0 AS docs

FROM mcr.microsoft.com/devcontainers/base:bookworm

COPY --from=tf /usr/local/bin/tofu /usr/local/bin/
COPY --from=docs /usr/local/bin/terraform-docs /usr/local/bin/

RUN apt-get update && apt-get install --no-install-recommends -y \
    make=4.3-4.1\
    curl=7.88.1-10+deb12u14\
    zsh=5.9-4+b7\
    git=1:2.39.5-0+deb12u2\
    ca-certificates=20230311+deb12u1\
    build-essential=12.9\
    libssl3=3.0.17-1~deb12u3\
  && rm -rf /var/lib/apt/lists/*

RUN groupadd -f vscode && useradd -m -g vscode vscode || echo "exists"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV MISE_DATA_DIR="/mise"
ENV MISE_CONFIG_DIR="/mise"
ENV MISE_CACHE_DIR="/mise/cache"
ENV MISE_INSTALL_PATH="/usr/local/bin/mise"
ENV PATH="/mise/shims:$PATH"

RUN \
    curl https://mise.run | sh;\
    mkdir -p ${MISE_CACHE_DIR};\
    chmod -R 777 ${MISE_CACHE_DIR}
SHELL ["/bin/zsh", "-c"]

USER vscode

WORKDIR /home/vscode

ENTRYPOINT [ "/bin/zsh" ]
