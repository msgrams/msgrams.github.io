---
title: 部署GitHub
description: 部署github上
tags:
  - Hugo
---
# 部署GitHub

## 1. 在github创建一个Repository

```
hugo --theme=主题名 --baseUrl="https://名字.github.io/" --buildDrafts
```

> 会在根目录生成public目录

## 2. 部署

```html
// 切换到public文件夹
cd public

// 初始化文件夹
git init

// 将所有文件添加到暂存区
git add .

// 提交文件到本地仓库，写一个提交信息，提交到 git 本地。
git commit -m "第X次提交"

// 关联远程仓库，即public文件和远程Github进行关联，网址在github对应的 repository仓库看到
git remote add origin https://github.com/github名字/仓库名字.github.io.git 
// 关联gitee进行关联
git remote add origin https://gitee.com/gitee名字/仓库名字.git

//将本地仓库代码推送到远程库，然后查看repository，初次使用才需要 -u
git push -u origin master 
```

## 3. 问题

### 3.1 推不上去

```
// 推不上去就强制上传覆盖远程文件
git push -f origin master
```

### 3.2 配置http代理

```
// 查看代理命令
git config --global --get http.proxy
git config --global --get https.proxy

// 配置http代理
git config --global http.proxy 127.0.0.1:10809
git config --global https.proxy 127.0.0.1:10809

// 取消代理命令
git config --global --unset http.proxy
git config --global --unset https.proxy

```

## 4. 博客更新

### 4.1 执行命令进行build

```
git remote add origin https://github.com/名字/名字.github.io.git 
```

### 4.2 将public推到github

```js
// 执行命令进行build
hugo --baseUrl="https://名字.github.io" --buildDrafts

// 将所有文件添加到暂存区
git add .

// 提交文件到本地仓库，写一个提交信息，提交到 git 本地。
git commit -m "第X次提交"

// 输入":wq",注意是冒号+wq,按回车键即可
git pull origin master

//将本地仓库代码推送到远程库，然后查看repository，初次使用才需要 -u
git push -u origin master 

```

## 5. 自动更新bat
```js
@echo off
echo                                      Git auto
echo ===================================================================================
echo.
set /p change=Git change:
echo.
cd "hugo站点的public目录"
git add .
git commit -m  %change%
git pull origin master
git push origin master 
echo.
echo ===================================================================================
echo                                      update ok
echo.
pause

```