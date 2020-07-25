---
title: Git手册
date: 2020-07-01 14:15:58
tags: [Git,GitHub]
categories: Git
---

## 已有项目上传到github仓库
### 方法一:克隆&拷贝
1. 首先克隆
```bash
git clone yourRepository
```
2. 然后复制自己项目的所有文件到刚刚克隆下来的仓库中
3. 最后push到远程仓库：
```bash
git push -u origin master
```
### 方法二:强行合并两个仓库
1. github新建仓库，将本地项目设置为一个git仓库。如果本地项目已经是一个git仓库了，请跳过这一步。在项目根目录下：
```bash
git init
```
>>>github新建仓库时不要自动生成REDAME.md文件,如果本地文件正好有该文件会报错
![同步报错](./gitmanual/refspec.jpg)

最后如果push报错可尝试执行下面代码解决
```bash
git pull --rebase origin master
```

2. 把当前目录下的已有文件全部加到刚刚新建的git仓库中：
```bash
git add .
```
3. 保存刚刚加入的文件，并书写保存信息：
```bash
git commit -m "push current files"

```
4. 将本地仓库与远程仓库关联起来：
```bash
git remote add origin yourRepository

```

5. pull远程仓库的内容，更新本地仓库，使用–allow-unrelated-histories忽略本地仓库和远程仓库的无关性，强行合并（关键）：
```bash
git pull origin master --allow-unrelated-histories

```
6. 把本地仓库的内容push到远程仓库：
```bash
git push -u origin master

```



生成ssh秘钥
ssh-keygen -t rsa -C "youremail"  -f "~/.ssh/id_rsa_github"

查看git配置
 git config --list

测试连接github
ssh -T git@github.com

测试连接gitee
ssh -T git@gitee.com







　　  








