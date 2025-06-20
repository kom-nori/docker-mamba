# Dockerfile
# FIX: Ubuntu 22.04 に固定して再現性を確保（devcontainers が公式で提供）
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# root 権限で追加パッケージをインストール
USER root

# FIX: 開発でよく使うビルドツールもまとめて導入
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y upgrade \
    && apt-get -y install --no-install-recommends \
         curl bzip2 ca-certificates git procps build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# micromamba を単体バイナリで導入
ENV MAMBA_ROOT_PREFIX=/opt/conda
ENV PATH=$MAMBA_ROOT_PREFIX/bin:$PATH

# FIX: snakepit の最新ビルドをそのまま展開
RUN curl -L https://micromamba.snakepit.net/api/micromamba/linux-64/latest \
    | tar -xvj -C /usr/local/bin --strip-components=1 bin/micromamba \
    # FIX: base 環境を作成し、mamba も同時に入れる
    && micromamba create -y -p $MAMBA_ROOT_PREFIX python=3.12 mamba \
    && micromamba clean -a -y

# VS Code DevContainer 既定の vscode ユーザーに権限を渡す
RUN chown -R vscode:vscode $MAMBA_ROOT_PREFIX

# Node.js & npm を追加（LTS 20.x）
ENV NODE_VERSION=20

RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn

USER vscode
# デフォルトシェル
CMD ["bash"]
