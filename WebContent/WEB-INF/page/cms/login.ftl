<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>中城投资</title>

<style type="text/css">
*{
	margin: 0;
	padding: 0;
}
body{
	font-family: "微软雅黑";
	font-size: 14px;
	background: url(${base}/front/images/56a46b7590f5672af5b8.jpg) fixed center center;
}
.logo_box{
	width: 280px;
	height: 490px;
	padding: 35px;
	color:rgb(22,50,113);
	position: absolute;
	left: 50%;
	top:100px;
	margin-left: -175px;
}
.logo_box h3{
	text-align: center;
	height: 20px;
	font: 20px "microsoft yahei",Helvetica,Tahoma,Arial,"Microsoft jhengHei",sans-serif;
	color:rgb(22,50,113);
	height: 20px;
	line-height: 20px;
	padding:0 0 35px 0;
}
.forms{
	width: 280px;
	height: 485px;
}
.logon_inof{
	width: 100%;
	min-height: 450px;
	padding-top: 35px;
	position: relative;
}		
.input_outer{
	height: 46px;
	padding: 0 5px;
	margin-bottom: 20px;
	border-radius: 50px;
	position: relative;
	border: rgba(22,50,113,0.2) 2px solid !important;
}
.u_user{
	width: 25px;
	height: 25px;
	background: url(${base}/front/images/login_ico.png);
	background-position:  -125px 0;
	position: absolute;
	margin: 12px 13px;
}
.us_uer{
	width: 25px;
	height: 25px;
	background-image: url(${base}/front/images/login_ico.png);
	background-position: -125px -34px;
	position: absolute;
	margin: 12px 13px;
}
.l-login{
	position: absolute;
	z-index: 1;
	left: 55px;
	top: 0;
	height: 46px;
	font: 14px "microsoft yahei",Helvetica,Tahoma,Arial,"Microsoft jhengHei";
	line-height: 46px;
}
label{
	color: rgb(22,50,113);
	display: block;
}
.text{
	width: 220px;
	height: 46px;
	outline: none;
	display: inline-block;
	font: 14px "microsoft yahei",Helvetica,Tahoma,Arial,"Microsoft jhengHei";
	margin-left: 50px;
	border: none;
	background: none;
	line-height: 46px;
}
/*///*/
.mb2{
	margin-bottom: 20px
}
.mb2 a{
	text-decoration: none;
	outline: none;
}
.submit {
	padding: 15px;
	margin-top: 20px;
	display: block;
}
.act-but{
	height: 20px;
	line-height: 20px;
	text-align: center;
	font-size: 20px;
	border-radius: 50px;
	background: #0096e6;
}
/*////*/
.check{
	width: 280px;
	height: 22px;
}
.clearfix::before{
	content: "";
	display: table;
}
.clearfix::after{
	display: block;
	clear: both;
	content: "";
	visibility: hidden;
	height: 0;
}
.login-rm{
	float: left;
}
.login-fgetpwd {
	float: right;
}
.check{
	width: 18px;
	height: 18px;
	background: #fff;
	border: 1px solid #e5e6e7;
	margin: 0 5px 0 0;
	border-radius: 2px;
}
.check-ok{
	background-position: -128px -70px;
	width: 18px;
	height: 18px;
	display: inline-block;
	border: 1px solid #e5e6e7;
	margin: 0 5px 0 0;
	border-radius: 2px;
	vertical-align: middle
}
.checkbox{
	vertical-align: middle;
	margin: 0 5px 0 0;
}

/*=====*/
/*其他登录口*/
.logins{
width: 280px;
height: 27px;
line-height: 27px;
float:left;
padding-bottom: 30px;
}
.qq{
	width: 27px;
	height: 27px;
	float: left;
	display: inline-block;
	text-align: center;
	margin-left: 5px;
	margin-right: 18px;
}
.wx{
	width: 27px;
	height: 27px;
	text-align: center;
	line-height: 27px;
	display: inline-block;
	margin: 5px 18px auto 5px;
}
.wx img{
	width: 16px;
	height: 16px;
	float: left;
	line-height: 27px;
	text-align: center;
}
/*////*/
.sas{
	width: 280px;
	height: 18px;
	float: left;
	color:rgb(22,50,113);
	text-align: center;
	font-size: 16px;
	line-height: 16px;
	margin-bottom: 50px;
}
.sas a{
	width: 280px;
	height: 18px;
	color:rgb(22,50,113);
	text-align: center;
	line-height: 18px;
	text-decoration: none;
}
</style>
</head>
<body style="overflow:hidden;">

<script src="${base}/static/common/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<div style="width:1000px;margin:auto;">
		<br />
       <img alt="image" src="${base}/front/images/logo.png" style="width:153px;"/>
</div>
<div class="logo_box">
	<div style="margin-top:15px;margin-bottom:15px;width: 280px;text-align:center;color:rgb(22,50,113);">
                  <h3> 中城测试系统</h3>
                  <!--中城投资客户和产品管理系统-->
    </div>
	<div style="color:red;margin:auto; text-align:center;" id="info"></div>
	<form action="#" name="f" method="post" id="loginForm">
		<div class="input_outer">
			<span class="u_user"></span>
			<input name="username" onkeypress="if(event.keyCode ==13){login()}" class="text" onFocus=" if(this.value=='输入用户名') this.value=''" onBlur="if(this.value=='') this.value='输入用户名'" value="输入用户名" style="color:rgb(22,50,113)!important" type="text">
		</div>
		<div class="input_outer">
			<span class="us_uer"></span>
			<label class="l-login login_password" style="color:rgb(22,50,113)!important;display: block;" >输入密码</label>
			<input name="password" onkeypress="if(event.keyCode ==13){login()}" class="text" style="color:rgb(22,50,113)!important; position:absolute; z-index:100;" onFocus="$('.login_password').hide()" onBlur="if(this.value=='') $('.login_password').show()" value="" type="password">
		</div>
		<div class="mb2"><a class="act-but submit" href="javascript:;" style="color: #FFFFFF" onclick="login()">登录</a></div>
	</form>

	<div class="sas">
		<a href="#" style="color:rgb(22,50,113)!important;"> © 2016 中城投资 版权所有</a>
	</div>
</div>
	<script>
		function login(){
			$.ajax({
             type : "post",
             url : "${base}/admin/login/up.htm",
             dataType : "json",
             data:$("#loginForm").serializeArray(),
             success:function(data){
				if(data.info=="00"){
					window.location.href="${base}/admin/main.htm";
				}else{
					$("#info").html(data.info);
				}
			 },error:function(){
				$("#info").html("系统异常,请重试");
			}
			})
		}
	</script>
</body>
</html>