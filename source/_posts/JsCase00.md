---
title: 写一个求和的函数sum,达到指定效果
date: 2020-07-25 14:35:29
tags: [javascript,前端面试题]
categories:
- 面试题
- 前端面试题
---


```js
// Should equal 15
sum(1,2,3,4,5);
// Should equal 0
sum(5,null,-5)
// Should equal 10
sum('1.0',false,1,true,1,'A',1,'B',1,'C',1,'D',1,'E',1,'F',1,'G',1);
// Should equal 0.3,not 0.30000000000000004
sum(0.1,0.2);
```
<!--more-->
```js
function sum(){
  let sum=0;
  for(let i=0;i<arguments.length;i++){
   if(Object.prototype.toString.call(arguments[i])==='[object Number]'||arguments[i]===true){
      let [r1,r2]=[0,0];
      try{
        console.log(sum);
        r1=sum.toString().split('.')[1].length;
      }catch(e){
        r1=0;
      }
      try{
        r2=arguments[i].toString().split('.')[1].length;
      }catch(e){
        r2=0;
      }
      console.log('r1='+r1+"  r2="+r2);
      let r=r1>r2?r1:r2;
      let m=Math.pow(10,r);
      if(arguments[i]===true){
        arguments[i]=1;
      }
      sum=(sum*m+arguments[i]*m)/m;
    }
  }
  console.log(sum);
}

```
