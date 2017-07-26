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
[#include "/cura/common/userInfo.ftl"]
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
      <li><a href="${base}/cura/cust/base.htm" class="active">我的账户</a></li>
      <li><a href="${base}/cura/cust/message.htm">我的消息</a></li>
    </ul>
  </div>
  <!-- queryPage_Left e -->
  <!-- queryPage_Right s -->
  <div class="queryPage_Right">
    <p class="search_tab_title"><a href="${base}/cura/cust/account.htm">账户与安全</a>
    <a href="javascript:void(0);" class="active">客户资料</a>
    <a href="${base}/cura/cust/survey.htm">问卷调查</a></p>
    <!-- info_public s -->
    <div class="info_public">
    <form action="" id="personalInfoForm2">
      <p class="info_ty_title"><span>个人信息</span></p>
      <ul class="UL">
      	<li><label><i></i>职业：</label><select name="jobId" class="ipt1">
      		<option value="">未知</option>
        	[@dict name="zhiye" ]
        	[#list dictList as st]
        		<option value="${st.id}"[#if st.id=='${loginSuccessKey.jobId}']selected=selected[/#if]>${st.name}</option>
        	[/#list]
        	[/@dict]
      	</select></li>
      	<li><label><i></i>所属行业：</label><select name="industryId" class="ipt1">
      		<option value="">未知</option>
        	[@dict name="suoshuhangye" ]
        	[#list dictList as st]
        		<option value="${st.id}"[#if st.id=='${loginSuccessKey.industryId}']selected=selected[/#if]>${st.name}</option>
        	[/#list]
        	[/@dict]
      	</select></li>
      	<li style="width: 100%;"><label><i></i>工作单位：</label><span class="placeholder_wrap">
      		<input style="width: 677px;" type="text" class="ipt1" name="company" placeholder="请输入工作单位" value="${loginSuccessKey.company}"></span></li>
      	<li><label><i></i>职务：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" name="duty" placeholder="请输入职务" value="${loginSuccessKey.duty}">
      	</span></li>
      	<li><label><i></i>学历：</label>
      		<select name="education" class="ipt1">
      		<option value="">未知</option>
        	[@dict name="xueli" ]
        	[#list dictList as st]
        		<option value="${st.id}"[#if st.id=='${loginSuccessKey.education}']selected=selected[/#if]>${st.name}</option>
        	[/#list]
        	[/@dict]
      	</select></li>
      	<li><label><i></i>国籍：</label><span class="placeholder_wrap">
      		<select name="country" class="ipt1">
      		<option value="">未知</option>
			        	[@dict name="country" ]
                    	[#list dictList as st]
                    		<option value="${st.id}"[#if st.id=='${loginSuccessKey.countryId}']selected=selected[/#if]>${st.name}</option>
                    	[/#list]
                    	[/@dict]
             </select>
      	</span></li>
      	<li><label><i></i>年收入：</label>
      		<select name="income" class="ipt1">
      			<option value="">未知</option>
	        	[@dict name="yearIncome" ]
            	[#list dictList as st]
            		<option value="${st.id}"[#if st.id=='${loginSuccessKey.income}']selected=selected[/#if]>${st.name}</option>
            	[/#list]
            	[/@dict]
      		</select>
      	</li>
      	<li><label><i></i>委托联系人姓名：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" name="truster" placeholder="请输入委托联系人姓名" value="${loginSuccessKey.trusterName}"></span></li>
        <li><label style="width: 170px;"><i></i>可用于投资的金融资产：</label>
      			<select name="canInvestAmount" class="ipt1" style="width:150px;">
	        	<option value="">未知</option>
	        	[@dict name="yearIncome" ]
            	[#list dictList as st]
            		<option value="${st.id}"[#if st.id=='${loginSuccessKey.canInvestAmount}']selected=selected[/#if]>${st.name}</option>
            	[/#list]
            	[/@dict]
		 	</select>
         </li>
      	<li><label><i></i>委托人手机号码：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" name="trusterPhone" id="trusterPhone" onblur="javascript:checkMobile('trusterPhone');" placeholder="请输入手机号码" value="${loginSuccessKey.trusterPhone}"></span></li>
      </ul>
      <button type="button" id="personalInfoBtn2" class="submit">保存</button>
      </form>
    </div>
    <!-- info_public e -->
  </div>
  <script type="text/javascript">
	$('.select').select2({
		  theme: "classic",
		  minimumResultsForSearch: Infinity
	});
	
	$("#personalInfoBtn2").on("click",function(){
		var params = {};
  		$.each($("#personalInfoForm2").serializeArray(),function(key,value){
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