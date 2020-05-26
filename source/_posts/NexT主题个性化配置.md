---
title: NexT主题个性化配置
date: 2020-05-12 10:01:44
tags: [Hexo,Github,NexT,搭建博客]
categories: 
- Hexo
- NexT
top: 100
mathjax: true
---

**NexT常用配置(部分配置和主题无关)**
*说明:本人Hexo版本4.2,NexT版本7.8*

#### 博客显示图片
设置站点配置文件_config.yml中 post_asset_folder:true。
Hexo 提供了一种更方便管理 Asset 的设定：post_asset_folder当您设置post_asset_folder为true参数后，在建立文件时，Hexo会自动建立一个与文章同名的文件夹，您可以把与该文章相关的所有资源都放到那个文件夹。
<!--more-->

安装插件：在hexo的目录下执行
```
npm install https://github.com/CodeFalling/hexo-asset-image --save
```

完成安装后用hexo新建文章的时候会发现_posts目录下面会多出一个和文章名字一样的文件夹。图片就可以放在文件夹下面。

文章中插入图片方式：
```
方式一：
{% asset_img example.jpg examplename %}

方式二：
![description](img)
```


*方式一会显示examplename作为title显示;方式二description是img标签alt属性*
***一开始我按上面的设置无效,图片不显示,后来发现这是hexo的一个bug,需修改插件js***
页面效果如下,图片路径为/.io//开头,如果手动将其改为年份图片能显示
{% asset_img hexo-img-error.jpg  图片显示异常%}
手动修改图片路径后图片可显示
{% asset_img hexo-img-show.jpg  手动修改图片路径可显示%}

解决方法:打开/node_modules/hexo-asset-image/index.js，将内容更换为下面的代码

```javascript
'use strict';
var cheerio = require('cheerio');

// http://stackoverflow.com/questions/14480345/how-to-get-the-nth-occurrence-in-a-string
function getPosition(str, m, i) {
  return str.split(m, i).join(m).length;
}

var version = String(hexo.version).split('.');
hexo.extend.filter.register('after_post_render', function(data){
  var config = hexo.config;
  if(config.post_asset_folder){
    	var link = data.permalink;
	if(version.length > 0 && Number(version[0]) == 3)
	   var beginPos = getPosition(link, '/', 1) + 1;
	else
	   var beginPos = getPosition(link, '/', 3) + 1;
	// In hexo 3.1.1, the permalink of "about" page is like ".../about/index.html".
	var endPos = link.lastIndexOf('/') + 1;
    link = link.substring(beginPos, endPos);

    var toprocess = ['excerpt', 'more', 'content'];
    for(var i = 0; i < toprocess.length; i++){
      var key = toprocess[i];
 
      var $ = cheerio.load(data[key], {
        ignoreWhitespace: false,
        xmlMode: false,
        lowerCaseTags: false,
        decodeEntities: false
      });

      $('img').each(function(){
		if ($(this).attr('src')){
			// For windows style path, we replace '\' to '/'.
			var src = $(this).attr('src').replace('\\', '/');
			if(!/http[s]*.*|\/\/.*/.test(src) &&
			   !/^\s*\//.test(src)) {
			  // For "about" page, the first part of "src" can't be removed.
			  // In addition, to support multi-level local directory.
			  var linkArray = link.split('/').filter(function(elem){
				return elem != '';
			  });
			  var srcArray = src.split('/').filter(function(elem){
				return elem != '' && elem != '.';
			  });
			  if(srcArray.length > 1)
				srcArray.shift();
			  src = srcArray.join('/');
			  $(this).attr('src', config.root + link + src);
			  console.info&&console.info("update link as:-->"+config.root + link + src);
			}
		}else{
			console.info&&console.info("no src attr, skipped...");
			console.info&&console.info($(this));
		}
      });
      data[key] = $.html();
    }
  }
});
```
至此解决图片显示问题


#### 开启(添加)代码复制功能
方法一:直接开启该功能即可,默认是不开启的
themes\next\_config.yml
```yaml
codeblock:
  # Code Highlight theme
  # Available values: normal | night | night eighties | night blue | night bright | solarized | solarized dark | galactic
  # See: https://github.com/chriskempson/tomorrow-theme
  highlight_theme: normal
  # Add copy button on codeblock
  copy_button:
    enable: true
    # Show text copy result.
    show_result: true
    # Available values: default | flat | mac
    style:
```
方法二:
使用clipboard.js,cdn地址  
```javascript
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.4/clipboard.min.js"></script>
```
在themes/next/source/js 下新建clipboard-use.js,写入下面代码

```javascript
/*页面载入完成后，创建复制按钮*/
!function (e, t, a) {
  /* code */
  var initCopyCode = function () {
    var copyHtml = '';
    copyHtml += '<button class="btn-copy" data-clipboard-snippet="">';
    copyHtml += '  <i class="fa fa-clipboard"></i><span>copy</span>';
    copyHtml += '</button>';
    $(".highlight .code pre").before(copyHtml);
    $('.btn-copy').css({'position':'absolute','right':'0px','opacity':'.5','cursor':'pointer'});
    $('.btn-copy').hover(
      function(){
      $(this).css('opacity','1');
    },
    function(){
      $(this).css('opacity','.5');
    },
    )
    new ClipboardJS('.btn-copy', {
      target: function (trigger) {
        return trigger.nextElementSibling;
      }
    });
  }
  initCopyCode();
}(window, document);

```

在themes/layout/layout.swig中&lt;/body&gt;前引下面代码

```javascript
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.4/clipboard.min.js"></script>
<script type="text/javascript" src="/js/clipboard-use.js"></script>
```
因使用了jQuery还需在&lt;/head&gt;前引入jQuery,否则会报错$ is undefined
```javascript
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
```
*方法二是在其它文章看到的,亲测也是可行的;直接用方法一开启代码复制功能更方便*


#### 添加搜索功能
在自己博客根目录下执行如下命令
```shell
cnpm install hexo-generator-searchdb --save
```
/_config.yml 底部添加如下代码
```yaml
#search
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```
themes\next\_config.yml搜索local_search，修改enable为true
*添加完毕,需重启才生效*

#### 首页文章预览显示阅读更多
方法一： themes/next/_config.yml 找到下面代码
```yaml
  auto_excerpt:
      enable: false
      length: 150
```
将enable的 false改成true，length可以设定文章预览的文本长度
*这个方法我试了不生效,我的原文件里面没有上面代码,手动加上去也不生效,应该是版本原因*

方法二: &lt;!--more--&gt;
在文章合适位置插入该代码可实现首页文章预览显示阅读更多,亲测有效
*强烈推荐此方法,更灵活,反正方法一我这里不生效*

#### 文章添加字数统计
字数统计效果图
![](http://qah1aj2e1.bkt.clouddn.com/hexo-wordcount.jpg)
在根目录下安装 hexo-wordcount,运行：
```bash
npm install hexo-wordcount --save
```
themes\next\_config.yml中配置
```yaml
# Post wordcount display settings
# Dependencies: https://github.com/willin/hexo-wordcount
post_wordcount:
  item_text: true
  wordcount: true
  min2read: true
```
*我按上面操作不报错也没有效果,我的配置文件中原来没有上面代码，手动加上也没用*
还需添加代码到themes\next\layout\_macro\post.swig
放在```post.categories and post.categories.length and theme.post_meta.categories```这段后面
```swig
{%- if theme.post_wordcount %}
            <span title="{{ __('post.wordcount') }}">
            <span class="post-meta-item-icon">
              <i class="fa fa-newspaper"></i>
            </span>
              字数统计: <time>{{ wordcount(post.content) }} </time>字
            </span>
            <span title="{{ __('post.min2read') }}">
            <span class="post-meta-item-icon">
              <i class="fa fa-clock"></i>
            </span>
              阅读时长≈
              <time>{{ min2read(post.content) }}  </time>分钟
            </span>
          {%- endif %}
```
*图标本来是想用fa-file-word-o,就是那个word的图标,但是我这里怎么都不显示*
#### 数学方程式渲染支持
公式示例: $$C_M^N =\frac{M!}{N!(M-N)!}, \text{(M=7, N=3)} $$
themes\next\_config.yml  搜索math找到下面代码进行设置
```yaml
math:
  # Default (true) will load mathjax / katex script on demand.
  # That is it only render those page which has `mathjax: true` in Front-matter.
  # If you set it to false, it will load mathjax / katex srcipt EVERY PAGE.
  per_page: true

  # hexo-renderer-pandoc (or hexo-renderer-kramed) required for full MathJax support.
  mathjax:
    enable: true    # 默认为false
    # See: https://mhchem.github.io/MathJax-mhchem/
    mhchem: true    # 默认为false

  # hexo-renderer-markdown-it-plus (or hexo-renderer-markdown-it with markdown-it-katex plugin) required for full Katex support.
  katex:
    enable: true    # 默认为false
    # See: https://github.com/KaTeX/KaTeX/tree/master/contrib/copy-tex
    copy_tex: true  # 默认为false
```
继续找math 设置下面代码
```yaml
# MathJax
  mathjax: //cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js
  # mathjax:

  # KaTeX
  # katex: //cdn.jsdelivr.net/npm/katex@0/dist/katex.min.css
  katex: //cdnjs.cloudflare.com/ajax/libs/KaTeX/0.11.1/katex.min.css
  copy_tex_js: //cdn.jsdelivr.net/npm/katex@0/dist/contrib/copy-tex.min.js
  copy_tex_css: //cdn.jsdelivr.net/npm/katex@0/dist/contrib/copy-tex.min.css
  # katex:
  # copy_tex_js:
  # copy_tex_css:
```
最后有公式的页面,Front-matter里打开mathjax开关，如下
![](http://qah1aj2e1.bkt.clouddn.com/mathjax.jpg)


#### 添加RSS功能
实测只有样式没有功能
项目根目录执行下面命令
```bash
npm install hexo-generator-feed --save

```
/_congig.yml  配置如下
```yaml
feed:
    type: atom
    path: atom.xml
    limit: 20
    hub:
    content:
    content_limit:
    content_limit_delim: ' '
    order_by: -date
    icon: icon.png
```
参数含义:
type: RSS的类型(atom/rss2)
path: 文件路径,默认是atom.xml/rss2.xml
limit: 展示文章的数量,使用0或则false代表展示全部
hub:
content: 在RSS文件中是否包含内容 ,有3个值 true/false默认不填为false
content_limit: 指定内容的长度作为摘要,仅仅在上面content设置为false和没有自定义的描述出现
content_limit_delim: 上面截取描述的分隔符,截取内容是以指定的这个分隔符作为截取结束的标志.在达到规定的内容长度之前最后出现的这个分隔符之前的内容,防止从中间截断.


#### 添加动态背景
添加修改代码themes\next\layout\_layout.swig在&lt;/body&gt;之前加上
```
{% if theme.canvas_nest %}
<script type="text/javascript" src="//cdn.bootcss.com/canvas-nest.js/1.0.0/canvas-nest.min.js"></script>
{% endif %}
```
打开themes/next/_config.yml，添加以下代码
`# Canvas-nest
canvas_nest: true`
添加完毕,效果图如下
![动态背景](http://qah1aj2e1.bkt.clouddn.com/hexoDynamicBG.jpg)


#### 修改文章内链接样式
themes\next\source\css\_common\components\post\post.styl尾部添加如下代码
```css
// 文章内链接文本样式
.post-body p a{
  color: #0593d3;
  border-bottom: none;
  border-bottom: 1px solid #0593d3;
  &:hover {
    color: #fc6423;
    border-bottom: none;
    border-bottom: 1px solid #fc6423;
  }
}
```
*其中选择 .post-body 是为了不影响标题，选择 p 是为了不影响首页“阅读全文”的显示样式,颜色可以自己定义。*

#### 修改文章底部带#号标签
themes/next/_config.yml 搜索tag_icon,将其值改为true即可
效果图
![底部标签](http://qah1aj2e1.bkt.clouddn.com/hexo-tagicon.jpg)
#### 在文章尾部统一添加"本文结束"标记
在路径 \themes\next\layout\_macro 中新建 passage-end-tag.swig 文件,并添加以下内容：
```
<div>
    {% if not is_index %}
        <div style="text-align:center;color: #ccc;font-size:14px;">-------------本文结束<i class="fa fa-paw"></i>感谢您的阅读-------------</div>
    {% endif %}
</div>
```
打开\themes\next\layout\_macro\post.swig文件,在body标记后找到if not is_index 添加如下代码
```
{{ partial('passage-end-tag.swig') }}
```
如图
![](http://qah1aj2e1.bkt.clouddn.com/end-tag.jpg)
themes\next\_config.yml尾部添加代码
```yaml
# 文章末尾添加“本文结束”标记
passage_end_tag:
  enabled: true
```

#### 设置作者头像
themes/next/_config.yml搜索avatar,找到下面代码进行配置
```yaml
# Sidebar Avatar
avatar:
  # Replace the default image and set the url here.
  url: /images/avatar.gif
  # If true, the avatar will be dispalyed in circle.
  rounded: true
  # If true, the avatar will be rotated with the cursor.
  rotated: true
  opacity: 0.7
```
url全路径为 ```themes/next/source/images/avatar.gif```


#### 侧边栏社交图标设置
themes\next\_config.yml  搜索social找到下面代码进行配置
```yaml
social:
  GitHub: https://github.com/skygiter || fab fa-github
  Segmentfault: https://segmentfault.com/u/skygit || fa fa-link
  Weibo: https://weibo.com/skygit || fab fa-weibo
  E-Mail: mailto:skygit@126.com || fa fa-envelope
  #Google: https://plus.google.com/yourname || fab fa-google
  #Twitter: https://twitter.com/yourname || fab fa-twitter
  #FB Page: https://www.facebook.com/yourname || fab fa-facebook
  #StackOverflow: https://stackoverflow.com/yourname || fab fa-stack-overflow
  #YouTube: https://youtube.com/yourname || fab fa-youtube
  #Instagram: https://instagram.com/yourname || fab fa-instagram
  #Skype: skype:yourname?call|chat || fab fa-skype

social_icons:
  enable: true
  icons_only: false 
  transition: true   
  exturl: true
```
#### 开启访问统计(busuanzi)
themes\next\_config.yml  找到下面代码,enable值改为true即可,默认为false
```yaml
busuanzi_count:
  enable: true
  total_visitors: true
  total_visitors_icon: fa fa-user
  total_views: true
  total_views_icon: fa fa-eye
  post_views: true
  post_views_icon: fa fa-eye
```
#### 开启百度统计
先在[百度统计官网](https://tongji.baidu.com)，注册一个账号，并且绑定好域名
复制hm.js?后面的字符串如图：
![](http://qah1aj2e1.bkt.clouddn.com/bdtj.jpg)
themes\next\_config.yml中搜索 baidu_analytics 填上id
```yaml
# Baidu Analytics
baidu_analytics: your-id
```
然后部署三连
`hexo clean`
`hexo g`
`hexo d`

如果部署成功,可在百度统计后天查看部署状态,点代码转态栏的刷新按钮
![](http://qah1aj2e1.bkt.clouddn.com/bdtj02.jpg)



#### 添加README.md文件
每个项目下一般都有一个 README.md 文件，但是使用 hexo 部署到仓库后，项目下是没有 README.md 文件的。

在 Hexo 目录下的 source 根目录下添加一个 README.md 文件，修改站点配置文件 _config.yml ，将 skip_render 参数的值设置为

```skip_render: README.md```
保存退出即可。再次使用 hexo d 命令部署博客的时候就不会在渲染 README.md 这个文件了。
#### 设置网站图标favicon
\themes\next\_config.yml 搜索favicon 找到下列代码进行设置,需替换图片
```yaml
favicon:
  small: /images/favicon16.png
  medium: /images/favicon32.png
  apple_touch_icon: /images/favicon-apple.png
  safari_pinned_tab: /images/skylogo.svg
  #android_manifest: /images/manifest.json
  #ms_browserconfig: /images/browserconfig.xml
```
*images全路径 \themes\next\source\images*

#### 文章底部增加版权信息

#### 添加评论(来比力)功能
先看效果图
![](http://qah1aj2e1.bkt.clouddn.com/livere.jpg)
[来比力注册](https://livere.com),按流程注册,点击安装选city版本,获取data-uid
themes/next/_config.yml配置文件，定位到livere_uid字段，粘贴上刚刚获取的data-uid。
至此，大功告成。

#### 隐藏网页底部 powered By Hexo / 强力驱动
themes\next\_config.yml 搜索powered 修改值为false
```yaml
# Powered by Hexo & NexT
  powered: true
```

#### 设置网页底部的桃心
还是打开themes/next/_config.yml_找到下面代码段进行设置
```yaml
footer:
  # Specify the date when the site was setup. If not defined, current year will be used.
  #since: 2015

  # Icon between year and copyright info.
  icon:
    # Icon name in Font Awesome. See: https://fontawesome.com/icons
    name: fa fa-user
    # If you want to animate the icon, set it to true.
    animated: true
    # Change the color of icon, using Hex Code.
    color: "#01A0FE"
```
*name 对应图标可选自己喜欢的图标*

#### 添加社交分享


#### 博文置顶

#### 修改字体大小


#### 开启打赏功能
默认是不开启的,themes\next\_config.yml 找到如下代码进行设置
```yaml
reward_settings:
  # If true, reward will be displayed in every article by default.
  enable: true
  animation: true
  #comment: Donate comment here.

reward:
  #wechatpay: /images/wechatpay.png
  alipay: /images/alipay.png
  #paypal: /images/paypal.png
  #bitcoin: /images/bitcoin.png
```
*images对应themes/next/source/images*
默认样式hover效果有点难看,可修改样式
修改文件next/source/css/_common/components/post/post-reward.styl,修改hover时 color值为#fff
```css
&:hover {
      background: #fc6423;
      border: 1px solid transparent;
      color: #fff;
    }
```


#### 侧边栏推荐阅读
themes\next\_config.yml 找到如下代码进行设置
```yaml
# Blog rolls
links_settings:
  icon: fa fa-link
  title: 推荐阅读
  # Available values: block | inline
  layout: block

links:
  推荐网站一: http://yoursite.com
```

#### 博文压缩
在站点的根目录下执行以下命令：
```bash
$ npm install gulp -g
$ npm install gulp-minify-css gulp-uglify gulp-htmlmin gulp-htmlclean gulp --save

```
站点的根目录下创建文件gulpfile.js ，并填入以下内容
```javascript
var gulp = require('gulp');
var minifycss = require('gulp-minify-css');
var uglify = require('gulp-uglify');
var htmlmin = require('gulp-htmlmin');
var htmlclean = require('gulp-htmlclean');
// 压缩 public 目录 css
gulp.task('minify-css', function() {
    return gulp.src('./public/**/*.css')
        .pipe(minifycss())
        .pipe(gulp.dest('./public'));
});
// 压缩 public 目录 html
gulp.task('minify-html', function() {
  return gulp.src('./public/**/*.html')
    .pipe(htmlclean())
    .pipe(htmlmin({
         removeComments: true,
         minifyJS: true,
         minifyCSS: true,
         minifyURLs: true,
    }))
    .pipe(gulp.dest('./public'))
});
// 压缩 public/js 目录 js
gulp.task('minify-js', function() {
    return gulp.src('./public/**/*.js')
        .pipe(uglify())
        .pipe(gulp.dest('./public'));
});
// 执行 gulp 命令时执行的任务
gulp.task('default', [
    'minify-html','minify-css','minify-js'
]);
```
生成博文是执行 hexo g && gulp 就会根据 gulpfile.js 中的配置，对 public 目录中的静态资源文件进行压缩。


#### 在头部添加 fork me on github
方法一: 直接开启配置即可
```yaml
github_banner:
  enable: true
  permalink: https://github.com/skygiter
  title: Follow me on GitHub
```
github_banner:
  enable: true
  permalink: https://github.com/skygiter
  title: Follow me on GitHub

方法二:
[选择代码点这里](https://github.blog/2008-12-19-github-ribbons/)
代码示例
```html
<a href="https://github.com/you"><img width="149" height="149" src="https://github.blog/wp-content/uploads/2008/12/forkme_right_green_007200.png?resize=149%2C149" class="attachment-full size-full" alt="Fork me on GitHub" data-recalc-dims="1"></a>
```
复制代码到themes\next\layout\_layout.swig文件&lt;div class="headband"></div&gt;里
*说明:需修改链接为自己的地址,如果想打开新链接可在a标签上添加  target="_blank";我用这个代码样式错位了,我使用的代码如下*
```html
<a href="https://github.com/skygiter" class="github-corner" aria-label="View source on Github" targit="_blank"><svg width="80" height="80" viewBox="0 0 250 250" style="fill:#151513; color:#fff; position: absolute; top: 0; border: 0; right: 0;" aria-hidden="true"><path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path><path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"></path><path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"></path></svg></a>
```
*方法二是看的其它教程里的，后来发现配置里面已经有了就果断用方法一了,样式有一点区别,方法二中顶部有一条黑线*

#### 底部开启 fork me
themes\next\_config.yml配置下面代码
```yaml
follow_me:
  #Twitter: https://twitter.com/username || fab fa-twitter
  #Telegram: https://t.me/channel_name || fab fa-telegram
  #WeChat: /images/wechat_channel.jpg || fab fa-weixin
  RSS: /atom.xml || fa fa-rss
  Github: https://github.com/skygiter || fab fa-github
```


#### 参考文章
1. [主要参考文章](https://segmentfault.com/a/1190000009544924)
2. [图片显示](https://blog.csdn.net/xjm850552586/article/details/84101345)

