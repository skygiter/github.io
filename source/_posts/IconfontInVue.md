---
title: Vue项目中使用图标字体的几种方式
date: 2020-08-05 21:14:03
tags: [Iconfont,Vue]
categories: 
- 前端
- Iconfont
---

### 使用[阿里iconFont图标库](https://www.iconfont.cn)
打开 iconFont官网 选择自己喜欢的图标,并且添加购物车和项目,可以生成链接引入
vue项目中，找到index.html文件，引入css样式，记住这里要放上你的链接地址
示例
```html
<link rel="stylesheet" href="http://at.alicdn.com/t/font_657604_xujhsb9zlug3z0k9.css">
```
使用方式,图标对应命名可在项目中查看,支持编辑
```html
<i class="iconfont icon-alibaba"></i>
```
考虑到网络链接稳定性可将字体下载到本地使用
用来存放字体图标的本地文件在src/assets文件下创建iconfont文件夹
需要放入的有6个文件,如下
`iconfont.css iconfont.eto iconfont.svg iconfont.ttf iconfont.woff iconfont.woff2`
如过项目中没有下载 css-loader 依赖包，就进行下载，否则会报错npm install css-loader -D
在main.js中引入iconfont.css文件,如：import 'xxx/xxx/xxx/iconfont.css',至此就可使用该图标库了

### 使用vue-awesome
安装vue-awesome依赖包
```bash
npm install vue-awesome
```
按需引入
```js
import ‘vue-awesome/icons/flag’
```
不考虑文件大小全部引用
```js
import 'vue-awesome/icons'
improt Icon from 'vue-awsesome/compoents/Icon'
Vue.component('icon','Icon')
```
使用
```html
<icon name="icon-name"></icon>
```

### 使用[IconMoon](https://icomoon.io/app/#/select)
选好需要的图标点击右下角的Generate Font F
这时会看到我们已经选择的图标，在这里可以修改名称等，然后点击右下角的下载
在vue项目中创建文件夹，打开style.css样式,修改引入字体的路径（不同路径写的方式不一样，需要注意）

在main.js中全局引入
```js
import ‘@/assets/css/icomoon/style.css’
```
如果想要使用我们自己画的.svg格式的矢量图图标，点击Import Icons
导入我们本地的.svg格式的图标（注意，矢量图是用矢量线画的，png,jpg等使用像素来的，不可以直接用png转成svg格式，否则不成功）
引入之后，接来下就和上面的步骤一样了。
使用方法同上





[参考资料](https://www.cnblogs.com/hahahakc/p/13025069.html)
[参考资料](https://blog.csdn.net/xyr0709/article/details/92835670)