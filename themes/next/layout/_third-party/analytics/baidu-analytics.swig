{%- if theme.baidu_analytics %}
  <script{{ pjax }}>
    var _hmt = _hmt || [];
    (function() {
      var hm = document.createElement("script");
      if(window.location.href.indexOf('skygiter.gitee.io')!=-1){
        hm.src = "https://hm.baidu.com/hm.js?dba52c6556670659922ba08b29c8abc4";
      }else{
        hm.src = "https://hm.baidu.com/hm.js?{{ theme.baidu_analytics }}";
      }
      var s = document.getElementsByTagName("script")[0];
      s.parentNode.insertBefore(hm, s);
    })();
  </script>
{%- endif %}
