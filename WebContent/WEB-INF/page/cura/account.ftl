<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<meta name="renderer" content="webkit" />
<title>无标题文档</title>
[#include "/cura/common/js.ftl"]
</head>
<body>
[#include "/cura/common/header.ftl"]
[#include "/cura/common/caifu.ftl"]
<!-- banner s -->
<div class="banner">
  <div class="user_Box">
    <p class="bjbox"></p>
    <div class="wrap">
      <dl class="L">
        <dt><a href="###"><img src="#" alt="" width="140" height="140"></a></dt>
        <dd>
          <div class="dd_inner">
            <p>客户姓名：${name}</p>
            <p>客户等级：${loginSuccessKey.level}</p>
            <p>客户类型：${loginSuccessKey.type}</p>
            <p>客户风险评级：
            	<!-- 已过期 -->
            	[#if loginSuccessKey.expired == 1]
            		已过期
            	[/#if]
            	[#if loginSuccessKey.expired == 0]
            		[#if loginSuccessKey.riskLevelName == null]
	            		未测评
	            	[/#if]
	            	[#if loginSuccessKey.riskLevelName != null]
	            		${loginSuccessKey.riskLevelName}　${(loginSuccessKey.evaluationTime)?string('yyyy-MM-dd')}到期
	            	[/#if]
            	 [/#if]
            <a href="#" class="cxp" id="show_cppc_popup_2">[重新测评]</a><a href="#" class="cxp">[打印]</a></p>
          </div>
        </dd>
      </dl>
      <div class="R">
        <div class="r_inner">
          <p>我的在投金额：<b>${investAmount}万元</b></p>
        </div>
      </div>
    </div>
  </div>
</div>
[#include "/cura/common/evaluation.ftl"]
<!-- banner e -->
<style type="text/css">
/*本页样式*/
body{background-color: #f9f9f9;}
</style>

<!-- 密码修改 -->
<div class="sign_popup" id="resetPup">
  <p class="title">重置密码<span></span></p>
  <form action="">
    <ul>
      <li>
        <label>新 密  码：</label>
        <span class="placeholder_wrap"><input type="password" name="newPwd" id="newPwd" class="ipt1" placeholder="新密码"></span>
      </li>
      <li>
        <label>确认密码：</label>
        <span class="placeholder_wrap"><input type="password" name="ackPwd" id="ackPwd" class="ipt1" placeholder="确认密码"></span>
      </li>
      <li>
        <input type="button" class="submit" id="resetPwdBtn" value="确定">
      </li>
    </ul>
  </form>
</div>
<!-- 手机重新绑定 -->
<div class="sign_popup" id="resetPhone">
  <p class="title">重新绑定手机<span></span></p>
  <form action="" id="resetPhoneForm">
    <ul>
      <li>
        <label>手机号：</label>
        <span class="placeholder_wrap"><input type="text" name="phone" id="resetPhoneId" class="ipt1" placeholder="手机号"></span>
      </li>
      <li>
        <label>验证码：</label>
        <span class="placeholder_wrap"><input type="text" style="width:160px;" name="smsCode" id="smsCodeId" class="ipt1" placeholder="请输入电话号码"></span>
        <input type="button" id="sendSmsBtn" class="submit" style="width:50px" value="获取">
      </li>
      <li>
        <input type="button" class="submit" id="resetSubmitBtn" value="确定">
      </li>
    </ul>
  </form>
</div>
<!-- 邮箱重新绑定 -->
<div class="sign_popup" id="resetEmail">
  <p class="title">重新绑定邮箱<span></span></p>
  <form action="">
    <ul>
      <li>
        <label>邮   箱：</label>
        <span class="placeholder_wrap"><input type="text" name="email" id="emailId" class="ipt1" placeholder="邮箱"></span>
      </li>
      <li>
        <label>验证码：</label>
        <span class="placeholder_wrap"><input type="text" style="width:160px;" id="emailCodeId"  name="code" class="ipt1" placeholder="验证码"></span>
        <input type="button" id="sendEmailBtn" class="submit" style="width:50px" value="获取">
      </li>
      <li>
        <input type="button" class="submit" id="ackEmailBtn" value="确定">
      </li>
    </ul>
  </form>
</div>
<!-- main s -->
<div class="main">
  <!-- queryPage_Left s -->
  <div class="queryPage_Left">
    <ul class="Menu">
      <li><a href="${base}/cura/cust/me.htm">我的投资</a></li>
      <li><a href="${base}/cura/cust/base.htm" class="active">我的账户</a></li>
      <li><a href="${base}/cura/cust/message.htm" >我的消息</a></li>
    </ul>
  </div>
  <!-- queryPage_Left e -->
  <!-- queryPage_Right s -->
  <div class="queryPage_Right">
    <p class="search_tab_title"><a href="${base}/cura/cust/account.htm" class="active">账户与安全</a><a href="${base}/cura/cust/base.htm">客户资料</a><a href="${base}/cura/cust/survey.htm">问卷调查</a></p>
   <!--修改信息-->  
   <div class="xiugai">  
      <div>登录密码<span>保障账户安全，建议您定期更换密码</span><a href="javascript:void(0);" onclick="javascript:resetPwd();">修改><div class="clearfix2"></div></a></div>
      <div>手机号码<span>保障账户与资金安全，是您在中城投资的重要身份凭证</span><a href="javascript:void(0);" onclick="javascript:resetPhone();">修改><div class="clearfix2"></div></a></div>
      <!--
      <div>实名认证<span>保障账户安全，只有通过实名认证，才能投资</span><a href="javascript:void(0);" onclick="javascript:realName();">修改><div class="clearfix2"></div></a></div>
      -->
      <div>电子邮箱<span>邮件接收账户通知，邮件接收账户通知</span><a href="javascript:void(0);" onclick="javascript:resetEmail();">修改><div class="clearfix2"></div></a></div>
   </div>
   <!--修改信息--> 
  </div>
  <script type="text/javascript">
	$('.select').select2({
		  theme: "classic",
		  minimumResultsForSearch: Infinity
	});
  var btnMsg = "获取";
  var btnTime = 120;
  var canSend = true;
  
  $("#resetPwdBtn").on("click",function(){
  		var nw = $("#newPwd").val();
  		if(!nw){
  			alertNotification("提示","新密码必填","确定");
  			return false;
  		}
  		var aw = $("#ackPwd").val();
  		if(!aw){
  			alertNotification("提示","确认密码必填","确定");
  			return false;
  		}
  		$.ajax({
  			url: '${base}/cura/cust/account/resetPwd.htm',
  			type:"GET",
  			dataType:"json",
  			data: {newPwd: nw, ackPwd: aw},
  			success:function(data){
  				if(!!data){
  					if(data.code == '00'){
  						alertNotification("提示","修改密码成功","确定",function(){
  							layer.closeAll();
  						});
  					}else{
  						alertNotification("提示",data.message,"确定");
  					}
  				}
  			}
  		});
  });
  //重置手机
  $("#resetSubmitBtn").on("click",function(){
  		var phone = $("#resetPhoneId").val();
  		if(!phone){
  			alertNotification("提示","手机号必填","确定");
  			return false;
  		}
  		var smsCode = $("#smsCodeId").val();
  		if(!smsCode){
  			alertNotification("提示","验证码必填","确定");
  			return false;
  		}
  		$.ajax({
  			url: '${base}/cura/cust/account/resetPhone.htm',
  			type:"GET",
  			dataType:"json",
  			data: {phone: phone,smsCode: smsCode},
  			success:function(data){
  				if(!!data){
  					if(data.code == '00'){
  						alertNotification("提示","修改手机成功","确定",function(){
  							layer.closeAll();
  							clearInterval(clock);
							btnTime = 120;
							$("#sendSmsBtn").val(btnMsg);
							canSend = true;
							$("#resetPhoneForm").reset();
  						});
  					}else{
  						alertNotification("提示",data.message,"确定");
  					}
  				}
  			}
  		});
  });
  //邮箱认证
  $("#ackEmailBtn").on("click",function(){
  		var email = $("#emailId").val();
  		if(!email){
  			alertNotification("提示","邮箱必填","确定");
  			return false;
  		}
  		var smsCode = $("#emailCodeId").val();
  		if(!smsCode){
  			alertNotification("提示","邮箱验证码必填","确定");
  			return false;
  		}
  		$.ajax({
  			url: '${base}/cura/cust/account/resetEmail.htm',
  			type:"GET",
  			dataType:"json",
  			data: {email: email,code:smsCode},
  			success:function(data){
  				if(!!data){
  					if(data.code == '00'){
  						alertNotification("提示","修改邮箱成功","确定",function(){
  							layer.closeAll();
							canSend = true;
  						});
  					}else{
  						alertNotification("提示",data.message,"确定");
  					}
  				}
  			}
  		});
  });
  $("#sendEmailBtn").on("click",function(e){
  		var email = $("#emailId").val();
  		if(!email){
  			alertNotification("提示","邮箱必填","确定");
  			return false;
  		}
  		$.ajax({
  			url: '${base}/cura/cust/account/sendEmail.htm',
  			type:"GET",
  			dataType:"json",
  			data: { email: email},
  			success:function(data){
  				if(!!data){
  					if(data.code == '00'){
  						alertNotification("提示","验证码发送成功","确定");
  					}else{
  						alertNotification("提示",data.message,"确定");
  					}
  				}
  			}
  		});
  });
  $("#sendSmsBtn").on("click",function(e){
  		if(!canSend){return false;}
  		var phone = $("#resetPhoneId").val();
  		if(!phone){
  			alertNotification("提示","手机号必填","确定");
  			return false;
  		}
  		canSend = false;
  		$.ajax({
  			url: '${base}/cura/cust/account/send.htm',
  			type:"GET",
  			dataType:"json",
  			data: {phone: phone},
  			success:function(data){
  				if(!!data){
  					if(data.code == '00'){
  					
  					}else{
  						alertNotification("提示",data.message,"确定");
  					}
  				}
  			}
  		});
  		clock = setInterval(function(){
			if(btnTime >0){
				$("#sendSmsBtn").val(btnTime+"秒");
				btnTime = btnTime-1;
			}else{
				clearInterval(clock);
				btnTime = 120;
				$("#sendSmsBtn").val(btnMsg);
				canSend = true;
			}
		},1000);
  });
	function resetPwd(){
		layer.open({
		  type: 1,
		  title: false,
		  closeBtn:2,
		  area : ['auto' , 'auto'],
		  //offset: ['20px'],
		  shadeClose :true,
		  fix: false,
		  content: $('#resetPup')
		});
	}
	function resetPhone(){
		layer.open({
		  type: 1,
		  title: false,
		  closeBtn:2,
		  area : ['auto' , 'auto'],
		 // offset: ['20px'],
		  shadeClose :true,
		  fix: false,
		  content: $('#resetPhone')
		});
	}
	function realName(){
		layer.open({
		  type: 1,
		  title: false,
		  closeBtn:2,
		  area : ['auto' , 'auto'],
		  //offset: ['20px'],
		  shadeClose :true,
		  fix: false,
		  content: $('#realName')
		});
	}
	function resetEmail(){
		layer.open({
		  type: 1,
		  title: false,
		  closeBtn:2,
		  area : ['auto' , 'auto'],
		 // offset: ['20px'],
		  shadeClose :true,
		  fix: false,
		  content: $('#resetEmail')
		});
	}
	
	</script> 
  <!-- queryPage_Right e -->
</div>
<!-- main e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>