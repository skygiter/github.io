{%- if theme.baidu_analytics %}
  <script{{ pjax }}>
    var _hmt = _hmt || [];
    (function() {
      var hm = document.createElement("script");
      if(window.location.href.indexOf('skygitcom.gitee.io')!=-1){
        hm.src = "https://hm.baidu.com/hm.js?81116f79b6c419d522f77c65a1d4a64c";
      }else{
        hm.src = "https://hm.baidu.com/hm.js?{{ theme.baidu_analytics }}";
      }
      var s = document.getElementsByTagName("script")[0];
      s.parentNode.insertBefore(hm, s);
    })();
  </script>
{%- endif %}
