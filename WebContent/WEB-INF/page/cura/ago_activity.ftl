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
<!-- banner s -->
<div class="banner_Slide">
  <div class="hd"></div>
  <div class="bd">
    <ul>
      <li style="background:url(${base}/frontCura/images/banner_1.jpg) center top no-repeat;"><a href="###"></a></li>
      <li style="background:url(${base}/frontCura/images/banner_1.jpg) center top no-repeat;"><a href="###"></a></li>
      <li style="background:url(${base}/frontCura/images/banner_1.jpg) center top no-repeat;"><a href="###"></a></li>
      <li style="background:url(${base}/frontCura/images/banner_1.jpg) center top no-repeat;"><a href="###"></a></li>
      <li style="background:url(${base}/frontCura/images/banner_1.jpg) center top no-repeat;"><a href="###"></a></li>
    </ul>
  </div>
  <a href="javascript:void(0);" class="prev"><i class="ico ico-zu"></i></a> <a href="javascript:void(0);" class="next"><i class="ico ico-you"></i></a> 
  <script type="text/javascript" src="${base}/frontCura/js/jquery.SuperSlide.2.1.1.js"></script> 
  <script type="text/javascript">
		$('.banner_Slide').find('.hd').append("<ul></ul>")
			for(i=0;i<$('.banner_Slide').find('.bd').find('li').length;i++){
				$('.banner_Slide').find('.hd').find('ul').append("<li>"+(i+1)+"</li>")
			};
		   jQuery(".banner_Slide").slide({titCell:".hd li",mainCell:".bd ul",effect:"leftLoop",autoPlay:true,trigger:"click"});
		</script> 
</div>
<!-- banner e -->
<!-- main s -->
<div class="main">
	<p class="ty_title"><span>市场活动/<i>ACTIVITIES</i></span></p>
  <p class="wjt_tab_title"><a href="${base}/cura/activity/ago.htm" class="active">往期回顾</a><a href="${base}/cura/lecture/main.htm">微讲堂</a></p>  
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
        <span class="sld_wrap"><input type="text" name="keyword" id="keyword" class="ipt1" placeholder="请输入您要查询的时间"></span>
        <button type="button" class="submit" onclick="javascript:goPage(1);"><i class="ico ico-sousuo"></i></button>
      </form>
    </div>
  </div>
  <script type="text/javascript"  src="${base}/frontCura/js/easydropdown.min.js"></script>  
  <script type="text/javascript" src="${base}/frontCura/js/placeholder.min.js"></script>
  <script type="text/javascript">
  //placeholder
  $(document).ready(function(){
    $('input[placeholder], textarea[placeholder]').each(function(){
      $(this).is('input')?$(this).iePlaceholder():$(this).iePlaceholder({onInput: false});
    });
  });
  </script>
  <!-- ago_list s -->
  <div class="ago_list" id="agoActList">
  </div>
  <!-- ago_list e -->
  <div class="page_2">
    <a href="javascript:void(0);" onclick="javascript:goPage(1);" title="首页">&lt;&lt;</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(2);" title="上一页">&lt;</a>
    <a href="javascript:void(0);" class="active" id="curPageId">1</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(3);" title="下一页">&gt;</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(4);" title="尾页">&gt;&gt;</a>
 </div>
</div>
<script>
var start = 1;
	var maxPage = 1;
	var total = 1;
	$(function(){
		goPage(1);
	});
	function addRow(row){
		var t = ''+row.startTime;
    	var li = '<dl class="list_item">'
      	+'<dt><span class="date"><i>'+(t.substring(5,7))+'月</i><b>'+(t.substring(8,10))+'</b><em class="jiao"></em></span><a href="${base}/cura/activity/ago/detail.htm?id='
      	+row.id+'"><img src="${base}'+row.cover+'" width="349" height="224" alt=""></a></dt>'
      	+'<dd>'
        +'<h3><a href="#">'+row.title+'</a></h3>'
        +'<p class="p1">'+row.content+'</p>'
        +'<p class="p2"><a href="${base}/cura/activity/ago/detail.htm?id='+row.id+'" class="more fl">阅读全文&nbsp;&gt;&gt;</a><i class="ico ico-fenxiang fr"></i></p>'
      	+'</dd>'
   		+'</dl>';
        $("#agoActList").append(li);
    }
    function goPage(num,year){
    	if(!year){
    		year = $(".ago_title li[class='active']").attr("yid");
    	}else{
    		//点击年份
    		$(".ago_title li[yid='"+year+"']").addClass("active");
    		$(".ago_title li[yid='"+year+"']").siblings().removeClass("active");
    	}
		$("#agoActList").empty();
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
    	asyncPost("${base}/cura/activity/list.htm",
    	{
    		pageSize:8,
    		start : start,
    		year: year,
    		keyword : encodeURI($("#keyword").val())
    	},
    	function(dd){
    		if(!!dd){
    			$("#curPageId").text(start);
    			maxPage = dd.totalPages;
    			total = dd.totalCounts;
    			//重置页面
    			for(var ind in dd.data){
    				addRow(dd.data[ind]);
    			}
    		}
    	});
    }
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