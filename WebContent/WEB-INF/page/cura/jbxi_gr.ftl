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
      <li><a href="${base}/cura/cust/me.htm">我的投资</a></li>
      <li><a href="${base}/cura/cust/base.htm" class="active">我的账户</a></li>
      <li><a href="${base}/cura/cust/message.htm">我的消息</a></li>
    </ul>
  </div>
  <!-- queryPage_Left e -->
  <!-- queryPage_Right s -->
  <div class="queryPage_Right">
    <p class="search_tab_title"><a href="${base}/cura/cust/account.htm">账户与安全</a><a href="#" class="active">客户资料</a><a href="${base}/cura/cust/survey.htm">问卷调查</a></p>
    <!-- info_public s -->
    <div class="info_public">
    <form action="" id="personalInfoForm1">
      <p class="info_ty_title"><span>基本信息</span></p>
      <input type="hidden" name="id" id="id" value="${loginSuccessKey.userSecondId}">
      <input type="hidden" name="productId" id="productId" value="${productId}">
      <ul class="UL">
      	<li><label><i></i>客户代码：</label>${loginSuccessKey.custNo}</li>
      	<li><label><i>*</i>客户姓名：</label><span class="placeholder_wrap">
      		<input type="text" value="${loginSuccessKey.name}" name="name" class="ipt1" placeholder="请输入姓名"></span></li>
      	<li><label><i>*</i>客户姓别：</label><span class="sex_w">
      		<input type="radio" name="sex" value="1"  class="c" [#if loginSuccessKey.gender=1]checked[/#if]>&nbsp;男&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      		<input type="radio" name="sex" value="0" class="c" [#if loginSuccessKey.gender=0]checked[/#if]>&nbsp;女</span></li>
      	<li><label><i></i>手机号码：</label>${loginSuccessKey.phone}</li>
      	<li><label><i></i>固定座机：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" name="conTel" placeholder="请输入固定座机" value="${loginSuccessKey.tel}"></span></li>
      	<li><label><i></i>电子邮箱：</label><span class="placeholder_wrap">
      		${loginSuccessKey.email}</span></li>
      	<li><label><i>*</i>所在城市：</label>
      		<select  name="city" class="ipt1">
	      		<option value="">未知</option>
	        	[@dict name="city" ]
	        	[#list dictList as st]
	        		<option value="${st.id}" [#if st.id=='${loginSuccessKey.cityId}']selected=selected[/#if]>${st.name}</option>
	        	[/#list]
	        	[/@dict]
      		</select>
      	</li>
      	<li><label><i></i>邮编：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" placeholder="请输入邮编" name="conZip" value="${loginSuccessKey.zip}"></span></li>
      	<li><label><i></i>通讯地址：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" placeholder="请输入通讯地址" name="conAddr" value="${loginSuccessKey.addr}"></span></li>
      	<li><label><i></i>邀请码：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" placeholder="请输入邀请码" name="welcomeCode" value="${loginSuccessKey.welcomeCode}"></span></li>
      	<li><label><i>*</i>证件类型：</label>
      		<select name="cardType" class="ipt1" id="cardTypeId" >
      		 [@dict name="perCardType" ]
	        	[#list dictList as st]
	        		<option value="${st.id}" [#if st.id=='${loginSuccessKey.cardTypeId}']selected=selected[/#if]>${st.name}</option>
	        	[/#list]
        	 [/@dict]
      		</select>
      	</li>
      	<li><label><i></i>证件号码：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" value="${loginSuccessKey.cardNo}" id="cardNoId"
      			 placeholder="请输入证件号码" name="cardNo" value="${loginSuccessKey.cardNo}"></span></li>
      	<li><label><i></i>证件有效期：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" placeholder="请输入证件有效期" readOnly name="valiateTime" id="valiateTime" value="${loginSuccessKey.qixian}"></span></li>
      	<li><label><i></i>证件发证机关：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" placeholder="请输入证件发证机关" name="fzCompany" value="${loginSuccessKey.jiguan}"></span></li>
      	<li><label><i></i>出生日期：</label><input class="ipt1" type="text" readOnly name="birth" id="birth"
      		 [#if loginSuccessKey.birth != null]value="${(loginSuccessKey.birth)?substring(0,10)}"[/#if] ></li>
      </ul>
      <div class="yi_txt">
        <p><i class="ico ico-lamp"></i>&nbsp;请您完善以上信息，便于了解更多产品信息</p>
        <p><input type="checkbox" class="c" checked>&nbsp;我已同意授权开通<a href="javascript:void(0);" class="show_user_xieyi_2">《中城投资旗下基金管理人平台注册》</a></p>
      </div>
      <button type="button" id="personalInfoBtn1" class="submit">下一步</button>
      </form>
    </div>
    <!-- info_public e -->
  </div>
  <script type="text/javascript">
  !function(){
    	//laydate.skin('molv');
    	laydate({elem: '#valiateTime'});   
    	laydate({elem: '#birth'});      
  }();
   $(function(){
   		//身份证
   		$("#cardNoId").on("blur",function(){
   			var cti = $("#cardTypeId").val();
   			if(cti == 14){
   				if(!checkID('cardNoId',function(dd){
   					var len = dd.length;
   					if(len ==18){
   						$("#birth").val(fmtDate(dd.substring(6,14)));
   					}else{
   						$("#birth").val(fmtDate(dd.substring(6,12)));
   					}
   				})){
   					return false;
   				}
   			}
   		});
   		$('.select').select2({
			  theme: "classic",
			  minimumResultsForSearch: Infinity
		});
		$("#personalInfoBtn1").on("click",function(e){
			e.preventDefault();
			var params = {};
	  		$.each($("#personalInfoForm1").serializeArray(),function(key,value){
	        		params[value.name]=value.value;
	        });
	        submitForm('${base}/cura/cust/info1.htm',params,function(data){
	        	alertNotification("提示","是否进行下一步？","确定",function(){
	        		window.document.location = '${base}/cura/cust.htm?productId=${productId}';
	        	});
	        });
		});
   });
	</script> 
  <!-- queryPage_Right e -->
  <!-- 用户注册协议-2 s -->
  <div class="user_xieyi xieyi_2">
    <a href="javascript:void(0);" class="close_xieyi" title="关闭"><i class="ico ico-guanbi1"></i></a>
    <h3 class="title">《中城投资旗下基金管理人平台注册》</h3>
    <div class="text" id="xieyi_content_2">${sysConfig('cust_center_agreement')}</div>
  </div>
  <!-- 用户注册协议-2 e -->
  <link rel="stylesheet" href="${base}/frontCura/style/mCustomScrollbar.css">
  <script src="${base}/frontCura/js/mCustomScrollbar.concat.min.js"></script> 
  <script>
	//滚动条
	(function($){
	  $(window).on("load",function(){        
		$("#xieyi_content_2").mCustomScrollbar();        
	  });
	})(jQuery);
  </script>
</div>
<!-- main e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>