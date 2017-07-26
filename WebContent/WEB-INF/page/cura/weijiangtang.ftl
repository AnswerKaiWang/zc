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
<div class="banner"></div>
<style type="text/css">
/*本页样式*/
body{background-color: #f9f9f9;}
</style>
<!-- main s -->
<div class="main">
	<p class="ty_title"><span>市场活动/<i>ACTIVITIES</i></span></p>
  <p class="wjt_tab_title"><a href="${base}/cura/activity/ago.htm">往期回顾</a><a href="${base}/cura/lecture/main.htm" class="active">微讲堂</a></p>
  <div class="wjt_content">
    <ul class="ul" id="lectureListId">
    </ul>
  </div>
  <div class="page_2">
    <a href="javascript:void(0);" onclick="javascript:goPage(1);" title="首页">&lt;&lt;</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(2);" title="上一页">&lt;</a>
    <a href="javascript:void(0);" class="active" id="curPageId">1</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(3);" title="下一页">&gt;</a>
    <a href="javascript:void(0);" onclick="javascript:goPage(4);" title="尾页">&gt;&gt;</a>
 </div>
</div>
<script >
	var start = 1;
	var maxPage = 1;
	var total = 1;
	
	$(function(){
		goPage(1);
	});
	
	function addRow(row){
    	var li = '<li><a href="${base}/cura/lecture/detail.htm?id='+row.id+'" class="aimg"><img src="${base}'+row.cover+'" alt=""><em></em><i class="ico ico-play"></i></a>'
	      	+'<h5 class="bj"><b></b></h5><h3><a href="${base}/cura/lecture/detail.htm?id='+row.id+'">'+row.title+'</a></h3><p>'+row.brief+'</p>'      
      		+'</li>';
        $("#lectureListId").append(li);
        
        $('.wjt_content').find('.aimg').hover(function() {
			$(this).find('em').show();
			$(this).find('.ico-play').show();
			$(this).find('.ico-play').addClass('bounceIn  animated');
		},function() {
			$(this).find('em').hide();
			$(this).find('.ico-play').hide();
			$(this).find('.ico-play').removeClass('bounceIn  animated');
		});
    }
    function goPage(num){
		$("#lectureListId").empty();
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
    	asyncPost("${base}/cura/lecture/list.htm",
    	{
    		pageSize:8,
    		start : start 
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
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>