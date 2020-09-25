---
title: Vue项目中如何优雅的使用Stylus
date: 2020-07-25 14:58:26
tags: [Vue,Stylus]
categories:
- 前端
- CSS预处理器
- Stylus
---

引用stylus官网中的一句话：富于表现力、动态的、健壮的 CSS
stylus是一个强大的css预编译语言,stylus支持省略花括号，支持省略分号，代码整洁，支持引入，并且支持语法内函数
[官方地址](https://stylus.bootcss.com/)
[GitHub地址](https://github.com/stylus/stylus/)

使用非常简单
安装stylus，使用npm安装,stylus和stylus-loader，一个都不能少
```
npm install stylus stylus-loader --save-dev
```
使用分为两种，一种是直接在vue中的style模块中使用，这时在style模块中规定好就可以了
```
<style lang="stylus" rel="stylesheet/stylus"></style>
```
还有一种是作为.styl文件引入
把css内容放在styl文件中，然后在vue的style模块中通过@import引入
<!--more-->

>tips:
卸载 stylus :
>```
npm uninstall stylus```
>查看 stylus版本：
>```
npm show style-loader version```


mixin.styl:

//配置背景图片函数
```stylus
bg-image($url)
  background-image: url($url + "2.png")
  @media (-webkit-min-device-pixel-ratio: 3),(min-device-pixel-ratio: 3)
    background-image: url($url + "3.png")

```
variable.styl
// 颜色定义规范
```
color-theme = #ffcd32
```

//字体定义规范

```
font-size-medium = 14px
```

content.vue
```stylus
<style scoped lang="stylus" rel="stylesheet/stylus">
  @import "~common/stylus/mixin"
  @import "~common/stylus/variable"
    .recommend-list
      .list-title
        height 300px
        width 100%
        font-size $font-size-medium
        color $color-theme
      .item
        padding 0 20px 20px 20px
        background bg-image('../images/bg.png')
        &.active
          color #fff
</style>
```

content.styl
```stylus
.recommend-list
      .list-title
        height 65px
        line-height 65px
        text-align center
        font-size $font-size-medium
        color $color-theme
      .item
        display flex
        box-sizing border-box
        align-items center
        padding 0 20px 20px 20px
        background bg-image('../images/bg.png')
        &.active
          color #fff
```
content.vue

```vue
<style>
  @import "content.styl"
</style>
```
[参考文章](https://www.jianshu.com/p/8601ccf91225)
