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
<style type="text/css">
/*本页样式*/
body{background-color: #f9f9f9;}
</style>
<!-- register_wrap s -->
<div class="register_wrap">
  <div class="step_top_zc step_2"> <a href="${base}/cura/login.htm" class="a1">已有账号？请直接登录</a>
    <ul>
      <li class="L"><span>1</span></li>
      <li class="M"><span>2</span></li>
      <li class="R"><span>3</span></li>
    </ul>
    <ol>
      <li class="L">合格投资者确认</li>
      <li class="M">手机验证</li>
      <li class="R">完善账户信息，注册完成</li>
    </ol>
  </div>
  <div class="register_box register_box_2">
    <p class="welcome_registration">欢迎注册</p>
    <div class="L"><img src="${base}${sysConfig('reg2_left_pic')}" width="375" height="495"  alt=""></div>
    <div class="R">
      <form action="" id="regTwoForm">
        <div class="fm_inner">
          <h3><em>*</em>手机号码</h3>
          <p><input type="text" class="ipt1" name="phone" id="regPhone" onblur="javascript:checkMobile('regPhone');" placeholder="请输入本人手机号码"></p>
          <h3><em>*</em>登录密码</h3>
          <p><input type="password" name="password" class="ipt1" placeholder="请输入新登录密码"></p>
          <h3><em>*</em>确认登录密码</h3>
          <p><input type="password" name="ackPwd" class="ipt1" placeholder="请再次输入密码"></p>
          <h3><em>*</em>请输入图文验证码</h3>
          <p><input type="text" class="ipt1 yzm_img" name="captcha" placeholder="请输入图文验证码"><a href="#" class="yzma">
          	<img id="captcha" src="${base}/cura/reg/captach.htm" height="37" width="112" alt=""></a>
          	</p><h3><em>*</em>请输入短信验证码</h3>
          <p><input type="text" class="ipt1 yzm" name="smsCode" placeholder="请输入图文验证码"><a href="javascript:void(0);" class="yzma_2" id="sendSmsBtn">发送短信获取验证</a></p>
          <h4><input type="checkbox" id="ackRead" name="ackRead" checked>我已阅读并同意<a href="javascript:void(0);" class="show_user_xieyi_1">《用户服务协议》</a></h4>
          <h4><input type="checkbox" id="ackAgree" name="ackAgree" checked>我已同意授权开通<a href="javascript:void(0);" class="show_user_xieyi_2">《中城投资旗下基金管理人平台注册》</a></h4>
          <p><button type="button" class="submit" id="regTwoBtn">下一步</button></p>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- register_wrap e --> 
<script type="text/javascript" src="${base}/frontCura/js/placeholder.min.js"></script>
<script type="text/javascript">
//placeholder
$(document).ready(function(){
  $('input[placeholder], textarea[placeholder]').each(function(){
    $(this).is('input')?$(this).iePlaceholder():$(this).iePlaceholder({onInput: false});
  });
  
  //验证码
  $(".yzma").on("click",function(e){
  	 //e.preventDefault();
  	 //$("#captcha").remove();
  	 $(".yzma").html("").html('<img id="captcha" src="${base}/cura/reg/captach.htm?rnd='+(new Date()).getTime()+'" height="37" width="112" alt="">');
  });
  var btnMsg = "发送短信获取验证";
  var btnTime = 120;
 var clock;
 var canSend = true;
  $("#sendSmsBtn").on("click",function(e){
  		if(!canSend){return false;}
  		var phone = $("#regPhone").val();
  		if(!phone){
  			alertNotification("提示","手机号必填","确定");
  			return false;
  		}
  		canSend = false;
  		$.ajax({
  			url: '${base}/cura/reg/sendMsg.htm',
  			type:"POST",
  			dataType:"json",
  			data: {phone: phone},
  			success:function(data){
  				if(!!data){
  					if(data.code == '00'){
  						//alertNotification("提示","验证码发送成功!","确定");
  					}else{
  						alertNotification("提示",data.message,"确定");
  					}
  				}
  			}
  		});
  		clock = setInterval(function(){
			if(btnTime >0){
				$("#sendSmsBtn").html(btnTime+"秒");
				btnTime = btnTime-1;
			}else{
				clearInterval(clock);
				btnTime = 120;
				$("#sendSmsBtn").html(btnMsg);
				canSend = true;
			}
		},1000);
  });
  
  $("#regTwoBtn").on("click",function(){
  		var params = {};
  		$.each($("#regTwoForm").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        });
  		$.ajax({
  			url: '${base}/cura/reg/checkTwo.htm',
  			type:"POST",
  			dataType:"json",
  			data: params,
  			success:function(data){
  				if(!!data){
  					if(data.code == '00'){
  						window.document.location ='${base}/cura/reg/three.htm';
  					}else{
  						alertNotification("提示",data.message,"确定");
  					}
  				}
  			}
  		});
  });
  
});
</script> 
<!-- 用户注册协议-1 s -->
<div class="user_xieyi xieyi_1">
  <a href="javascript:void(0);" class="close_xieyi" title="关闭"><i class="ico ico-guanbi1"></i></a>
  <h3 class="title">用户服务协议</h3>
  <div class="text" id="xieyi_content_1">${sysConfig('reg2_agreement')}</div>
</div>
<!-- 用户注册协议-1 e -->
<!-- 用户注册协议-2 s -->
<div class="user_xieyi xieyi_2">
  <a href="javascript:void(0);" class="close_xieyi" title="关闭"><i class="ico ico-guanbi1"></i></a>
  <h3 class="title">《中城投资旗下基金管理人平台注册》</h3>
  <div class="text" id="xieyi_content_2">${sysConfig('reg2_agreement2')}</div>
</div>
<!-- 用户注册协议-2 e -->
<link rel="stylesheet" href="${base}/frontCura/style/mCustomScrollbar.css">
<script src="${base}/frontCura/js/mCustomScrollbar.concat.min.js"></script> 
<script>
    (function($){
      $(window).on("load",function(){        
        $("#xieyi_content_1").mCustomScrollbar();
        $("#xieyi_content_2").mCustomScrollbar();        
      });
    })(jQuery);
</script>
[#include "/cura/common/footer.ftl"]

</body>
</html>