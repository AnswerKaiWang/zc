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
<!-- login_wrap s -->
<div class="login_wrap">
  <div class="wrap">
    <div class="login_box">
      <div class="L"></div>
      <div class="R">
        <p class="title"><span>欢迎登录</span><a href="${base}/cura/reg.htm">没有账号？立即注册</a></p>
        <p class="login_tab_title"><a href="javascript:void(0);" class="active">个人客户登录<i></i></a><a href="javascript:void(0);">机构客户登录<i></i></a></p>
        <form action="" id="loginGForm">
        	<input type="hidden"name="type" id="type" value="geren">
          <div class="showform" style="display: block;">
            <ul>
              <li><input type="text" class="ipt1" name="userName" id="userName" placeholder="请输入手机号/证件号"><i class="ico ico-yonghu"></i></li>
              <li><input type="password" class="ipt1" name="password" id="password" placeholder="请输入密码"><i class="ico ico-lock-0-2"></i></li>
              <li class="Forget_li"><span class="fl"><input type="checkbox" name="rememberMe" id="rememberMe" class="checkbox">记住用户名</span>
              	<a href="javascript:void(0);" class="fr">忘记密码？</a></li>
              <li><button type="button" class="submit" id="loginGBtn">登陆</button></li>
            </ul>
          </div>
        </form>
        <form action="" id="loginCForm">
        	<input type="hidden"name="type" id="type" value="qiye">
          <div class="showform">
            <ul>
              <li><input type="text" class="ipt1" name="userName" id="userName" placeholder="请输入机构证件号码"><i class="ico ico-yonghu"></i></li>
              <li><input type="password" class="ipt1" name="password" id="password" placeholder="请输入密码"><i class="ico ico-lock-0-2"></i></li>
              <li class="Forget_li"><span class="fl"><input type="checkbox" name="rememberMe" id="rememberMe" class="checkbox">记住用户名</span><a href="#" class="fr">忘记密码？</a></li>
              <li><button type="button" class="submit" id="loginCBtn">登陆</button></li>
            </ul>
          </div>
        </form>
        <dl>
          <dt>最新公告</dt>
          <dd>
          	[#list notices as n]
           	 <p><a href="${n.url}" target="_blank">${n.title}</a></p>
            [/#list]
            </dd>
        </dl>
      </div>
    </div>
  </div>
</div>
<!-- login_wrap e -->
<script type="text/javascript" src="${base}/frontCura/js/placeholder.min.js"></script> 
<script type="text/javascript">
$(document).ready(function(){
  $('input[placeholder], textarea[placeholder]').each(function(){
    $(this).is('input')?$(this).iePlaceholder():$(this).iePlaceholder({onInput: false});
  });
  $("#loginCBtn").on("click",function(e){//企业登录
  	e.preventDefault();
	var un = $("#loginCForm #userName").val();
	if(!un){
		alertNotification("提示","请输入用户名","确定");
		return false;
	}
	var pwd = $("#loginCForm #password").val();
	if(!pwd){
		alertNotification("提示","请输入密码","确定");
		return false;
	}
	var params = {};
	$.each($("#loginCForm").serializeArray(),function(key,value){
    		params[value.name]=value.value;
    });
	$.ajax({
		url: '${base}/cura/loginCheck.htm',
		type:"POST",
		dataType:"json",
		data: params,
		success:function(data){
			if(!!data){
				if(data.code == '00'){
					toProduct('${base}');//基金产品
				}else{
					alertNotification("提示",data.message,"确定");
					return false;					
				}
			}
		}
	});
  });
  $("#loginGBtn").on("click",function(e){//个人登录
  	e.preventDefault();
	var un = $("#loginGForm #userName").val();
	if(!un){
		alertNotification("提示","请输入用户名","确定");
		return false;
	}
	var pwd = $("#loginGForm #password").val();
	if(!pwd){
		alertNotification("提示","请输入密码","确定");
		return false;
	}
	var params = {};
	$.each($("#loginGForm").serializeArray(),function(key,value){
    		params[value.name]=value.value;
    });
	$.ajax({
		url: '${base}/cura/loginCheck.htm',
		type:"POST",
		dataType:"json",
		data: params,
		success:function(data){
			if(!!data){
				if(data['code'] === '00'){
					window.document.location = "${base}/cura/fund/product.htm";
				}else{
					alertNotification("提示",data.message,"确定");
					return false;
				}
			}
		}
	});
  });  	
});
</script>
[#include "/cura/common/footer.ftl"]
</body>
</html>