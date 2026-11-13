#!/usr/bin/env bash
# 把当前目录的代码推送到 GitHub 新建仓库 blueos-periodic-table
# 用法：
#   1) 已登录 gh：bash push-to-github.sh
#   2) 未登录 gh：GH_TOKEN=ghp_xxx bash push-to-github.sh
set -euo pipefail

REPO="${REPO:-blueos-periodic-table}"
VISIBILITY="${VISIBILITY:-public}"   # public | private
cd "$(dirname "$0")"

if ! command -v git >/dev/null; then echo "缺少 git"; exit 1; fi
if ! command -v gh >/dev/null; then echo "缺少 gh（GitHub CLI）：https://cli.github.com"; exit 1; fi

if [ -n "${GH_TOKEN:-}" ]; then
  export GH_TOKEN
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "未检测到 GitHub 凭据，请先 gh auth login，或用 GH_TOKEN=xxx 运行本脚本"
  exit 1
fi

# 仓库已存在则只推，不重复创建
if gh repo view "$REPO" >/dev/null 2>&1; then
  echo "仓库已存在，直接推送"
  git remote get-url origin >/dev/null 2>&1 || \
    git remote add origin "$(gh repo view "$REPO" --json sshUrl -q .sshUrl)"
  git push -u origin HEAD
else
  gh repo create "$REPO" --"$VISIBILITY" --source=. --remote=origin --push \
    --description "蓝河（BlueOS）手表应用：元素周期表 1–36 号元素，一行三个，青色主题"
fi

echo "完成：$(gh repo view "$REPO" --json url -q .url)"
