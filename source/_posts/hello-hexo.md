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

## hexo 博客图片问题
hexo博客图片的问题在于，markdown文章使用的图片路径和hexo博客发布时的图片路径不一致。
通常我们使用markdown书写博客时, 采用的方式是使用 `![]()` 格式插入图片，我们希望在生成博客时，可以将图片转换成正确的格式。

这里可以利用插件 `hexo-asset-image` 来解决这个问题。

1. 安装:

```
> npm i -S hexo-asset-image
```

2. 配置:

只需要在`_config.yml` 中配置 `post_asset_folder` 为 `true` 即可。

3. 问题:

> 但是从插件存在问题[域名是xxx.io的情况下，图片路径会从原本/xxx.jpg变成 /.io/xxx.jpg](https://github.com/xcodebuild/hexo-asset-image/issues/47)， 如果你也存在一样的问题，可以手动修改代码解决这个问题。

在`node_modules` 目录下, 找到 `hexo-asset-image` 文件夹, 修改文件 `index.js` 的 `L24`

```
# 从
var endPos = link.lastIndexOf('.');
# 修改为
var endPos = link.length-1; 
```

> 参见 [github issues](https://github.com/xcodebuild/hexo-asset-image/issues/47#issuecomment-512759505)
> 作者更新了项目代码, 但是没有更新 npm 包。

## 参考目录
- [hexo博客图片问题](https://www.jianshu.com/p/950f8f13a36c)