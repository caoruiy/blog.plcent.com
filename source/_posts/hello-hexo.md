---
title: hexo搭建个人博客并部署到个人服务器
date: 2019-11-04 14:28:02
toc: true # 是否启用内容索引
sidebar: true # 是否启用sidebar侧边栏，none：不启用
tags: 
- hexo
categories:
- hexo
---

当你打开这篇文章时, 默认你已经安装好了hexo, 并已经开始摸索着捣鼓自己的个人站点了.

### 起手式

安装并初始化完成hexo站点

```shell
# 安装
> npm install hexo -g
# 初始化
> hexo init <folder>
# 本地预览
> hexo s
```

## 自动生成分类categories和标签tag

自动维护categories分类页面, 安装 [hexo-auto-category](https://github.com/xu-song/hexo-auto-category) 和 [hexo-generator-tag](https://github.com/hexojs/hexo-generator-tag)

```
> npm i -S hexo-auto-category
> npm i -S hexo-generator-tag
```

在站点根目录下的 `_config.yml` 添加：

```
# 自动生成分类
category_generator:
  per_page: 20
  order_by: -date

# 自动生成Tag
tag_generator:
  per_page: 20
  order_by: -date
```

> 自动生成的分类和标签, 会在执行 `hexo g` 命令时自动生成

## sitemap站点地图

切换到站点根目录, 安装谷歌站点地图[hexo-generator-category](https://github.com/hexojs/hexo-generator-category) 和 百度站点地图 [hexo-generator-baidu-sitemap](https://github.com/coneycode/hexo-generator-baidu-sitemap)

站点根目录下的 `_config.yml` 配置文件添加

```
## sitemap
sitemap:
  path: sitemap.xml
baidusitemap:
  path: baidusitemap.xml
```


## RSS订阅

切换到站点根目录, 安装 [hexo-generator-feed](https://github.com/hexojs/hexo-generator-feed)

```
> npm i -S hexo-generator-feed
```

站点根目录下的 `_config.yml` 配置文件添加

```
## feed   
feed:
  type: atom
  path: atom.xml
  limit: 20
  hub:
  content:
```