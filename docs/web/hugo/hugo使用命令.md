---
title: hugo使用命令
description: hugo使用命令
tags:
  - Hugo
---
## 1. 创建新网站

```
hugo new site 网站名字
```

## 2. hugo开启服务

```
hugo server --buildDrafts
hugo serve
hugo server -D
```

> 三种方式都可以，接着访问 http://localhost:1313, 当文件内容发生变化时，页面会随着变化而自动刷新

## 3. 新建文件

```
hugo new 文件目录/文件名.zh.md

hugo new 文件目录/文件目录/文件名.zh.md

```

## 4. 新建章节

```
hugo new --kind chapter 文件目录/_index.zh.md

```

> 文件_index.zh.md里面改为 chapter = true

## 5. 添加主题

```js
// 进入主题目录
cd themes/

// 克隆learn主题
git clone https://github.com/matcornic/hugo-theme-learn.git
```

> 把exampleSite下面的config.toml文件复制到站点下,修改config.toml文件里面的themes = "learn"

## 6. 打包部署

```
hugo
```

> 生成文件夹public，其中包含网站的所有静态内容，可以部署在任何 Web 服务器上。