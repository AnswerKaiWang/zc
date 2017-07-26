<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<meta name="renderer" content="webkit" />
<title>中城投资</title>
<link type="text/css" rel="stylesheet" href="${base}/frontCura/style/font_1470257308_7612898.css" />
<link type="text/css" rel="stylesheet" href="${base}/frontCura/style/animate.css" />
<link type="text/css" rel="stylesheet" href="${base}/frontCura/style/index.css" />
<link type="text/css" rel="stylesheet" href="${base}/frontCura/style/layer.css" />
<link type="text/css" rel="stylesheet" href="${base}/frontCura/style/select2.min.css" />
<script type="text/javascript">
	var base = '${base}'
</script>
<script  type="text/javascript" src="${base}/frontCura/js/jquery-1.7.1.js"></script>
<script  type="text/javascript" src="${base}/frontCura/js/common.js"></script>
<script  type="text/javascript" src="${base}/frontCura/js/global.js"></script>
<script  type="text/javascript" src="${base}/frontCura/js/layer.js"></script>
<script  type="text/javascript" src="${base}/frontCura/js/select2.min.js"></script> 
<script  type="text/javascript" src="${base}/frontCura/js/roundabout.js"></script>
<script  type="text/javascript" src="${base}/frontCura/js/roundshapes.js"></script>
<script  type="text/javascript"  src="${base}/frontCura/js/easydropdown.min.js"></script>  
<script  type="text/javascript" src="${base}/frontCura/js/placeholder.min.js"></script>
<script  type="text/javascript" src="${base}/frontCura/js/product.js"></script>
<!--[if lt IE 9]>
<script src="${base}/frontCura/js/ie/html5.js"></script>
<script src="${base}/frontCura/js/ie/selectivizr-min.js"></script>
<![endif]-->
</head>
<body>
[#include "/cura/common/header.ftl"]
[#include "/cura/common/caifu.ftl"]
<!-- banner s -->
<div class="banner switch_Box_banner">
  <div class="push-product">
  	<div class="container">
    <ul class="list-product list-product-1" id="j_push_product">
    	 [#list banners as b]
    	 	<li>
	        <h3 class="h3">${b.title}</h3>
	        <img src="${base}${(b.cover)!}" alt="" class="mimg">
	        <dl>
	          <dt><b>${b.deadline}</b><i>产品期限</i></dt>
	          <dd><b>${b.statusName}</b><i>产品状态</i></dd>
	        </dl>
	        <a href="javascript:void(0);" [#if b.disabled==0] onclick="javascript:toPDetail('${b.fundId}');" [/#if]  class="view_details">查看详情</a>
	      </li>
    	 [/#list]
    </ul>
    <a class="prev" id="j_roundabout_prev" href="javascript:;">
        <span class="ico ico-xiangzuo1"></span>
      </a>
      <a class="next" id="j_roundabout_next" href="javascript:;">
        <span class="ico ico-xiangyou1"></span>
      </a>
    </div>
  </div>
</div>
<style type="text/css">
.push-product{position: relative;}
.push-product .container{position: relative; z-index: 1; height: 349px;width: 814px;margin:0 auto;}
.push-product .prev,.push-product .next{position: absolute; left: -200px; top: 50%; z-index: 2; width: 32px; height: 66px;line-height: 66px; margin-top: -33px; cursor: pointer; opacity: .5; filter: alpha(opacity=50);font-size: 40px;color: #fff;}
.push-product .prev .ico,.push-product .next .ico{margin-top: 4px;}
.push-product .prev:hover,.push-product .next:hover{opacity: 1; filter: alpha(opacity=100);}
.push-product .next{left: auto; right: -200px;}
.push-product .roundabout-holder{width: 814px;width: 780px;width: 814px;top: 160px;margin-left: auto; margin-right: auto;border: 1px solid #f00;}
.push-product .roundabout-moveable-item{ background-color:#f3f3f3; border-top-color: #f3f3f3;}
.list-product-1 li{position: relative; z-index: 1; float: left;  width: 385px; text-align: center; background-color: #fff;padding-bottom: 25px;}

.list-product-1 li:before { display: block; content: "."; height: 2px; width: 100%; font-size: 0; line-height: 0; background-color: #d7a64a; position: absolute; left: 0; top: 0; z-index: 10; display: none; }
.list-product-1 li:after { display: block; content: "."; height: 0; width: 0; clear: both; font-size: 0; line-height: 0; border-left: 4px solid transparent; border-right: 4px solid transparent; border-top: 4px solid #d7a64a; display: block; position: absolute; left: 50%; margin-left: -2px; top: 2px; z-index: 11; display: none; }
.list-product-1 li.roundabout-in-focus:before, .list-product-1 li.roundabout-in-focus:after { display: block; }
.list-product-1 li .h3 { font-weight: normal; font-size: 16px; color: #bd9548; overflow: hidden; text-align: center; white-space: normal; -ms-text-overflow: ellipsis; -o-text-overflow: ellipsis; -moz-text-overflow: ellipsis; -webkit-text-overflow: ellipsis; text-overflow: ellipsis; padding: 15px 0; }
.list-product-1 li .mimg { width: 100%; height: 145px; display: block; }
.list-product-1 li.roundabout-in-focus .mimg { height: 150px;}
.list-product-1 li dl { overflow: hidden; width: 100%; clear: both; margin-top: 10px; background: url(images/dff.jpg) center top repeat-y; }
.list-product-1 li dl dt { overflow: hidden; width: 45%; padding-right: 5%; float: left; display: inline-block; vertical-align: middle; text-align: right; }
.list-product-1 li dl dd { overflow: hidden; width: 45%; padding-left: 5%; float: right; display: inline-block; vertical-align: middle; text-align: left; }
.list-product-1 li dl dt b, .list-product-1 li dl dd b { display: block; color: #a7b9c8; font-size: 15px; font-weight: normal; margin-bottom: 5px; }
.list-product-1 li dl dt i, .list-product-1 li dl dd i { display: block; color: #777; font-size: 12px; }
.list-product-1 li .view_details { display: block; height: 25px; line-height: 25px; text-align: center; width: 40%; margin: 9px auto 0; -webkit-border-radius: 3px; -moz-border-radius: 3px; -o-border-radius: 3px; -ms-border-radius: 3px; border-radius: 3px; border: 1px solid #c19f66; color: #fff; }
.list-product-1 li .view_details:hover { color: #fff; }
</style>
<!-- banner e -->
<script type="text/javascript">
$(document).ready(function(){
	productApp.productList(); 
});
$(function(){
    $('#select_linkage').find('.select2:first').find('.select2-selection__rendered').text("所在省份")
    $('#select_linkage').find('.select2:last').find('.select2-selection__rendered').text("所在城市")
});
$('.select').select2({
      theme: "classic",
       minimumResultsForSearch: Infinity
});
</script>
<!-- main s -->
<div class="main">
  <p class="mt25"></p>
  <form action="">
    <dl class="jjcp_choice_list">
      <dt>产品类别：</dt>
      <dd id="fundType">
        <a href="javascript:void(0);" did = '0' onclick="javascript:choiceSearchProduct(this,goPage);" class="active">全部</a>
        [@dict name="fundType" ]
    	[#list dictList as st]
    		<a href="javascript:void(0);" did='${st.id}' onclick="javascript:choiceSearchProduct(this,goPage);">${st.name}</a>
    	[/#list]
    	[/@dict]
      </dd>
    </dl>
    <dl class="jjcp_choice_list">
      <dt>产品期限：</dt>
      <dd id="fundDeadline">
        <a href="javascript:void(0);" did='0' onclick="javascript:choiceSearchProduct(this,goPage);" class="active">全部</a>
        [@dict name="fundDuration" ]
    	[#list dictList as st]
    		<a href="javascript:void(0);" did='${st.id}' onclick="javascript:choiceSearchProduct(this,goPage);">${st.name}</a>
    	[/#list]
    	[/@dict]
      </dd>
    </dl>
    <div class="jjcp_search clearfix">
        <span class="sld_wrap"><input type="text" name="seriesName" id="seriesName"  class="ipt1" placeholder="请输入产品系列名称搜索"></span>
        <button type="button" class="submit" id="searchProductBtn"><i class="ico ico-sousuo"></i></button>     
    </div>
  </form>
  <script type="text/javascript">
  $(document).ready(function(){
    $('input[placeholder], textarea[placeholder]').each(function(){
      $(this).is('input')?$(this).iePlaceholder():$(this).iePlaceholder({onInput: false});
    });
    $("#searchProductBtn").on("click",function(e){
    	e.preventDefault();
    	goPage(1);
    });
  });
  </script>
  <!-- jjcp_list s -->
  <div class="jjcp_list">
    <ul id="rows">
    </ul>
  </div>
  <!-- jjcp_list e -->
  <div class="page_2">
  	<a href="javascript:void(0);" onclick="javascript:goPage(1);" title="首页">&lt;&lt;</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(2);" title="上一页">&lt;</a>
    <a href="javascript:void(0);" class="active" id="curPageId">1</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(3);" title="下一页">&gt;</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(4);" title="尾页">&gt;&gt;</a>
   </div>
</div>
<script type="text/javascript">
	var start = 1;
	var maxPage = 1;
	var total = 1;
	$(function(){
		goPage(1);
	});
    function goPage(num){
    	if(!num){
    		num = 1;
    	}
		$("#rows").empty();
		var ft = $("dd[id='fundType'] a[class='active']").attr("did");
		var fd = $("dd[id='fundDeadline'] a[class='active']").attr("did");
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
    	asyncPost("${base}/cura/fund/projects.htm",
    	{
    		pageSize:8,
    		start : start,
    		seriesName: encodeURI($("#seriesName").val()),
    		fundType: ft,
    		deadline: fd 
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
    function addRow(row){
    	var li = '<li><div class="L fl"><h3 class="h3"><a href="javascript:void(0);">'+((!!row.title)?row.title:"")+'</a></h3>'
          +'<h4 class="h4"><span>产品期限：'+((!!row.deadline)?row.deadline:"")+'</span><span>产品状态：'+row.statusName+'</span></h4>'
          +'<p class="p">产品特点：'+((!!row.fundNature)?row.fundNature:"")+'</p>';
          if(row.fundStatus != 89){
	    	  li= li+'</div><div class="R fr"><a href="javascript:void(0);" class="yy_button disabled">查看详情</a></div></li>';
	      }else{
	      	  li= li+'</div><div class="R fr"><a href="javascript:void(0);" onclick="javascript:toPDetail('+row.fundId+');" class="yy_button">立即预约</a></div></li>';
	      }
        $("#rows").append(li);
        $('a.yy_button').addClass('hvr-sweep-to-right-o');
        $('a.yy_button').each(function(){
       	 	var cl=$(this).text();
			$(this).empty();
			$(this).prepend("<span class='button_txt_wrap'>"+cl+"</span>")
    	});
    }
    
    function toPDetail(id){
    	var cardNo = "${loginSuccessKey.cardNo}";
    	if(!cardNo){
    		alertConfirm("温馨提示","请您完善个人信息，便于了解更多产品信息!","确定",function(){
    			window.document.location = "${base}/cura/cust/base.htm?productId="+id;
    		},"取消");
    		return false;
    	}
    	window.document.location = "${base}/cura/fund/detail.htm?id="+id;
    }
</script>
<script>
/*鼠标进去效果*/
$(".roundabout-moveable-item").mouseenter(
  function(){
	  clearInterval(t)/*鼠标进入时，停止t的走动效果*/
  }
)
/*鼠标离开效果*/
$(".roundabout-moveable-item").mouseleave(
  function(){
	  t=setInterval(run,5000) /*鼠标离开时，继续播放t的走动效果*/
  }
)
/*定时器设定*/
function run(){
	var fc = $(".roundabout-moveable-item .roundabout-in-focus");
	if(!!fc){
		var next = $(fc).next();
		if(!!next){
			$(next).click();
		}else{
			next = $(".roundabout-moveable-item:first");
			if(!!next){
				$(next).click();
			}
		}
	}
}
var t=setInterval(run,5000) 
</script>
<!-- main e --> 
[#include "/cura/common/footer.ftl"]
</body>
</html>