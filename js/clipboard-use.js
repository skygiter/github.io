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
