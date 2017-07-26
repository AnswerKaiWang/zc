<!doctype html>
<html>
<head>
<meta charset="utf-8">
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
  <p class="ty_title"><span>市场活动/<i>ACTIVITIES</i></span></p>
  <p class="wjt_tab_title">
  <a href="javascript:void(0);" class="active">[#if (nowActs?size >0)]当期活动[/#if][#if (nowActs?size <=0)]往期活动[/#if]</a>
  <a href="${base}/cura/lecture/main.htm">微讲堂</a></p>
  [#list nowActs as nowAct]
  <div class="dqhd_top">
    <div class="L">
      <a href="###"><img src="${base}/frontCura/images/n.jpg" width="447" height="392" alt=""></a>
    </div>
    <div class="R">
      <h3 class="h3 clearfix"><a href="${base}/cura/activity/detail.htm?id=${nowAct.id}" class="fl fla">${nowAct.title}<i style="color: ##e09717;">[详情]</i></a><i class="ico ico-fenxiang fr"></i></h3>
      <p class="p">${nowAct.subhead}...</p>
      <ul class="ul">
        <li><i class="ico ico-shizhong"></i><span class="rsp">活动时间：${nowAct.startTime}-${nowAct.endTime}</span></li>
        <li><i class="ico ico-zuobiao"></i><span class="rsp">活动地址：${nowAct.address}<a href="#" class="mp">查看地图</a></span></li>
        <li><i class="ico ico-users"></i><span class="rsp">活动人数：<i class="num">${nowAct.maxNum}</i>人</span></li>
      </ul>
      <div class="Bwrap">
        <a href="javascript:void(0);" class="bm" id="a_sign" onclick="javascript:openApply('${nowAct.id}');">活动报名</a>
        [#if (nowAct.managers?size <2)]
        	<div class="item_ct fl">
	          <dl>
	            <dt><img src="${base}${nowAct.managers[0].avatar}" alt=""></dt>
	            <dd>
	              <h3>${nowAct.managers[0].name} ${nowAct.managers[0].gender}</h3>
	              <h4>${nowAct.managers[0].duty}</h4>
	            </dd>
	          </dl>
	          <p class="bp">${nowAct.managers[0].brief}</p>
	        </div>
	        <div class="item_ct fr">
	          <dl>
	            <dt><img src="#" alt=""></dt>
	            <dd>
	              <h3></h3>
	              <h4></h4>
	            </dd>
	          </dl>
	          <p class="bp"></p>
	        </div>
        [/#if]
        [#if (nowAct.managers?size >=2)]
        	<div class="item_ct fl">
	          <dl>
	            <dt><img src="${base}${nowAct.managers[0].avatar}" alt=""></dt>
	            <dd>
	              <h3>${nowAct.managers[0].name} ${nowAct.managers[0].gender}</h3>
	              <h4>${nowAct.managers[0].avatar}</h4>
	            </dd>
	          </dl>
	          <p class="bp">${nowAct.managers[0].brief}</p>
	        </div>
	        <div class="item_ct fr">
	          <dl>
	            <dt><img src="${base}${nowAct.managers[1].avatar}" alt=""></dt>
	            <dd>
	              <h3>${nowAct.managers[1].name} ${nowAct.managers[1].gender}</h3>
	              <h4>${nowAct.managers[1].duty}</h4>
	            </dd>
	          </dl>
	          <p class="bp">${nowAct.managers[1].brief}</p>
	        </div>
        [/#if]
      </div>      
    </div>
  </div>
  [/#list]
  <!-- 往期活动 -->
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
        <span class="sld_wrap"><input type="text" name="keyword" id="keyword" class="ipt1" placeholder="请输入您要查询的关键字"></span>
        <button type="button" id="searchBtn" class="submit" onclick="javascript:goPage(1);"><i class="ico ico-sousuo"></i></button>
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
[#include "/cura/common/apply.ftl"]
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