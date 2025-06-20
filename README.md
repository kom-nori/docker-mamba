# docker-mamba

### 1. セットアップ

```bash
# プロジェクトをクローン
git clone https://github.com/kom-nori/docker-mamba
cd <your-project>

# .devcontainer ディレクトリを作成し、上記3ファイルを配置
mkdir .devcontainer
# Dockerfile, devcontainer.json, setup.sh を配置
```

### 2. VS Code で開発開始

1. VS Code でプロジェクトフォルダを開く
2. 右下に「Reopen in Container」が表示されるのでクリック
3. 初回は 5-10 分でビルド完了
4. 完成！ Python + Node.js 環境で開発開始

### 3. 確認コマンド

```bash
# Python 環境確認
python --version  # Python 3.12.x
mamba list        # インストール済みパッケージ一覧

# Node.js 環境確認
node --version    # v20.x.x
npm --version     # 10.x.x
```
