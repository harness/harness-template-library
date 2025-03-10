FROM ghcr.io/opentofu/opentofu:latest as tf
FROM quay.io/terraform-docs/terraform-docs as docs

FROM mcr.microsoft.com/devcontainers/base:bullseye

COPY --from=tf /usr/local/bin/tofu /usr/local/bin/
COPY --from=docs /usr/local/bin/terraform-docs /usr/local/bin/

RUN apt-get update && apt-get install -y \
    make \
    curl \
    zsh \
    git \
  && rm -rf /var/lib/apt/lists/*

USER vscode

WORKDIR /home/vscode

RUN sudo chsh -s /bin/zsh vscode

ENTRYPOINT [ "/bin/zsh" ]

