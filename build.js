const fs = require('fs');
const md5 = require('md5');

// 模拟源码文件
const SOURCE_CODE = "console.log('Hello World');";

function build() {
    console.log("🚀 开始构建...");

    const inputFingerprint = JSON.stringify({
        source: SOURCE_CODE,
        nodeVersion: process.version,
        env: process.env.NODE_ENV, // 关键！
        // 甚至可以加 os: process.platform
    });
    
    // 1. 计算源码 Hash (这是大家都会做的)
    const sourceHash = md5(inputFingerprint);
    
    
    // 2. 模拟构建产物
    // 陷阱：这里隐式依赖了环境变量，导致同样的源码在不同机器上产物不同
    const output = `
        // Build Hash: ${sourceHash}
        // Build Time: ${new Date().toISOString()} 
        // Node Version: ${process.version}
        ${SOURCE_CODE}
    `;

    fs.writeFileSync('dist.js', output);
    console.log("✅ 构建完成: dist.js");
    console.log("   内容预览:", output.trim());
}

build();
