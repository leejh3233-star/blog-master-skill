#!/usr/bin/env bash
set -euo pipefail

SOURCE_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/SKILL.md"
TARGET_DIR="$HOME/.agents/skills/naver-blog-master"
TARGET_FILE="$TARGET_DIR/SKILL.md"

mkdir -p "$TARGET_DIR"
cp "$SOURCE_FILE" "$TARGET_FILE"

echo
echo "NAVER Blog Master skill installed."
echo "Path: $TARGET_FILE"
echo 'Call example: $naver-blog-master BLOG MASTER — 새 글 시작'
