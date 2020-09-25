---
title: 在Vue项目中关闭Eslint
date: 2020-07-25 15:32:48
tags: [Vue,Eslint]
categories: Vue
---
Vue项目开启Eslint经常会报一些格式警报或错误,如果嫌烦可以关闭Eslint

vue-cli4如何关闭ESlint?
/vue.config.js中将lintOnSave属性设置为false，如果没有就自己写个进去。
```js
module.exports = {
  lintOnSave: false
}
```
<!--more-->
老版本如何关闭ESlint?找到文件 bulid/webpack.base.config.js 并注释掉对应代码;分三种情况,注释对应代码后重启项目即可
情况一
```js
module:{
  rules:[
    // {
    //   test: /\.(js|vue)$/,
    //   loader: 'eslint-loader',
    //   enforce: 'pre',
    //   include: [resolcr('src'),resolve('test')],
    //   options:{
    //     formatter:require('eslint-friendly-formatter')
    //   }
    // },
  ]
}
```
情况二
```js
const createLintingRule = () => ({
  // test: /\.(js|vue)$/,
  // loader: 'eslint-loader',
  // enforce: 'pre',
  // include: [resolve('src'), resolve('test')],
  // options: {
  //   formatter: require('eslint-friendly-formatter'),
  //   emitWarning: !config.dev.showEslintErrorsInOverlay
  // }
})
```
情况三
```js
module:{
  rules:[
    // (config.dev.useEslint ? [createLintingRule()]:[]),
    {
      test: /\/vue$/,
      loader: 'vue-loader',
      options: vueLoaderConfig
    },
  ]
}

```
