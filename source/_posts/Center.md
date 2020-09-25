---
title: 元素水平垂直居中(4种方式)
date: 2020-07-25 14:26:22
tags: [HTML/CSS,前端面试题]
categories: 
- 前端
- HTML/CSS
---

1. 已知块级元素的宽和高，使用绝对定位absolute和外边距实现水平垂直居中。
```html
<div class="box">
    <div class="center-box1">
        <p>第一种方法: 知道长和宽，使用绝对定位+外边距设定水平垂直居中</p>
    </div>
</div>

.box {
    background: #6c94be;
    width: 100%;
    height: 450px;
    position: relative;
}
.center-box1 {
    position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -100px;
    margin-left: -100px;
    width: 200px;
    height: 200px;
    background: #5B83AD;
}
```
<!--more-->
2. 使用css3 display:flex（IE存在兼容性问题）
```html
<div class="box">
    <div class="center-box2">
        <p>第二种方法: 使用css3样式属性display:flex设定水平垂直居中</p>
    </div>
</div>

.box {
    background: #6c94be;
    width: 100%;
    height: 450px;
    display: flex;
}
.center-box2 {
    margin: auto;
    width: 200px;
    background: #5B83AD;
}
```
3.使用绝对定位+CSS3 transform（由于transform中translate偏移的百分比都是相对于自身而言的，所以不像方法一种那样必须知道子元素的宽高才行，但是对于IE只有IE9+才支持）
```html
<div class="box">
    <div class="center-box3">
        <p>第三种方法: 使用css3样式属性transform，transform中translate偏移的百分比值是相对于自身大小的</p>
    </div>
</div>

.box {
    background: #6c94be;
    width: 100%;
    height: 450px;
    position: relative;
}

.center-box3 {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);
    background: #5B83AD;
    width: 200px;
}
```
4. 已知子元素的宽和高，设置其样式属性position:absolute;top:0;left:0;bottom:0;right:0;margin:auto;
```html
<div class="box">
    <div class="center-box4">
        <p>第四种方法: 已知宽和高，绝对定位+margin:auto;</p>
    </div>
</div>

.box {
    background: #6c94be;
    width: 100%;
    height: 450px;
    position: relative;
}
.center-box4 {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    width: 200px;
    height: 200px;
    background: #5B83AD;
    margin: auto;
}
```
