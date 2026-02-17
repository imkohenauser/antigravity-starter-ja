#!/bin/bash

# 依存関係トレーサー (Dependency Tracer)
# ファイルまたはシンボルの依存関係を双方向に検索する。
# RAG の「関連コンテキスト検索」を擬似的に再現する。
#
# モード:
#   ファイルモード: 引数がファイルパスの場合
#     → Forward (このファイルが何を import しているか)
#     → Reverse (このファイルを誰が import しているか)
#
#   シンボルモード: 引数がシンボル名の場合
#     → Definition (定義元の検索)
#     → Usage (使用箇所の検索)

# --- プロジェクトルートの自動解決 ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
cd "$PROJECT_ROOT" || exit 1

TARGET="$1"
SEARCH_DIR="${2:-.}"

if [ -z "$TARGET" ] || [ "$TARGET" = "--help" ] || [ "$TARGET" = "-h" ]; then
    echo "Usage: trace-dependencies.sh <file-or-symbol> [search-directory]"
    echo ""
    echo "Modes:"
    echo "  File mode:   引数が既存ファイルパスの場合、そのファイルの依存関係を双方向にトレース"
    echo "  Symbol mode: 引数がシンボル名の場合、定義元と使用箇所を検索"
    echo ""
    echo "Examples:"
    echo "  trace-dependencies.sh src/utils/auth.ts        # ファイルの依存関係"
    echo "  trace-dependencies.sh handleLogin               # シンボルの検索"
    echo "  trace-dependencies.sh UserService src/           # 範囲を限定して検索"
    exit 0
fi

# --- 除外パターン (grep 用) ---
EXCLUDE_DIRS=(
    --exclude-dir=node_modules
    --exclude-dir=.git
    --exclude-dir=dist
    --exclude-dir=build
    --exclude-dir=__pycache__
    --exclude-dir=.next
    --exclude-dir=.venv
    --exclude-dir=target
)

# --- ソースコード拡張子 ---
SOURCE_INCLUDES=(
    --include="*.ts" --include="*.tsx"
    --include="*.js" --include="*.jsx"
    --include="*.mjs" --include="*.cjs"
    --include="*.py"
    --include="*.java"
    --include="*.go"
    --include="*.rb"
    --include="*.rs"
    --include="*.vue" --include="*.svelte"
    --include="*.php"
    --include="*.cs"
    --include="*.swift"
    --include="*.kt" --include="*.kts"
)

# --- 設定ファイル拡張子 ---
CONFIG_INCLUDES=(
    --include="*.md"
    --include="*.json"
    --include="*.yaml" --include="*.yml"
    --include="*.toml"
    --include="*.xml"
    --include="*.cfg" --include="*.conf" --include="*.ini"
    --include="*.env"
)

# --- Import/Require パターン (言語横断) ---
IMPORT_PATTERN='(import |require\(|from ["\x27]|include |#include |use |using )'

echo "🔗 Dependency Trace: $TARGET"
echo "   Search scope: $SEARCH_DIR"
echo "============================================================"

if [ -f "$TARGET" ]; then
    # =========================================================
    # FILE MODE
    # =========================================================
    filename=$(basename "$TARGET")
    filename_no_ext="${filename%.*}"

    echo ""
    echo "📥 Forward Dependencies (このファイルが参照しているもの):"
    echo "---"
    results=$(grep -nE "$IMPORT_PATTERN" "$TARGET" 2>/dev/null)
    if [ -n "$results" ]; then
        echo "$results"
    else
        echo "   (none found)"
    fi

    echo ""
    echo "📤 Reverse Dependencies (このファイルを参照しているもの):"
    echo "---"
    results=$(grep -rnI "${EXCLUDE_DIRS[@]}" "${SOURCE_INCLUDES[@]}" \
        -E "(${filename_no_ext}|${filename})" \
        "$SEARCH_DIR" 2>/dev/null | grep -v "^${TARGET}:" | head -30)
    if [ -n "$results" ]; then
        echo "$results"
    else
        echo "   (none found)"
    fi

    echo ""
    echo "🔍 Config/Doc References (設定・ドキュメントからの参照):"
    echo "---"
    results=$(grep -rnI "${EXCLUDE_DIRS[@]}" "${CONFIG_INCLUDES[@]}" \
        "$filename" "$SEARCH_DIR" 2>/dev/null | grep -v "^${TARGET}:" | head -20)
    if [ -n "$results" ]; then
        echo "$results"
    else
        echo "   (none found)"
    fi

else
    # =========================================================
    # SYMBOL MODE
    # =========================================================

    echo ""
    echo "📌 Definitions (定義元):"
    echo "---"
    # 一般的な定義パターン（言語横断）
    results=$(grep -rnI "${EXCLUDE_DIRS[@]}" "${SOURCE_INCLUDES[@]}" \
        -E "(function\s+${TARGET}|const\s+${TARGET}|let\s+${TARGET}|var\s+${TARGET}|class\s+${TARGET}|interface\s+${TARGET}|type\s+${TARGET}|enum\s+${TARGET}|def\s+${TARGET}|fn\s+${TARGET}|func\s+${TARGET}|struct\s+${TARGET}|trait\s+${TARGET}|export\s+(default\s+)?(function|class|const|let|var)\s+${TARGET})" \
        "$SEARCH_DIR" 2>/dev/null | head -20)
    if [ -n "$results" ]; then
        echo "$results"
    else
        echo "   (none found)"
    fi

    echo ""
    echo "📎 Usages (使用箇所):"
    echo "---"
    results=$(grep -rnI "${EXCLUDE_DIRS[@]}" "${SOURCE_INCLUDES[@]}" \
        -w "$TARGET" "$SEARCH_DIR" 2>/dev/null | head -30)
    if [ -n "$results" ]; then
        echo "$results"
    else
        echo "   (none found)"
    fi

    echo ""
    echo "📦 Import/Require References (インポート参照):"
    echo "---"
    results=$(grep -rnI "${EXCLUDE_DIRS[@]}" "${SOURCE_INCLUDES[@]}" \
        -E "(import.*${TARGET}|require.*${TARGET}|from.*${TARGET})" \
        "$SEARCH_DIR" 2>/dev/null | head -20)
    if [ -n "$results" ]; then
        echo "$results"
    else
        echo "   (none found)"
    fi
fi

echo ""
echo "============================================================"
echo "✅ Trace complete."
