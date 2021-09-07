---
title: fetch用法
toc: true
sidebar: true
date: 2021-09-07 14:52:03
tags:
- fetch
- javascript

categories:
- javascript
---

# Fetch API

详尽的MDN文档：[https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API](https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API)

使用Fetch：[https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API/Using_Fetch](https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API/Using_Fetch)

## 语法

```javascript
Promise<Response> fetch(input[, init]);
```

#### input <String | [`Request`](https://developer.mozilla.org/zh-CN/docs/Web/API/Request)>

定义要获取的资源。他接受一个字符串或者一个[`Request`](https://developer.mozilla.org/zh-CN/docs/Web/API/Request)对象。`Request()` 和 `fetch()` 接受同样的参数。你可以这样使用：

```javascript
let request = new Request('xxx.png', init)
fetch(request)

# 等价于
fetch('xxx.png', init)
```





#### init `可选`

一个配置参数对象，可选的配置项包括：

- `method`：请求方式，`GET`、`POST`、`DELETE`、`PUT`等

- `headers`：请求头。形式为 [`Headers`](https://developer.mozilla.org/zh-CN/docs/Web/API/Headers) 的对象 或 一个对象。大概形式如下：

  ```javascript
  let headers = new Headers()
  headers.append('content-type', 'application/json')
  
  fetch(input, {
  	headers: headers
  })
  ```

  ```javascript
  fetch(input, {
  	headers: {
          content-type: 'application/json'
      }
  })
  ```

- `body`：请求体。可能是一个 [`Blob`](https://developer.mozilla.org/zh-CN/docs/Web/API/Blob)、[`BufferSource` (en-US)](https://developer.mozilla.org/en-US/docs/Web/API/BufferSource)、[`FormData`](https://developer.mozilla.org/zh-CN/docs/Web/API/FormData)、[`URLSearchParams`](https://developer.mozilla.org/zh-CN/docs/Web/API/URLSearchParams) 或者 [`USVString`](https://developer.mozilla.org/zh-CN/docs/Web/API/USVString) 对象（说白了就是字符串）。注意 GET 或 HEAD 方法的请求不能包含 body 信息。

  > 正常的`POST`请求中，`body`入参是一个字符串，所以发送一个`JSON`对象需要经过`JSON.stringify`处理。在`GET`、 `HEAD`请求中，不可以指定`body`参数，否则会报错。

- `mode`: 请求跨域设置。接受以下数据枚举： `cors`、 `no-cors`或者 `same-origin（默认值）`

  - `same-origin（默认值）`：该模式是不允许跨域的，它需要遵守同源策略，否则浏览器会返回一个error告知不能跨域；其对应的`response.type`为`basic`。
  - `cors`：该模式支持跨域请求，顾名思义它是以CORS的形式跨域；当然该模式也可以同域请求不需要后端额外的CORS支持；其对应的`response.type`为`cors`。
  - `no-cors`：该模式用于跨域请求但是服务器不带CORS响应头，也就是服务端不支持CORS；这也是fetch的特殊跨域请求方式；其对应的`response.type`为`opaque`。

  > 设置该字段，会被赋值到请求头字段`Sec-Fetch-Mode`中，根据设置字段的不同，在响应对象`response.type`中会返回不同的信息

- `credentials`：请求cookie。接受以下数据枚举：`omit`（默认值）、`same-origin`或者 `include`。

  > （自 2017 年 8 月 25 日以后，默认的 credentials 政策变更为 `same-origin`。Firefox 也在 61.0b13 版本中进行了修改，参见：[Request.credentials](https://developer.mozilla.org/zh-CN/docs/Web/API/Request/credentials)）。为了保证各个版本的一致性，建议使用是明确指定credentials。
  >
  > 
  >
  > 注：fetch-polyfill whatwg-fetch采用默认值`same-origin`：[fetch.js#L367](https://github.com/github/fetch/blob/d1d09fb8039b4b8c7f2f5d6c844ea72d8a3cefe6/fetch.js#L367)

  - `omit`：从不发送cookies
  - `same-origin`：只有当URL与响应脚本同源才发送 cookies、 HTTP Basic authentication 等验证信息。(浏览器默认值,在旧版本浏览器，例如safari 11依旧是omit，safari 12已更改)
  -  `include`：不论是不是跨域的请求，总是发送请求资源域在本地的 cookies、 HTTP Basic authentication 等验证信息。 ( 推荐使用)

- `cache`：请求的 cache 模式。接受以下数据枚举： `default`、 `no-store`、 `reload` 、 `no-cache `、 `force-cache `或者 `only-if-cached` 。

  > 详细参见MDN说明：[Fetch Request Cache](https://developer.mozilla.org/zh-CN/docs/Web/API/Request/cache)、[HTTP Headers Cache-Control](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control)

  - `default`：表示请求时不传 `Cache-Control` 这个标头。
  - `reload`：表示本次请求忽略浏览器已经有的缓存（相当于 Ctrl + R 强制刷新），但本次请求的结果还是会遵循响应的 `Cache-Control` 标头的值来进行缓存存储。跟 `no-store` 的不同点在于 `no-store` 本次请求强制刷新了，下次如果另一个请求 `Cache-Control` 再指定成别的值比如 `only-if-cached`，完全不会命中缓存，因为 `no-store` 压根没把响应结果存在本地；而 `reload` 第一次强制刷新，第二次是的 `only-if-cached` 之类的就会命中缓存。

- `redirect`：重定向设置。`follow` (自动重定向)、`error` (如果产生重定向将自动终止并且抛出一个错误）、`manual` (手动处理重定向)。在Chrome中默认使用`follow（`Chrome 47之前的默认值是`manual`）。
  - `follow`：默认值，`fetch()`跟随 HTTP 跳转。
  - `error`：如果发生跳转，`fetch()`就报错。
  - `manual`：`fetch()`不跟随 HTTP 跳转，但是`response.url`属性会指向新的 URL，`response.redirected`属性会变为`true`，由开发者自己决定后续如何处理跳转。
- `referrer`：请求的引用者设置。可以为任意字符串，如果`referrer`的值为空字符串，则不发送referrer表头。
- `referrerPolicy`：指定了HTTP头部referer字段的值。可能为以下值之一： `no-referrer`、 `no-referrer-when-downgrade` 、`origin`、 `origin-when-cross-origin`、 `unsafe-url `。
  - `no-referrer-when-downgrade`：默认值，总是发送`Referer`标头，除非从 HTTPS 页面请求 HTTP 资源时不发送。
  - `no-referrer`：不发送`Referer`标头。
  - `origin`：`Referer`标头只包含域名，不包含完整的路径。
  - `origin-when-cross-origin`：同源请求`Referer`标头包含完整的路径，跨域请求只包含域名。
  - `same-origin`：跨域请求不发送`Referer`，同源请求发送。
  - `strict-origin`：`Referer`标头只包含域名，HTTPS 页面请求 HTTP 资源时不发送`Referer`标头。
  - `strict-origin-when-cross-origin`：同源请求时`Referer`标头包含完整路径，跨域请求时只包含域名，HTTPS 页面请求 HTTP 资源时不发送该标头。
  - `unsafe-url`：不管什么情况，总是发送`Referer`标头。

> 由于fetch接受Request对象作为入参，Request的所有参数均可以作为fetch的初始化参数进行使用，详细参数使用可以参见[Request](https://developer.mozilla.org/zh-CN/docs/Web/API/Request)文档

