# Create CloudFormation Git Sync Automatically

CloudFormationのGit同期を自動で作成するサンプル

## 解説記事

https://qiita.com/tippy/items/548f2036992548c33347

## ディレクトリ構成

```
.
├── cfn-deployments # デプロイファイル
│   ├── prd
│   │   ├── sushi-iam.yaml
│   │   ├── sushi-log.yaml
│   │   ├── yakiniku-iam.yaml
│   │   └── yakiniku-log.yaml
│   └── stg
│       ├── yakiniku-iam.yaml
│       └── yakiniku-log.yaml
├── cfn-templates # テンプレート
│   ├── iam.yaml
│   └── log.yaml
├── create-git-sync.sh
└── initial-template.yaml
```
