---
title: vuepress学习系列/2/基本配置
toc: true
sidebar: true
date: 2020-01-16 22:28:37
tags:
- vuepress

categories:
- vuepress
---

### vuepress配置

先领取一份官方文档：[https://vuepress.vuejs.org/zh/guide/basic-config.html](https://vuepress.vuejs.org/zh/guide/basic-config.html)

`vuepress`的所有配置信息均放在 `docs/.vuepress` 目录下，因为 `vuepress` 建议的目录结构如下:

```
.
├── docs
│   ├── .vuepress (可选的)
│   │   ├── components (可选的)
│   │   ├── theme (可选的)
│   │   │   └── Layout.vue
│   │   ├── public (可选的)
│   │   ├── styles (可选的)
│   │   │   ├── index.styl
│   │   │   └── palette.styl
│   │   ├── templates (可选的, 谨慎配置)
│   │   │   ├── dev.html
│   │   │   └── ssr.html
│   │   ├── config.js (可选的)
│   │   └── enhanceApp.js (可选的)
│   │ 
│   ├── README.md
│   ├── guide
│   │   └── README.md
│   └── config.md
│ 
└── package.json


```

目录结构文档：[https://vuepress.vuejs.org/zh/guide/directory-structure.html](https://vuepress.vuejs.org/zh/guide/directory-structure.html#默认的页面路由)



新建配置文件只需要在`.vuepress`下新建文件`config.js`即可：

```sh
> mkdir .vuepress && touch .vuepress/config.js
```

一个 VuePress 网站必要的配置文件是 `.vuepress/config.js`，它应该导出一个 JavaScript 对象：

```js
module.exports = {
  title: 'Hello VuePress',
  description: 'Just playing around'
}
```



### 完整基本配置 

官方文档地址：[基本配置](https://vuepress.vuejs.org/zh/config/#基本配置)，具体配置请参照官方文档。这里只列出一些不好理解的属性。

> 加 ☆ 的属性表示不知道该属性如何使用。

- ☆ [temp](https://vuepress.vuejs.org/zh/config/#temp)  指定客户端文件的临时目录。

  > 默认的临时文件放在 `node_modules/@vuepress/core/.temp` 下

- ☆ [shouldPrefetch](https://vuepress.vuejs.org/zh/config/#shouldprefetch)  一个函数，用来控制对于哪些文件，是需要生成 `<link rel="prefetch">` 资源提示的。请参考 [shouldPrefetch](https://ssr.vuejs.org/zh/api/#shouldprefetch)。

  > 该参数用于服务端渲染

- [cache](https://vuepress.vuejs.org/zh/config/#cache)  此选项可以用于指定 cache 的路径，同时也可以通过设置为 `false` 来在每次构建之前删除 cache。

- [extraWatchFiles](https://vuepress.vuejs.org/zh/config/#extrawatchfiles)  指定额外的需要被监听的文件。

- [patterns](https://vuepress.vuejs.org/zh/config/#patterns)  指定将解析哪些文件。默认值：`['**/*.md', '**/*.vue']`。

  > 你可以修改该属性,用来屏蔽部分文件,，让他们在编译时不会被包含进来。`['**/page/*.md']`只包含`page`目录下的`.md`文件

- 