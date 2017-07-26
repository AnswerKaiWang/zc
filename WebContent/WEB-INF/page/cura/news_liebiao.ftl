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
  <div class="ago_title">
    <p class="border"></p>
    <ul class="ul fl">
      <li yid="${now}" class="active"><a href="javascript:void(0);" onclick="javascript:goPage(1,'${now}');">${now}<em></em></a></li>
      <li yid="${pre1}"><a href="javascript:void(0);" onclick="javascript:goPage(1,'${pre1}');">${pre1}<em></em></a></li>
      <li yid="${pre2}"><a href="javascript:void(0);" onclick="javascript:goPage(1,'${pre2}');">${pre2}<em></em></a></li>
      <li yid="${pre3}"><a href="javascript:void(0);" onclick="javascript:goPage(1,'${pre3}');"><i class="ico ico-gengduo"></i><em></em></a></li>
    </ul>
    <div class="r_search fr">
      <form action="">
        <span class="sld_wrap"><input type="text" id="keyword" name="keyword" class="ipt1" placeholder="请输入您要查询快讯内容"></span>
        <button type="button" class="submit" onclick="javascript:goPage(1);"><i class="ico ico-sousuo"></i></button>
      </form>
    </div>
  </div>
  <!-- news_list s -->
  <div class="news_list" id="newsList">
  </div>
  <!-- news_list e -->
  <div class="page_2">
    <a href="javascript:void(0);" onclick="javascript:goPage(1);" title="首页">&lt;&lt;</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(2);" title="上一页">&lt;</a>
    <a href="javascript:void(0);" class="active" id="curPageId">1</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(3);" title="下一页">&gt;</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(4);" title="尾页">&gt;&gt;</a>
 </div>
  <dl class="disclaimer">
    <dt>免责声明</dt>
    <dd>
      <p>1、本网站信息均来源于市场公开资料，中城仅基于上述公开资料阐述中城观点，并不保证其准确性、完整性、实时性或正确性。本网站的信息和内容仅供参考，请谨慎使用。</p>
      <p>2、本网站信息中署名"中城投资"、"中城联合财富"的文章，以及图片和音视频资料，版权均属于中城投资及联合财富中心所有。如需转载请与中城联合财富联系，并在授权的范围内注明来源和作者保证作品的完整性。违反上述声明者，本网站将追究相关法律责任。</p>
      <p>3、本网站转载其他媒体或机构的作品，并不意味赞同其观点或证实其内容的真实性。如其他媒体、网站或个人从本网下载使用，必须保留本网注明的"来源"，并自负版权等法律责任。</p>
    </dd>
  </dl>
</div>
<script>
	var start = 1;
	var maxPage = 1;
	var total = 1;
	$(function(){
		goPage(1);
	});
	function addRow(row){
    	var li = 
    	'<dl class="list_item">'
      	+'<dt><a href="${base}/cura/news/details.htm?id='+row.id+'"><img src="${base}'+row.cover+'" width="349" height="224" alt=""></a></dt>'
      	+'<dd>'
        +'<h3><a href="${base}/cura/news/details.htm?id='+row.id+'">'+row.title+'}</a></h3>'
        +'<p class="p1">'+row.brief+'</p>'
        +'<p class="p0">'+row.publishTime+'</p>'
        +'<p class="p2"><a href="${base}/cura/news/details.htm?id='+row.id+'" class="more fl">阅读全文&nbsp;&gt;&gt;</a><i class="ico ico-fenxiang fr"></i></p>'
      	+'</dd>'
    	+'</dl>';
        $("#newsList").append(li);
    }
    function goPage(num,year){
    	if(!year){
    		year = $(".ago_title li[class='active']").attr("yid");
    	}else{
    		//点击年份
    		$(".ago_title li[yid='"+year+"']").addClass("active");
    		$(".ago_title li[yid='"+year+"']").siblings().removeClass("active");
    	}
		$("#newsList").empty();
		if(num ==1){
			start = 1;
		}else if(num ==2){//上一页
			if(start >1){
				start = start -1;
			}else{
				start = 1;
			}
		}else if(num ==3){//下一页
			if(start < maxPage){
				start = start +1;
			}else{
				start = maxPage;
			}
		}else if(num ==4){//最后一页
			start = maxPage;
		}
    	asyncPost("${base}/cura/news/list.htm",
    	{
    		pageSize:8,
    		start : start,
    		year: year,
    		keyword : encodeURI($("#keyword").val())
    	},
    	function(dd){
    		if(!!dd){
    			maxPage = dd.totalPages;
    			total = dd.totalCounts;
    			$("#curPageId").text(start+"/"+maxPage);
    			//重置页面
    			for(var ind in dd.data){
    				addRow(dd.data[ind]);
    			}
    		}
    	});
    }
</script>
<script>
	$("#newSearchBtn").on("click",function(){
		var keyword = $("#keyword").val();
		if(!!keyword){
			keyword = encodeURI(encodeURI(keyword));
		}
		window.document.location = '${base}/cura/news/liebiao.htm?year=${year}&keyword='+ keyword;
	});
</script>
<!-- main e -->
<!-- 分享代码 s -->     
<div class="bdsharebuttonbox bdsharebuttonbox_style_1"><i class="jiao"></i><a class="aa">分享到：</a><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a></div> 
<script type="text/javascript">
window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"24"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>  
<!-- 分享代码 e -->
<!-- 返回顶部 s -->
<a href="javascript:void(0);" id="back_top"><i class="ico ico-shangjiantou"></i><span>返回顶部</span></a>
<!-- 返回顶部 e -->
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>