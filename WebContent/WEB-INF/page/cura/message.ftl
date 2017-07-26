<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<meta name="renderer" content="webkit" />
<title>中城投资</title>
[#include "/cura/common/js.ftl"]
<script  type="text/javascript" src="${base}/frontCura/js/jqPaginator.js"></script>
</head>
<body>
[#include "/cura/common/header.ftl"]
[#include "/cura/common/userInfo.ftl"]
[#include "/cura/common/caifu.ftl"]
<style type="text/css">
/*本页样式*/
body{background-color: #f9f9f9;}
</style>
<!-- main s -->
<div class="main"> 
  <!-- queryPage_Left s -->
  <div class="queryPage_Left">
    <ul class="Menu">
      <li><a href="${base}/cura/cust/me.htm">我的投资</a></li>
      <li><a href="${base}/cura/cust/base.htm">我的账户</a></li>
      <li><a href="${base}/cura/cust/message.htm" class="active" >我的消息</a></li>
    </ul>
  </div>
  <!-- queryPage_Left e --> 
  <!-- queryPage_Right s -->
  <div class="queryPage_Right" id="rows">
    <p class="my_message_title"><span class="fl">系统消息</span><span class="fr">日期</span></p>
  </div>
  <!-- queryPage_Right e --> 
</div>
 <div class="pagination page_2" id="pagination2"></div>
<script type="text/javascript">
	
	function readMsg(id){
		var self = this;
		asyncPost("${base}/cura/cust/message/read.htm",{
    		id : id
    	},
    	function(data){
    		if(!!data){
    			$("#msgId_"+id).css("color","#737373");
    			$("#msgId_"+id).removeAttr("onclick");
    			var urc = $("#unreadMsgId").text();
    			if(!!urc){
    				urc = parseInt(urc);
    				if(urc >0){
    					urc = urc -1;
    					$("#unreadMsgId").text(urc);
    				}
    			}
    		}
    	});
	}
	
	function refreshProducts(num){
		$("#rows dl").each(function(index,ele){
			$(ele).remove();
		});
    	asyncPost("${base}/cura/cust/message/list.htm",
    	{
    		pageSize:5,
    		start : num
    	},
    	function(data){
    		if(!!data){
    			//重置页面
    			for(var ind in data){
    				addRow(data[ind]);
    			}
    			
    			$('.my_message_list').each(function(index, element) {
				  //显示出“更多“按钮
				  if($(this).find('dt').find('.txt').height()>$(this).find('dt').height()){
					  $(this).find('dt').find('.more').css('display','block');
				  };
				  //显示更多
				  var This=$(this)
				  var dH=$(This).find('dt').height();
				  var tH=$(This).find('dt').find('.txt').height();
				  $(This).find('dt').find('.more').click(function(){
					  if($(this).hasClass('ico-xiangxia2')){
						  $(this).removeClass('ico-xiangxia2').addClass('ico-shangjiantou');
						  $(This).find('dt').animate({'height':tH},300);
					  }else{
						  $(this).addClass('ico-xiangxia2').removeClass('ico-shangjiantou');
						  $(This).find('dt').animate({'height':dH},300);
					  };
				  });
				});
    		}
    	});
	}
    $.jqPaginator('#pagination2', {
        totalPages: 5,
        visiblePages: 5,
        currentPage: 1,
        prev: '<a href="javascript:;" class="prev">上一页</a>',
        next: '<a href="javascript:;" class="next">下一页</a>',
        page: '<a href="javascript:;" class="page">{{page}}</a>',
        onPageChange: function (num, type) {
        	refreshProducts(num);
        }
    });
    function addRow(row){
    	var li = '<dl class="my_message_list"><dt><i class="ico ico-xiangxia2 more"></i>';
    		if(row.readed == 1){
    			li = li+'<div class="txt"style="cursor:pointer;">'+row.content+' </div>';
    		}else{
    			li = li+'<div class="txt" id="msgId_'+row.id+'" style="cursor:pointer;color:#bd9548;" onclick="javascript:readMsg('+row.id+')">'+row.content+'</div>';
    		}
			li = li+'</dt>';
			li = li+'<dd>'+(row.createTime).substring(0,10)+'</dd></dl>';
        $("#rows").append(li);
    }
</script>
<!-- main e --> 
<!-- 返回顶部 s --> 
<a href="javascript:void(0);" id="back_top"><i class="ico ico-shangjiantou"></i><span>返回顶部</span></a> 
<!-- 返回顶部 e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>