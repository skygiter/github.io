---
title: Hexo踩坑集锦
date: 2020-05-27 11:56:24
tags: Hexo
---
### 草稿文章
```yaml
//新建
$ hexo new draft "new draft"
```

```yaml
//如果你希望强行预览草稿，更改配置文件：
render_drafts: true   //经测试发布的时候草稿也会发布

//或者，如下方式启动server：
$ hexo server --drafts

//把草稿变成文章，或者页面：
$ hexo publish [layout] <filename>
```


