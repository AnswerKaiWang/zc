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
      <li><a href="${base}/cura/cust/me.htm" class="active">我的投资</a></li>
      <li><a href="${base}/cura/cust/base.htm">我的账户</a></li>
      <li><a href="${base}/cura/cust/message.htm">我的消息</a></li>
    </ul>
  </div>
  <!-- queryPage_Left e -->
  <!-- queryPage_Right s -->
  <div class="queryPage_Right">
    <p class="search_tab_title">
	<a href="${base}/cura/cust/invested.htm">已投产品查询</a>
	<a href="${base}/cura/cust/share.htm">分红查询</a>
	<a href="javascript:void(0);" class="active">预约查询</a></p>
    <dl class="choice_list">
      <dt>产品类别：</dt>
      <dd id="fundType">
        <a href="javascript:void(0);" did='0' onclick="javascript:choiceSearchProduct(this,refreshProducts);" class="active">全部</a>
        [@dict name="fundType" ]
    	[#list dictList as st]
    		<a href="javascript:void(0);" did='${st.id}' onclick="javascript:choiceSearchProduct(this,refreshProducts);">${st.name}</a>
    	[/#list]
    	[/@dict]
      </dd>
    </dl>
    <dl class="choice_list">
      <dt>法律形式：</dt>
      <dd id="fundLawWay">
        <a href="javascript:void(0);" did='0' onclick="javascript:choiceSearchProduct(this,refreshProducts);" class="active">全部</a>
        [@dict name="fundLawWay" ]
    	[#list dictList as st]
    		<a href="javascript:void(0);" did='${st.id}' onclick="javascript:choiceSearchProduct(this,refreshProducts);">${st.name}</a>
    	[/#list]
    	[/@dict]
      </dd>
    </dl>
    <dl class="choice_list">
      <dt>产品期限：</dt>
      <dd id="fundDeadline">
        <a href="javascript:void(0);" did='0' onclick="javascript:choiceSearchProduct(this,refreshProducts);" class="active">全部</a>
        [@dict name="fundDuration" ]
    	[#list dictList as st]
    		<a href="javascript:void(0);" did='${st.id}' onclick="javascript:choiceSearchProduct(this,refreshProducts);">${st.name}</a>
    	[/#list]
    	[/@dict]
      </dd>
    </dl>
    <div class="ResultBox">
    <table border="0" cellspacing="0" cellpadding="0" class="table_3" id="rows">
      	<tr>
	        <th width="230" align="left">产品名称</th>
	        <th width="90" align="center">专属财富顾问</th>
	        <th width="110" align="center">客户姓名</th>
	        <th width="110" align="center">基金管理人</th>
	        <th width="110" align="center">详情</th>
        </tr>
    </table>
    </div>
    <div class="page_2" id="pagination2"></div>    
  </div>
  <!-- queryPage_Right e -->
</div>
<script type="text/javascript">
	$(function(){
		//refreshProducts(1);
	});
	function refreshProducts(num){
		$("#rows tr:not(:first)").remove();
		var ft = $("dd[id='fundType'] a[class='active']").attr("did");
		var fd = $("dd[id='fundDeadline'] a[class='active']").attr("did");
		var fw = $("dd[id='fundLawWay'] a[class='active']").attr("did");
    	asyncPost("${base}/cura/appointment/list.htm",
    	{
    		pageSize:5,
    		start : num,
    		lawWay: fw,
    		type: ft,
    		duration: fd  
    	},
    	function(data){
    		if(!!data){
    			//重置页面
    			for(var ind in data){
    				addRow(data[ind]);
    			}
    		}
    	});
	}
    $.jqPaginator('#pagination2', {
        totalPages: 10,
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
    	var li = '<tr>'
        +'<td width="230" align="left"><a href="javascript:void(0);">'+row.fundName+'</a></td>'
        +'<td width="90" align="center">'+(row.consultName || "")+'</td>'
        +'<td width="110" align="center">'+(row.custName || "")+'</td>'
        +'<td width="110" align="center">'+(row.companyName || "")+'</td>'
        +'<td width="110" align="center"><a href="javascript:toPD('+row.fundId+');">详情</a></td>'
        +'</tr>'
        $("#rows").append(li);
    }
    
    function toPD(id){
    	window.document.location = "${base}/cura/cust/appointment/detail.htm?id="+id;
    }
</script>
<!-- main e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>