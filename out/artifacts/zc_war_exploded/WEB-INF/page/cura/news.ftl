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
<!-- banner_link s -->
<div class="banner_link">
      <div class="fl"><h1></h1><a href="${base}/cura/news.htm"><p class="fadeInUp animated"><span>投资快讯<i>SMARTFORTUNE NEWS</i></span><em class="ico ico-you"></em></p></a></div>
      <div class="fr"><h1></h1><a href="${base}/cura/activity.htm" class="fr"><p class="fadeInUp animated"><span>市场活动<i>MARKETING ACTIVITIES</i></span><em class="ico ico-you"></em></p></a></div>
   </div>
<!-- banner_link e -->
<!-- main s -->
<div class="main">
  <div class="news_L">
    <h3 class="h3">FINANCIAL<i>INFORMATION</i></h3>
    <h4 class="h4">投资快讯</h4>
    <a href="${base}/cura/news/liebiao.htm" class="more_news">更多快讯</a> </div>
  <div class="news_R">
    <div class="picScroll_L">
      <div class="hd"> <a href="javascript:void(0);" class="next"><i class="ico ico-you"></i></a>
        <a href="javascript:void(0);" class="prev"><i class="ico ico-zu"></i></a></div>
      <div class="bd">
        <ul>
        	[#list news as nw]
          <li><a href="${base}/cura/news/details.htm?id=${nw.id}" class="a1"><img src="${base}${nw.cover}" alt="" class="timg">
            <h4>${nw.publishTime}</h4>
            <h3>${nw.title}</h3>
            <p>${nw.brief}</p>
            </a>
            <h5 class="more_share"><a href="${base}/cura/news/details.htm?id=${nw.id}" class="more">阅读全文&nbsp;&gt;&gt;</a>
              <span class="share_r"><i class="ico ico-fenxiang"></i></span>
            </h5>
          </li>
          [/#list]
        </ul>
      </div>
    </div>  
    <script type="text/javascript" src="${base}/frontCura/js/jquery.SuperSlide.2.1.1.js"></script>
    <script type="text/javascript">
      jQuery(".picScroll_L").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"leftLoop",scroll:3,vis:3,pnLoop:false});  
    </script> 
  </div>
  <p class="clear"></p>
</div>
<!-- main e -->
<!-- 分享代码 s -->
<div class="bdsharebuttonbox bdsharebuttonbox_style_1"><i class="jiao"></i>
<a class="aa">分享到：</a><a href="#" class="bds_more" data-cmd="more"></a>
<a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
<a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
<a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a>
<a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
</div> 
<script type="text/javascript">
  window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"24"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>  
<!-- 分享代码 e --> 
[#include "/cura/common/footer.ftl"]
</body>
</html>