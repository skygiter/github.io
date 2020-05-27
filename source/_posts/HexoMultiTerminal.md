---
title: Hexo 多终端管理
date: 2020-05-26 11:24:01
tags:  [Hexo,Github,博客搭建]
categories: Hexo
---
### 预备环境
node.js,git
安装hexo
```bash
npm install hexo-cli -g
```
### 备份源文件
假设hexo文件夹是已经生成的hexo博客目录
如果themes/next(风格名字目录)下面有.git，请删除这个.git文件夹
不是所有文件都需要备份,.gitgnore需配置如下
```
.DS_Store
Thumbs.db
db.json
*.log
node_modules/
public/
.deploy*/
Local.md 
```
执行下面代码备份
```bash
#cd hexo
#git init  //初始化本地仓库
#git add source themes scaffolds _config.yml package.json package-lock.json  //将必要的文件依次添加
#git commit -m "blog hexo"
#git branch hexo  //新建hexo分支
#git checkout hexo  //切换到hexo分支上
#git remote add origin git@github.com:user/user.github.io.git  //将本地与Github项目对接
#git push origin hexo  //push到Github项目的hexo分支上
```
### 其它终端克隆源文件
***环境准备:node.js,git,hexo***
```bash
git clone -b hexo git@github.com:user/user.github.io.git  //将Github中hexo分支clone到本地
cd user.github.io
npm install
```

### 多终端写文章操作
```bash
git pull origin hexo //本地和远端的融合
hexo new post "new post name"  //写新文章
git add source
git commit -m "xxx"
git push origin hexo  //备份
hexo d -g  //部署
```