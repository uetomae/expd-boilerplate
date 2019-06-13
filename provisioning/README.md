# UETOMAE.tools Environment

このリポジトリでは `terraform` を使って [UETOMAE.tools](/uetomae/uetomae-tools)
のAWS環境を管理する。

## 実行環境

Dockerを使った `terraform` ラッパー `terraform-docker` を使用する想定のため、ホスト端末に
`terraform` をインストールする必要は無い。もしホスト端末で直接 `terraform`
を実行したい場合、後述の環境変数に加えて `terraform.tfvars` に `access_key` と `secret_key`
を設定するのを忘れないようにする。

## 実行前準備

プロビジョニングのためには、このプロジェクトを実行するホスト端末にいくつかの秘匿情報を別途設定する必要がある。これらのデータはgitリポジトリとは別に管理されているため、システム管理者に確認のこと。

### AWS接続情報の環境変数

プロビジョニング可能な権限を持った接続情報を、以下の変数で設定しておく。

```awscredential:bash
export AWS_ACCESS_KEY_ID=<<YOUR ACCESS KEY>>
export AWS_SECRET_ACCESS_KEY=<<YOUR SECRET KEY>>
export AWS_DEFAULT_REGION=<<YOUR REGION>>
```

### terraform.tfvarsの作成

他にも幾つかの秘匿情報が必要になる場合があり、それらはプロジェクトルートに `terraform.tfvars`
ファイルを置くことで設定するのが容易だ。

```terraform.tfvars
db_user = "<<YOUR DB USER>>"
db_pass = "<<YOUR DB PASSWORD>>"
```

## 実行

実行は `terraform-docker` を使った `terraform` コマンドによって行う。

### 初期化

実行端末ではじめてプロジェクトを走らせる場合、まず初期化を行ってs3から現在の状況を取得する必要がある。

```
./terraform-docker init
```

### ワークスペースの選択

本番環境なら `prod` を選択する。最初は `default`
になっているが、この名前の環境は作成できないので注意。

```
./terraform-docker workspace select prod
```

### 実行計画の確認

実行前に、どういった変更が行われようとしているのか慎重に確認すべきだ。以下のコマンドによって、何が行われようとしているのかを見ることができる。


```
./terraform-docker plan
```

### 実行

プロビジョニングの実施は、以下のコマンドで行う。最初に実行計画が表示されるので、問題なければ `yes`
をタイプして反映させる。

```
./terraform-docker apply
```
