#!/usr/bin/env bash
set -eo pipefail

BRANCH="$1"
DIR="$2"
LINK_ID="$3"
ROLE_ARN="$4"

# リモートのスタック一覧（削除済みは除く）（数が多い場合はページングが必要）
remote="$(aws cloudformation list-stacks --query 'StackSummaries[?StackStatus!=`DELETE_COMPLETE`].[StackName]' --output text | sort)"

# ローカルのファイル一覧
local="$(find "$DIR" -name '*.yaml' -exec basename {} .yaml \; | sort)"

# 差分（＝新規作成されたファイル）
diff="$(join -v2 <(echo "$remote") <(echo "$local"))"

for stack_name in $diff; do

  echo "NEW STACK: $stack_name"

  # スタックの作成
  aws cloudformation create-stack \
    --stack-name "$stack_name" \
    --template-body file://initial-template.yaml

  # Git同期の作成
  aws codeconnections create-sync-configuration \
    --branch "$BRANCH" \
    --resource-name "$stack_name" \
    --config-file "$DIR/$stack_name.yaml" \
    --repository-link-id "$LINK_ID" \
    --role-arn "$ROLE_ARN" \
    --pull-request-comment ENABLED \
    --sync-type CFN_STACK_SYNC

done
