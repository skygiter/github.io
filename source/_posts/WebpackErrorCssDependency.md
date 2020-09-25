---
title: Vue项目打包报错:No module factory available for dependency type:CssDependency
date: 2020-07-26 20:27:48
tags: [Webpack,Vue]
categories: Webpack
---

### Vue项目打包报错: No module factory available for dependency type: CssDependency
问题描述：在打包过程出现 没有可用于依赖类型的模块 CssDependency
在vue.config.js中添加就可以解决问题
```js
module.exports = {
  css: {
    extract: false
  }
};
```
[参考资料](https://blog.csdn.net/weixin_45615791/article/details/104294458)

