---
title: Hexo之Github&Gitee双托管
date: 2020-05-25 09:39:01
tags: [Hexo,Github,NexT,Gitee,搭建博客]
categories: Hexo
---
### 为什么要部署到码云?
因github国内访问速度太慢,且百度不能搜索github内容

### 双托管百度统计处理
修改themes\next\layout\_third-party\analytics\baidu-analytics.swig文件内容,对域名加判断就可对两个网站分别统计
```yaml
{%- if theme.baidu_analytics %}
  <script{{ pjax }}>
    var _hmt = _hmt || [];
    (function() {
      var hm = document.createElement("script");
      if(window.location.href.indexOf('YourGiteeDomain')!=-1){
        hm.src = "https://hm.baidu.com/hm.js?YourGiteeID";
      }else{
        hm.src = "https://hm.baidu.com/hm.js?{{ theme.baidu_analytics }}";
      }
      var s = document.getElementsByTagName("script")[0];
      s.parentNode.insertBefore(hm, s);
    })();
  </script>
{%- endif %}
```
### 双托管来比力评论处理
来比力评论系统是针对网站的,测试发现如果只有一个UID只有对应的网站能够登录评论;
非对应网站不能登录但是能看到指定网站的评论内容
因此,双托管需要再注册一个来比力账号并绑定域名获取UID,[注册来比力](http://livere.com)
然后需要修改下面代码对域名进行判断是否替换UID,下面代码插入&lt;script&gt;即可
themes\next\layout\_third-party\comments\livere.swig
```javascript
if(window.location.href.indexOf('yourGiteeDomain')!=-1){
  document.querySelector('#lv-container').setAttribute("data-uid","yourGiteeUID")
}
```


