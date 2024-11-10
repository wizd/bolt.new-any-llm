#!/bin/bash

env | grep API

# 初始化 bindings 变量
bindings=""

# 检查 .env 文件是否存在
if [ -f .env ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        # 跳过空行和注释行
        if [[ ! "$line" =~ ^# ]] && [[ -n "$line" ]]; then
            name=$(echo "$line" | cut -d '=' -f 1)
            value=$(echo "$line" | cut -d '=' -f 2-)
            value=$(echo $value | sed 's/^"\(.*\)"$/\1/')
            bindings+="--binding ${name}=${value} "
        fi
    done < .env

    # 清理末尾的空格
    bindings=$(echo $bindings | sed 's/[[:space:]]*$//')
fi

# 如果没有 bindings，输出空字符串
echo $bindings
