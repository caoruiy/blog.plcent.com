---
title: Hexo主题pure使用指南
date: 2019-11-05 14:34:15
toc: true # 是否启用内容索引
sidebar: true # 是否启用sidebar侧边栏，none：不启用
tags: 
- hexo主题

categories:
- hexo
---

`hexo` 主题 `pure` 项目相关信息:

> 预览地址: [https://blog.cofess.com](https://blog.cofess.com)
> 项目地址: [https://github.com/cofess/hexo-theme-pure](https://github.com/cofess/hexo-theme-pure)
> 中文使用文档: [https://github.com/cofess/hexo-theme-pure/blob/master/README.cn.md](https://github.com/cofess/hexo-theme-pure/blob/master/README.cn.md)

### 使用前请操作
使用该主题前, 请先复制 `theme/pure/_source/` 目录下的所有内容到 `blog path/source/` 目录下
原因在于该目录下有建好的菜单 `categories`(分类)、`tags`(标签)、`repository`(项目)、`books`(书单)、`links`(友链)、`about`(关于)页面

当你使用自动生成分类、标签，展示github项目时


### 文章目录索引
在文章详情页, 展示一个文章目录

1. 主题配置文件中开启配置:
```
config
  toc: true # 是否开启文章章节目录导航
```

2. 在文章顶部将该文章开启索引, 如:

```
---
title: Hexo主题pure使用指南
date: 2019-11-05 14:34:15
tags: 
- hexo主题

categories:
- hexo

toc: true # 是否启用内容索引
sidebar: none # 是否启用sidebar侧边栏，none：不启用
---
```


### 侧边栏

主题配置项中, 侧边栏可以如下配置:

```
# 侧边栏
sidebar: right
# 侧边栏启用哪些模块
widgets:
  - board # 公告
  - category # 分类
  - tag # 标签
  - tagcloud # 标签云
  - archive # 归档
  - recent_posts # 最近文章

# 归档列表的展示方式
archive_type: 'monthly' # 归档方式:  yearly | monthly
show_count: true # 显示每个归档的文章总数
```

### 图集
在文章详情页中, 涉及的图片可以使用图集功能, 在点击一张图片时, 放大图片.
主题的图册公告是使用[fancybox](https://github.com/fancyapps/fancybox)实现, 可以参照github

```
# Fancybox
# 图集功能
fancybox: true
```

### 展示github项目

在左侧菜单`项目`中, 点击展示自己的github项目

1. 在主题配置文件中 `_config.yml` 修改, 请配置自己github用户名

```
github: 
  username: caoruiy  # github用户名
```

2. 新建`repository`页面:

```
> hexo new repository
```
> 你也可以直接复制 `theme/pure/_source/` 目录下 `repository文件夹` 到 `博客根目录/source/` 目录下

3. 将文件内容修改为:

```
---
title: Repositories
layout: repository
comments: false
sidebar: none
---
```

> 关键内容为 `layout: repository`, 包含该属性才可以展示github项目

### 评论功能
主题集成了[disqus](https://disqus.com/)、[友言](http://www.uyan.cc/)、[来必力](https://livere.com/)、[gitment](https://github.com/imsun/gitment)、[gitalk](https://github.com/gitalk/gitalk)评论系统，选择其中一种即可

你可以在主题配置文件中修改评论工具
```
comment:
  type: valine  # 启用哪种评论系统
```

#### Valine

一个无后端的评论框工具, 其依赖于 [Leancloud](https://leancloud.cn) 开发, 所以使用前需要先注册 [Leancloud](https://leancloud.cn) 账号


如何开始? 你可以从 [Valine-快速开始](https://valine.js.org/quickstart.html) 教程开始, 教程包含了一步一步的指引教程.

##### Valine配置项

主题valine评论框提供了以下配置项

```
valine: # Valine官方地址: https://valine.js.org
  appid:  # 你的 leancloud 应用 appid
  appkey:  # 你的 leancloud 应用 appkey
  notify: true # 是否开始评论邮件提醒, 教程: https://github.com/xCss/Valine/wiki
  verify: false # 是否开始验证码功能, 开始邮件提醒会自动开启验证码功能
  placeholder: 说点什么... # 输入框默认内容
  avatar: mm # 头像展示方式, 具体设置项教程: https://valine.js.org/configuration.html#avatar
  meta: nick,mail,link # 自定义评论信息
  pageSize: 10 # 评论列表分页
  lang: zh-cn, # 多语言支持 zh-cn | en
  visitor: true # 文章阅读量统计:  https://valine.js.org/visitor.html
  highlight: true # 代码高亮
  recordIP: true # 记录评论者的IP
```

> 关于邮件提醒: 只有在回复评论时, 并且填写了邮箱的评论才会收到回复提醒
> 关于文章阅读量统计: 开启阅读量统计, 会在详情页标题下展示阅读量数据



### 搜索功能
主题提供内置的`搜索功能`和`百度搜索`, `百度搜索`就是使用百度的SEO搜索, 个人觉得不是很实用, 不建议开启.

在主题配置文件 `_config.yml` 中配置:
```
# Search
search:
  insight: true # 在使用搜索功能前, 你需要安装 `hexo-generator-json-content`
  baidu: false # 使用百度搜索前, 你必须禁用其他所有的搜索功能
```

#### 内置搜索

使用搜索功能前需要先安装:

```shell
npm i -S hexo-generator-json-content 
```

项目地址: [https://github.com/alexbruno/hexo-generator-json-content](https://github.com/alexbruno/hexo-generator-json-content)

在你运行 `hexo g` 或者 `hexo s` 时生效，在 `hexo g` 生成站点时, 会在根目录下生成 `content.json` 该文件内容即为搜索内容。

你可以对搜索内容进行自定义的配置， 只要在 `_config.yml` 中配置 [`jsonContent`](https://github.com/alexbruno/hexo-generator-json-content#defaults)即可:

```
# 示例: 隐藏分类和标签的搜索
jsonContent:
  dateFormat: DD/MM/YYYY
  posts:
    title: true
    date: true
    path: true
    text: true
    raw: false
    content: false
    slug: false
    updated: false
    comments: false
    link: false
    permalink: false
    excerpt: false
    categories: false
    tags: false
    author: false
```



### 文章阅读数量统计
主题提供 [不蒜子](http://busuanzi.ibruce.info/) 和 基于 leancloud 的统计

但是经过验证, 发现基于leancloud的统计不生效, 不知原因, 实现等效的方法就是: 

评论框使用`valine`评论框(主题已经内置), 同时开启 `visitor: true` 配置项项即可

### 字数统计&阅读时长

主题内置了该功能, 使用前需要先安装插件:

```
npm i -S hexo-wordcount
```

主题配置文件中, 开启设置即可:

```
# wordcount
postCount:
  enable: true
  wordcount: true  # 文章字数统计
  min2read: true  # 阅读时长预计
```

### 友情链接
复制 `theme/pure/_source/` 目录下 `links文件夹` 到 `blog path/source/` 目录下
在 hexo 目录下的 source 文件夹内创建一个名为 _data（禁止改名）的文件夹。

然后在文件内创建一个名为 `links.yml` 的文件,在其中添加相关数据即可。

单个友情链接的格式为：
```
Name:
    link: http://example.com
    avatar: http://example.com/avatar.png
    desc: "这是一个描述"
```

添加多个友情链接，我们只需要根据上面的格式重复填写即可。

- 将 Name 改为友情链接的名字，例如 Cofess。

- http://example.com 为友情链接的地址。

- http://example.com/avatar.png 为友情链接的头像。

- 这是一个描述 为友情链接描述。