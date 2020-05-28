---
title: vuepress学习系列/1/初次认识
toc: true
sidebar: true
date: 2020-01-16 22:28:37
tags:
- vuepress
categories:
- vuepress
---

### vuepress 初识

之所以会了解到vuepress，是在学习element-ui源码时，想自己搭建一个elemen-ui那样的技术文档网站，因为可以运行的demo让element-ui和一般的技术站点显得更为友好。



翻了源码之后发现其使用`vue-markdown-loader`来加载`markdown`文档，按照这个原理，翻看`vue-loader`官网后,发现了`vuepress`。其提供的功能基本可以满足这样的需求。本着学习的态度，开启了`vuepress`学习之旅。



### vuepress 能做什么

你看到的，`vue`、`vue-loader`、`vue-router`等 `vue `官方的文档,均是使用 `vuepress` 搭建的。



### 上手

开始前，先领取一份官方文档：[https://vuepress.vuejs.org/zh/guide/](https://vuepress.vuejs.org/zh/guide/)

按照 [快速上手](https://vuepress.vuejs.org/zh/guide/getting-started.html#%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B) 的步骤，安装并初始化

```shell
# 安装
yarn global add vuepress # 或者：npm install -g vuepress

# 创建项目目录
mkdir vuepress-starter && cd vuepress-starter

# 新建一个 markdown 文件
# 可能会导致乱码的问题
echo '# Hello VuePress!' > README.md

# 开始写作
vuepress dev .

# 构建静态文件
vuepress build .
```

> 问题：启动项目后，如果你遇到乱码的问题，请不要慌张，这是你新建的 `README.md` 文件乱码导致的，将文件编码修改成 `utf-8` 即可解决该问题。

