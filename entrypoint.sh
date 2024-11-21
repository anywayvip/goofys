#!/bin/sh

# 创建 AWS 凭证目录
mkdir -p /root/.aws/credentials

# 创建 AWS 凭证文件
{
  echo "[default]"
  echo "aws_access_key_id = $AWS_ACCESS_KEY_ID"
  echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY"
} > /root/.aws/credentials/.pass

# 执行 goofys
exec /bin/goofys "$@"
