#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# 如果是发布到自定义域名，请取消注释下面的内容
# echo 'www.your-domain.com' > CNAME

if [ -z "$GITHUB_TOKEN" ]; then
 # 本地手动部署
 msg='deploy'
 githubUrl=git@github.com:quardia/quardia.github.io.git
else
 # GitHub Actions 自动部署
 msg='来自github action的自动部署'
 githubUrl=https://quardia:${GITHUB_TOKEN}@github.com/quardia/quardia.github.io.git
 git config --global user.name "quardia"
 git config --global user.email "2091751219@qq.com"
fi

git init
git add -A
git commit -m "${msg}"

# 推送
git push -f $githubUrl master

# 退回上次所在目录
cd -
# 删除打包后的文件夹
rm -rf docs/.vuepress/dist
