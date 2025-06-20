#!/usr/bin/env bash
set -euo pipefail                               # FIX: -u と pipefail 追加

# conda / mamba コマンドの PATH を保証
export PATH="/opt/conda/bin:$PATH"

command -v mamba >/dev/null || { echo "[setup.sh] mamba not found"; exit 1; }

# Python パッケージを最小限インストール（必要なら適宜追加）
mamba install -qy -c conda-forge \
    numpy pandas matplotlib scikit-learn jupyterlab ipykernel

# キャッシュ削除でイメージをスリム化
mamba clean -afy

# .env 自動生成（存在しない場合のみ）
ENV_PATH="src/.env"                             # FIX: リポジトリ相対

