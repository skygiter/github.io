---
title: DeepCopy
date: 2020-07-26 21:01:42
tags: [JavaScript,深拷贝,前端面试题]
categories: 
- 前端
- JavaScript
---

### js对象深拷贝的3种方法
js对象不像变量那样，简单的赋值就能进行克隆的，对象进行赋值时，只是创建了一个新的指针指向相同的存储空间。就像这样
```js
var a={a:1}
var b=a;
b.a=2
console.log(a.a);  // 2
```
这时输出a你会发现，a的值同样发生了改变。
这一点在你进行数据操作时，又想保留原来数据时，你就需要深度克隆了。
<!--more-->

1. 方法一:js序列化

有一种时通过js序列化，将js转换成字符串，然后再将字符串转换成js对象。

具体代码为:
```js
var obj = {a:1};
var str = JSON.stringify(obj); //序列化对象
var newobj = JSON.parse(str); //还原
```
2. 方法二:对象遍历逐条复制
就是进行对象的遍历复制，对对象的每一条属性进行复制，这样就能进行对象的深度克隆
```js
function deepCopy(obj) {
  var str, newobj = obj.constructor === Array ? [] : {};//constructor 属性返回对创建此对象的数组函数的引用。创建相同类型的空数据
  if (typeof obj !== 'object') {
    return;
  } else {
    for (var i in obj) {
      if (typeof obj[i] === 'object'){//判断对象的这条属性是否为对象
        newobj[i] = newObj(obj[i]);//若是对象进行嵌套调用
      }else{
        newobj[i] = obj[i];
      }
    }
  }
  return newobj;//返回深度克隆后的对象
};
```
3. 方法三: ES6对象展开赋值
还一种就是应用es6的语法对象展开运算符进行对象的展开赋值；
```js
let a = {a:0}
let b = {...a}
```
>此方法是不是太简单了?!
