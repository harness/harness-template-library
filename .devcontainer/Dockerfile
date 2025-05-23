FROM ghcr.io/opentofu/opentofu:1-minimal as tf
FROM quay.io/terraform-docs/terraform-docs:0.20.0 as docs

FROM mcr.microsoft.com/devcontainers/base:bullseye

COPY --from=tf /usr/local/bin/tofu /usr/local/bin/
COPY --from=docs /usr/local/bin/terraform-docs /usr/local/bin/

RUN apt-get update && apt-get install --no-install-recommends -y \
    make=4.3-4.1 \
    curl=7.74.0-1.3+deb11u14 \
    zsh=5.8-6+deb11u1 \
    git=1:2.30.2-1+deb11u4 \
  && rm -rf /var/lib/apt/lists/*

RUN groupadd -f vscode && useradd -m -g vscode vscode || echo "exists"

SHELL ["/bin/zsh", "-c"]

USER vscode

WORKDIR /home/vscode

ENTRYPOINT [ "/bin/zsh" ]