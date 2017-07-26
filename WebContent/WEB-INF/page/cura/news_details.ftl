<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<meta name="renderer" content="webkit" />
<title>中城投资</title>
[#include "/cura/common/js.ftl"]
</head>
<body>
[#include "/cura/common/header.ftl"]
[#include "/cura/common/caifu.ftl"]
<!-- banner s -->
<div class="banner"></div>
<!-- banner e -->
<!-- main s -->
<div class="main">
  <h3 class="news_title">${news.title}</h3>
  <div class="news_share_title clearfix">
  	<span class="fl">${(news.publishTime)?string('yyyy-MM-dd')}&nbsp;&nbsp;&nbsp;来源：${news.source}</span>
    <!-- 分享代码 s -->     
    <div class="bdsharebuttonbox bdsharebuttonbox_style_2 fr"><i class="jiao"></i>
    <a class="aa">分享到：</a><a href="#" class="bds_more" data-cmd="more"></a>
    <a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
    <a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
    <a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a>
    <a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a></div> 
    <script type="text/javascript">
    window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"24"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
    </script>  
    <!-- 分享代码 e -->
  </div>  
  <!-- news_content s -->
  <div class="news_content">
       ${news.content}
  </div>
  <!-- news_content e -->
  <dl class="xgtj">
  	<dt>相关推荐</dt>
  	<dd>
  		[#list refers as rf]
    	<a href="${base}/cura/news/details.htm?id=${rf.id}"><span>${rf.title}</span><i>${rf.publishTime}</i></a>
    	[/#list]
    </dd>
  </dl>
  <dl class="disclaimer">
    <dt>免责声明</dt>
    <dd>
      <p>1、本网站信息均来源于市场公开资料，中城仅基于上述公开资料阐述中城观点，并不保证其准确性、完整性、实时性或正确性。本网站的信息和内容仅供参考，请谨慎使用。</p>
      <p>2、本网站信息中署名"中城投资"、"中城联合财富"的文章，以及图片和音视频资料，版权均属于中城投资及联合财富中心所有。如需转载请与中城联合财富联系，并在授权的范围内注明来源和作者保证作品的完整性。违反上述声明者，本网站将追究相关法律责任。</p>
      <p>3、本网站转载其他媒体或机构的作品，并不意味赞同其观点或证实其内容的真实性。如其他媒体、网站或个人从本网下载使用，必须保留本网注明的"来源"，并自负版权等法律责任。</p>
    </dd>
  </dl>
</div>
<!-- main e -->
<!-- 返回顶部 s -->
<a href="javascript:void(0);" id="back_top"><i class="ico ico-shangjiantou"></i><span>返回顶部</span></a>
<!-- 返回顶部 e -->
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>