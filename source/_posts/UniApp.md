---
title: uni-app快速入门
date: 2020-09-14 20:42:57
tags:  [前端,uni-app,vue,小程序]
categeries: 
- 前端
- uni-app
---

## 什么是 uni-app?
>>>uni-app 是一个使用 Vue.js 开发所有前端应用的框架，开发者编写一套代码，可发布到iOS、Android、H5、以及各种小程序（微信/支付宝/百度/头条/QQ/钉钉/淘宝）、快应用等多个平台。

>>>DCloud公司拥有500万开发者用户，几十万应用案例、10亿手机端月活用户，数千款uni-app插件、70+微信/qq群。

>>>uni-app在手，做啥都不愁。即使不跨端，uni-app也是更好的小程序开发框架、更好的App跨平台框架、更方便的H5开发框架。


## 标签/组件变化
uni-app参考小程序规范，提供了一批内置组件。

### html标签和uni-app内置组件的映射表
+ div 改成 view
+ span、font 改成 text
+ a 改成 navigator
+ img 改成 image
+ input 还在，但type属性改成了confirmtype
+ form、button、checkbox、radio、label、textarea、canvas、video 这些还在。
+ select 改成 picker
+ iframe 改成 web-view
+ ul、li没有了，都用view替代
+ audio 不再推荐使用，改成api方式，背景音频api文档
+ 其实老的HTML标签也可以在uni-app里使用，uni-app编译器会在编译时把老标签转为新标签，比如把div编译成view。但不推荐这种用法，调试H5端时+ 容易混乱。

### 手机端新增常用新组件
+ scroll-view 可区域滚动视图容器
+ swiper 可滑动区域视图容器
+ icon 图标
+ rich-text 富文本（不可执行js，但可渲染各种文字格式和图片）
+ progress 进度条
+ slider 滑块指示器
+ switch 开关选择器
+ camera 相机
+ live-player 直播
+ map 地图
+ cover-view 可覆盖原生组件的视图容器 cover-view需要多强调几句，uni-app的非h5端的video、map、canvas、textarea是原生组件，层级高于其他组件。如需覆盖原生组件，则需要使用cover-view组件。

## js的变化
### 运行环境从浏览器变成v8引擎

标准js语法和api都支持，比如if、for、settimeout、indexOf等。

但浏览器专用的window、document、navigator、location对象，包括cookie等存储，只有在浏览器中才有，app和小程序都不支持。

可能有些人以为js等于浏览器里的js。其实js是ECMAScript组织管理的，浏览器中的js是w3c组织基于js规范补充了window、document、navigator、location等专用对象。

在uni-app的各个端中，除了h5端，其他端的js都运行在一个独立的v8引擎下，不是在浏览器中，所以浏览器的对象无法使用。如果你做过小程序开发，对此应当很了解。

这意味着依赖document的很多HTML的库，比如jqurey无法使用。

当然app和小程序支持web-view组件，里面可以加载标准HTML，这种页面仍然支持浏览器专用对象window、document、navigator、location。

### dom操作，改成vue的MVVM模式

现在前端趋势是去dom化，改用mvvm模式，更简洁的写法，大幅减少代码行数，同时差量渲染性能更好。

uni-app使用vue的数据绑定方式解决js和dom界面交互的问题。

如果你想改变某个dom元素的显示内容，比如一个view的显示文字：

以前是给view设id，然后js里通过选择器获取dom元素，进一步通过js进行赋值操作，修改dom元素的属性或值。

### js api的变化

因为uni-app的api是参考小程序的，所以和浏览器的js api有很多不同，如

+ alert,confirm 改成 uni.showmodel
+ ajax 改成 uni.request
+ cookie、session 没有了，local.storage 改成 uni.storage
+ uni-app的js api还有很多，但基本就是小程序的api，把wx.xxx改为uni.xxx即可。详见

uni-app在不同的端，支持条件编译，无限制的使用各端独有的api，[详见条件编译](https://uniapp.dcloud.io/platform)

>>>小程序的数据绑定参考了vue，但自己修改了一些。在uni-app中只支持标准的vue，不支持小程序的数据绑定语法
>>>小程序里的setData在uni-app里并不存在，因为vue是自动双向数据绑定的。直接通过赋值方式修改数据，如果数据绑定到界面上，界面会自动更新渲染

## CSS的变化

标准的css基本都是支持的。

选择器有2个变化：*选择器不支持；元素选择器里没有body，改为了page。微信小程序即是如此。

单位方面，px无法动态适应不同宽度的屏幕，rem无法用于nvue/weex。如果想使用根据屏幕宽度自适应的单位，推荐使用rpx，全端支持。 尺寸单位文档

uni-app推荐使用flex布局，并默认就是flex布局，这个布局思路和传统流式布局有点区别。但flex的有趣在于，不管是什么技术都支持这种排版，web、小程序/快应用、weex/rn、原生的iOS、Android开发，全都支持flex。它是通吃所有端的新一代布局方案。详见[阮一峰flex布局文档](http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html)

uni-app的vue文件里支持所有web排版方式，不管是流式还是flex。但nvue里，只支持flex，因为它在app端是使用原生排版引擎渲染的。

注意css里背景图和字体文件，尽量不要大于40k，因为会影响性能。在小程序端，如果要大于40k，需放到服务器侧远程引用或base64后引入，不能放到本地作为独立文件引用。

## 工程结构和页面管理

uni-app的工程结构有单独的要求，[详见](https://uniapp.dcloud.io/frame?id=目录结构)


每个可显示的页面，都必须在 pages.json 中注册。如果你开发过小程序，那么pages.json类似app.json。如果你熟悉vue，这里没有vue的路由，都是在pages.json里管理。

原来工程的首页一般是index.html或default.html，是在web server里配的。而uni-app的首页，是在pages.json里配的，page节点下第一个页面就是首页。一般在/pages/xx的目录下。

app和小程序中，为了提升体验，页面提供了原生的导航栏和底部tabbar，注意这些配置是在pages.json中做，而不是在vue页面里创建，但点击事件的监听在显示的vue页面中做。

在vue中，以前的js事件监听概念改为了生命周期概念。详见uni-app生命周期

如果你熟悉小程序开发的话，对比变化如下：

原来app.json被一拆为二。页面管理，被挪入了uni-app的pages.json；非页面管理，挪入了manifest.json
原来的app.js和app.wxss被合并到了app.vue中



## 参考资料
+ [uni-app官方文档](https://uniapp.dcloud.io/)
+ [白话uni-app](https://ask.dcloud.net.cn/article/35657)
 

