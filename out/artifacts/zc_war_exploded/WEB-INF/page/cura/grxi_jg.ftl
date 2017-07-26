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
      <li><a href="jbxi_jg.html">基本信息</a></li>
      <li><a href="grxi_jg.html" class="active">个人信息</a></li>
    </ul>
  </div>
  <!-- queryPage_Left e -->
  <!-- queryPage_Right s -->
  <div class="queryPage_Right">
    <p class="search_tab_title">
    <a href="${base}/cura/cust/account.htm">账户与安全</a>
    <a href="#" class="active">客户资料</a><a href="#">风险测评</a>
    <a href="${base}/cura/cust/survey.htm">问卷调查</a>
    </p>
    <!-- info_public s -->
    <div class="info_public">
    <form action="" id="jgSubmitForm">
      <p class="info_ty_title"><span>个人信息</span></p>
      <ul class="UL">
      	<li><label><i></i>所属行业：</label>
      		<select name="industryId" class="select">
      			<option value="行业1">行业1</option>
      			<option value="行业2">行业2</option>
      		</select>
      	</li>
      	<li>
      		<label style="width: 170px;"><i></i>可用于投资的金融资产：</label>
      		<span class="placeholder_wrap">
      			<select style="width: 205px;" class="ipt1" name="canInvestAmount" id="canInvestAmount">
			        	<option value="">未知</option>
			        	[@dict name="yearIncome" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
      		</span>
      	</li>
      	<li>
      		<label><i></i>委托联系人姓名：</label>
      		<span class="placeholder_wrap">
      			<input type="text" class="ipt1" name="truster" placeholder="请输入委托联系人姓名">
      		</span>
      	</li>
      	<li>
      		<label style="width: 170px;"><i></i>手机号码：</label>
      		<span class="placeholder_wrap">
      			<input style="width: 205px;" type="text" class="ipt1" placeholder="请输入手机号码" name="trusterPhone">
      		</span>
      	</li>
      </ul>
      <button type="button" class="submit" id="jgSubmitBtn">保存</button>
      </form>
    </div>
    <!-- info_public e -->
  </div>
  <script type="text/javascript">
	$('.select').select2({
		  theme: "classic",
		  minimumResultsForSearch: Infinity
	});
	$("#jgSubmitBtn").on("click",function(){
		var params = {};
  		$.each($("#jgSubmitForm").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        });
        submitForm('${base}/cura/cust/info2.htm',params,function(data){
        	alertNotification("提示","更新完成","确定",function(){
        		[#if productId != null]
        			window.document.location = '${base}/cura/fund/detail.htm?id=${productId}';
        		[/#if]
        		[#if productId == null]
        			window.document.location = '${base}/cura/fund/product.htm';
        		[/#if]
        	});
        });
		//是否能过下一步
	});
	</script> 
  <!-- queryPage_Right e -->
</div>
<!-- main e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>