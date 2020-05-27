{%- if page.comments %}
<script>
if(window.location.href.indexOf('skygiter.gitee.io')!=-1){
  document.querySelector('#lv-container').setAttribute("data-uid","MTAyMC81MDI3NS8yNjc2NQ==")
}
NexT.utils.loadComments(document.querySelector('#lv-container'), () => {
  window.livereOptions = {
    refer: location.pathname.replace(CONFIG.root, '').replace('index.html', '')
  };
  (function(d, s) {
    var j, e = d.getElementsByTagName(s)[0];
    if (typeof LivereTower === 'function') { return; }
    j = d.createElement(s);
    j.src = 'https://cdn-city.livere.com/js/embed.dist.js';
    j.async = true;
    e.parentNode.insertBefore(j, e);
  })(document, 'script');
});
</script>
{%- endif %}
