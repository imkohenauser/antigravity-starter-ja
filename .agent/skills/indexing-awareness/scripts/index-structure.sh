#!/bin/bash

# プロジェクト構造インデクサー (Project Structure Indexer)
# プロジェクトの全体像（ディレクトリ構造、ファイル種別、サイズ）を高速にインデックス化する。
# RAG の「事前インデックス化」を擬似的に再現する。

# --- プロジェクトルートの自動解決 ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
cd "$PROJECT_ROOT" || exit 1

# --- デフォルト値 ---
MAX_DEPTH=4
TARGET_DIR="."

# --- 引数パース ---
while [[ $# -gt 0 ]]; do
    case $1 in
        --depth) MAX_DEPTH="$2"; shift 2 ;;
        --dir)   TARGET_DIR="$2"; shift 2 ;;
        --help|-h)
            echo "Usage: index-structure.sh [--depth N] [--dir PATH]"
            echo ""
            echo "Options:"
            echo "  --depth N    探索の最大深度 (default: 4)"
            echo "  --dir PATH   対象ディレクトリ (default: プロジェクトルート)"
            echo ""
            echo "Examples:"
            echo "  index-structure.sh                  # プロジェクト全体"
            echo "  index-structure.sh --dir src/       # src/ ディレクトリのみ"
            echo "  index-structure.sh --depth 2        # 浅い概要のみ"
            exit 0 ;;
        *) TARGET_DIR="$1"; shift ;;
    esac
done

echo "📁 Project Structure Index"
echo "   Root: $PROJECT_ROOT"
echo "   Target: $TARGET_DIR"
echo "   Depth: $MAX_DEPTH"
echo "============================================================"

# --- 除外パターン ---
EXCLUDE_PATTERNS=(
    -not -path '*/node_modules/*'
    -not -path '*/.git/*'
    -not -path '*/.DS_Store'
    -not -path '*/dist/*'
    -not -path '*/build/*'
    -not -path '*/__pycache__/*'
    -not -path '*/.next/*'
    -not -path '*/.venv/*'
    -not -path '*/target/*'
    -not -name '*.pyc'
)

# --- ツリー出力 ---
find "$TARGET_DIR" -maxdepth "$MAX_DEPTH" "${EXCLUDE_PATTERNS[@]}" | sort | while read -r path; do
    if [ "$path" = "$TARGET_DIR" ]; then
        continue
    fi

    # インデントの計算（深さに応じて）
    depth=$(echo "$path" | tr -cd '/' | wc -c | tr -d ' ')
    base_depth=$(echo "$TARGET_DIR" | tr -cd '/' | wc -c | tr -d ' ')
    indent_level=$((depth - base_depth))
    indent=$(printf '%*s' $((indent_level * 2)) '')

    if [ -d "$path" ]; then
        count=$(find "$path" -maxdepth 1 -not -path "$path" "${EXCLUDE_PATTERNS[@]}" 2>/dev/null | wc -l | tr -d ' ')
        echo "${indent}📂 $(basename "$path")/ ($count items)"
    else
        size=$(wc -c < "$path" 2>/dev/null | tr -d ' ')
        echo "${indent}📄 $(basename "$path") (${size}B)"
    fi
done

# --- サマリー統計 ---
echo ""
echo "============================================================"
echo "📊 Summary:"

total_files=$(find "$TARGET_DIR" -type f "${EXCLUDE_PATTERNS[@]}" 2>/dev/null | wc -l | tr -d ' ')
total_dirs=$(find "$TARGET_DIR" -type d "${EXCLUDE_PATTERNS[@]}" 2>/dev/null | wc -l | tr -d ' ')
echo "   Files: $total_files | Directories: $total_dirs"

echo "   File types:"
find "$TARGET_DIR" -type f "${EXCLUDE_PATTERNS[@]}" 2>/dev/null \
    | sed 's/.*\.//' | sort | uniq -c | sort -rn | head -10 \
    | while read -r count ext; do
        echo "     .$ext: $count"
    done
