---
title: 使用Taro开发微信小程序指南
toc: true
sidebar: true
date: 2022-04-16 23:31:14
tags:
  - taro
  - wechat
  - miniprograme
categories:
  - taro
---

**阅读对象**：首先需要阐明本文的受众是哪些人。因为文章只是罗列了一些 Taro 的资源，并未对实际的开发提供很多建议和深度的讲解，本文在编写之初，就默认你对小程序的开发有一定的了解，踩过一些坑，想换一种方式开发小程序，刚好你了解到 Taro，那本文对你是有价值的，方便你去找到一些和 Taro 相关的资料，加速入门。

---

随着小程序的发展，现在主流厂商均有自己的小程序框架，如：`微信`、`京东`、`百度`、`支付宝`、`字节跳动`、`QQ`、`飞书`，虽然各端小程序开发遵循了微信小程序的开发模式，但是各家小程序又包含自己的特殊，并不能完全对齐。这导致同一套功能开发，需要兼容小程序以及 H5。

目前常见的开发模式有：

1. 针对每一个小程序做单独开发，研发投入成本较大；即原生开发；
2. 开发 H5 版本的代码，利用小程序的 webview 加载 H5 的页面，从而屏蔽适配各家小程序的繁琐过程。例如微信的`kbone`；
3. 使用多端开发框架，编写一套代码，通过框架编译成各家小程序代码；如：`Taro`、`uni-app`；

本文介绍第三种开发模式，采用多端框架来开发小程序。市面上多端框架较多，如：`Taro`、`WePY` 、`uni-app`、`mpvue`、`chameleon`、`kbone`。那技术栈如何选型？

## 微信小程序多端框架横向对比

市面上已经存在众多大牛对现存的小程序多端框架进行评测。这里给出几个比较好的评测文章。

[小程序框架全面测评（2019-03-12），来自 Taro 官方](https://taro-docs.jd.com/taro/blog/2019-03-12-mini-program-framework-full-review)
[跨端开发框架深度横评之 2020 版（2020-04-09），来自 uni-app 官方，掘金](https://juejin.cn/post/6844904118901817351)

这里需要提的是微信官方推出的[kbone](https://wechat-miniprogram.github.io/kbone/docs/#%E4%BB%8B%E7%BB%8D)，它实现了一个适配器，在适配层里模拟出了浏览器环境，让 Web 端的代码可以不做什么改动便可运行在小程序里。如果你只需要支持微信小程序和 H5，毕竟是微信官方推出的，可以关注下这个解决方案。

截止目前来看，在小程序开发领域，国内开发者使用最多的应当是`Taro`、`uni-app`、`kbone`。其他开发框架已经逐渐被遗弃。就各家投入来看，各框架的版本迭代和修复 BUG 的效率都很不错，公司均有专门的团队。所以在采坑方面，目前不用太担心，出现问题官方修复速度都不错。

## 如何使用 Taro

如果你不了解[Taro](https://taro-docs.jd.com/taro/docs)，可以在官网了解[https://taro-docs.jd.com/taro/docs](https://taro-docs.jd.com/taro/docs/)。

官方提供了比较详细的教程告知如何初始化 Taro 项目，[Taro 安装及使用](https://taro-docs.jd.com/taro/docs/GETTING-STARTED)，你可以按照[基础教程](https://taro-docs.jd.com/taro/docs/folder)>[进阶教程](https://taro-docs.jd.com/taro/docs/config-detail)的方式进行入门。

当然官方也有入门教程可以参考[Taro 渐进式入门教程](https://taro-docs.jd.com/taro/docs/guide)，看完基本了解如何使用 Taro 了。

其中你需要了解 Taro 的[编译配置](https://taro-docs.jd.com/taro/docs/config)，以及 Taro 如何定义[设计稿及尺寸单位](https://taro-docs.jd.com/taro/docs/size)。

### 编译配置

编译配置存放于项目根目录下的 config 目录中，包含三个文件：

- index.js 是通用配置
- dev.js 是项目预览时的配置
- prod.js 是项目打包时的配置

详细的编译配置参数参见[编译配置详情](https://taro-docs.jd.com/taro/docs/config-detail)。按照文档介绍配置项目即可。

其中需要说明的是，此处的配置是针对 Trao 的编译打包行为进行的配置。在小程序开发中，各大平台通常会对小程序的包大小进行限制。例如：

- 微信小程序限制单包大小不得超过 2M，总包不得超过 20M。[微信小程序开发文档-分包加载](https://developers.weixin.qq.com/miniprogram/dev/framework/subpackages.html)
- 支付宝小程序单包大小不得超过 2M，总包不得超过 8M。[支付宝小程序开发文档-分包大小限制](https://opendocs.alipay.com/mini/framework/subpackages#%E5%88%86%E5%8C%85%E5%A4%A7%E5%B0%8F%E9%99%90%E5%88%B6)
- 字节小程序单包大小不得超过 2M，总包不得超过 16M。[字节小程序开发温暖的-分包简介](https://microapp.bytedance.com/docs/zh-CN/mini-app/develop/framework/subpackages/introduction)

在这种情况下，Taro 编译完成后，主包很容易就会超过 2M 的限制。常见的方式是：

- 移除包中的静态资源，改成服务器加载，例如图片上传到 CDN
- 压缩代码

#### 使用 terser-webpack-plugin 压缩代码

在`/config/dev.js`中添加以下配置

```js
const TerserPlugin = require("terser-webpack-plugin");

module.exports = {
  mini: {
    webpackChain: (chain) => {
      chain.merge({
        optimization: {
          minimize: true,
          minimizer: [
            new TerserPlugin({
              test: ["common.js", "taro.js", "vendors.js", "app.js"], // 参与压缩的文件
            }),
          ],
        },
      });
    },
  },
};
```

在 Taro 编译的过程中，还需要一个配置文件，用来告诉 Taro，编译成各端小程序，需要依照何种规则进行编译。

### 设计稿及尺寸单位

Taro 默认以 750px 作为换算尺寸标准，如果设计稿不是以 750px 为标准，则需要在项目配置 config/index.js 中进行设置。所以在项目设计之初，最好和设计人员确认，以 Iphon6 作为标准尺寸进行设计。

或许你会好奇，为何移动端会以 750px 作为设计标准，你可以阅读
[移动开发的设计稿为什么大多数是 750px](https://blog.csdn.net/weixin_45785873/article/details/106948607)。
[移动端 Web 页面适配浅析](https://www.jianshu.com/p/cf600c2930cb)
[深入浅出移动端适配（总结版）](https://juejin.cn/post/6844903951012200456#heading-24)

总之，移动端开发在单位处理上是个大坑，但是好在 Taro 帮我们处理了这些问题，你只需要根据设计稿标注的尺寸进行代码编写即可。即从设计稿上量的长度 100px，那么尺寸书写就是 100px，当转成微信小程序的时候，尺寸将默认转换为 100rpx，当转成 H5 时将默认转换为以 rem 为单位的值。这一切都是透明的。

你需要如下定义

```js
// /config/index.js
{
  designWidth: 750, // 设计稿尺寸
  deviceRatio: { // 针对不同设计稿尺寸的处理换算规则
    640: 2.34 / 2,
    750: 1,
    828: 1.81 / 2,
    375: 2 / 1
  },
}
```

如果你不希望转码单位，可以大写字母的 Px 或 PX 这会被 Taro 会被忽略。

## Vue 的支持

Taro 支持使用 Vue/Vue3 的语法开发，但是并不是完全支持。
主要的差别有：

- 事件，使用`@tap`替代`@click`
- 在 Vue 中使用 jsx 时，事件名称的首字母需要大写，例如 onGetphonenumber
- 无法使用 stopPropagation[阻止滚动穿透](https://taro-docs.jd.com/taro/docs/vue-overall#%E9%98%BB%E6%AD%A2%E6%BB%9A%E5%8A%A8%E7%A9%BF%E9%80%8F)

> 经过测试，`@tap="e => {e.stopPropagation(); handleTapEvent(); }"` 这种写法可以阻止冒泡

- Taro 中 [ref](https://taro-docs.jd.com/taro/docs/vue-overall#ref) 存在差别，无法获取大大小信息
- 不支持 `<style scoped>`，需要保证各个页面定义的样式不会相互影响，官方建议使用 cssModules 代替。[#6662](https://github.com/NervJS/taro/issues/6662)。简单的方式可以使用 scss，每个页面均定义一个和页面同名的 css 父类，该页面的所有样式均写在该样式内，通过`namespace`的方式进行屏蔽。
- 不支持 vue-router，可以使用官方的[路由](https://taro-docs.jd.com/taro/docs/router)方案

官方列出了一个不能完全兼容 Vue 的情况。参见[其他限制](https://taro-docs.jd.com/taro/docs/vue3#%E5%85%B6%E5%AE%83%E9%99%90%E5%88%B6)

## 如何选择 UI 框架

Taro 内置封装了小程序提供的原生组件功能，你可以使用 Taro 的方式调用原生组件。

由于 Taro 的工作原理，导致 web 的生态无法在 taro 中完全使用，需要针对 Taro 做定制化开发。UI 也是，好在现在有比较优秀的第三方的 UI 框架可以选择。

### NutUI

[NutUI 3.0](https://nutui.jd.com/#/intro)

京东官方出品的 UI 框架，截止 2022 年 4 月 17 号，最新版本为[v3.1.18](https://github.com/jdf2e/nutui/releases/tag/v3.1.18)。UI 风格是京东商城的风格，支持自定义主题，组件丰富，有很多商城特有组件，例如地址，商品卡片等，问题解决速度很快。

### taro-ui-vue3

[taro-ui-vue3](https://b2nil.github.io/taro-ui-vue3/)

taro-ui-vue3 是一款基于 Taro 框架开发, 并采用 Vue 3.0 重写的 Taro UI 组件库。组件功能丰富，常用开发均可以支持。

### Taroify

[Taroify](https://taroify.gitee.io/taroify.com/introduce/)

Taroify 是移动端组件库 [Vant](https://github.com/youzan/vant) 的 Taro React 版本，两者基于相同的视觉规范，提供近似一致的 API 接口，助力开发者快速搭建小程序应用。如果你之前习惯[Vant](https://github.com/youzan/vant)进行开发，可以尝试。

### taro-color-ui

[taro-color-ui](https://gengar-666.github.io/taro-color-ui/#/)

color-ui 是之前使用经验就是需要下载官方的 demo 进行魔改，虽然很好看但是不是很方便，taro 版本提供了简单的方式使用，非大团队支持，完善度还有待提升。尝鲜可以使用，可以应付常见开发需求。

## Taro 物料市场

[Taro 物料市场](https://taro-ext.jd.com/)

taro 为了丰富生态，创建的物料市场，你可以在市场中找到一些现有的解决方法，目前内容不是很多，现有工具如果出现问题，需要自己下载源码进行魔改。

### Taro 社区

[Taro 社区](https://taro-club.jd.com/)

可以在社区中查找常见问题的处理方法

## 结束语

Taro 最为目前比较优秀的解决方法，虽然有其不足之处，但也为小程序的开发提供了一种新的开发体验。

借助`kbone`文档的一句话来说，每个方案都有自己的优劣，不存在能够完美解决所有问题的方案。但是，在特定的需求下，选择自己合适的方案，会让开发效率成倍的提升。
