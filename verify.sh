#!/bin/bash

echo "🧪 实验 1: 在标准环境下构建"
export NODE_ENV=production
node build.js
mv dist.js dist.prod.js
HASH_PROD=$(cat dist.prod.js | grep "Build Hash" | head -n 1 | awk '{print $4}')
echo "   Hash: $HASH_PROD"

sleep 1

echo -e "\n🧪 实验 2: 篡改环境变量 (模拟不同机器/CI)"
export NODE_ENV=development
node build.js
mv dist.js dist.dev.js
HASH_DEV=$(cat dist.dev.js | grep "Build Hash" | head -n 1 | awk '{print $4}')
echo "   Hash: $HASH_DEV"

echo -e "\n🔍 结果比对："

if [ "$HASH_PROD" == "$HASH_DEV" ]; then
    echo "❌ 失败！环境变了，但 Hash 没变 -> 缓存中毒风险！"
else
    echo "✅ 成功！环境变了，Hash 也变了 -> 安全！"
    echo "   CI 会认为这是两个不同的构建，不会错误复用缓存。"
fi
