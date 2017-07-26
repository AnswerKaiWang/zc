<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>修改邮箱-安全中心-个人中心-[@coAttr name="webSiteName" /]</title>
<link type="text/css" rel="stylesheet" href="${base}/front/style/global.css" />
<link type="text/css" rel="stylesheet" href="${base}/front/style/index.css" />
<script  type="text/javascript" src="${base}/front/js/jquery-1.9.1.min.js"></script>
<script  type="text/javascript" src="${base}/front/js/common.js"></script>
<script type="text/javascript" src="${base}/front/js/area.js" ></script>
<!--[if lt IE 9]>
 <script src="${base}/front/js/ie/html5.js"></script> 
 <script src="${base}/front/js/ie/selectivizr-min.js"></script> 
<![endif]-->
</head>
<body>
<div class="background_wraper">
[#assign currentPage="userCenter"]
[#include "/web/common/header.ftl"/]
<div class="Mt"></div>
<div class="position_title">
	<div class="wrap"><span>会员中心</span><a href="${base}/index.htm">首页</a>/<a href="${base}/user/center.htm">会员中心</a>/<a href="${base}/user/protect.htm">安全中心</a>/<a href="#" class="active">修改邮箱</a></div>
</div>
<!-- main s -->
<div class="main">
  <div class="inner_wrap">
    <div class="user_L">
      <div class="timg"> <img src="${base}[@coAttr name="userCenterLeftPic" /]" alt=""> <img src="${base}/front/images/gh.png" alt="" class="gh"> </div>
      <div class="l_menu">
          <ul>
          <li><a href="${base}/user/center.htm" class="aone">个人会员中心<i></i></a></li>
          <li><a href="#" class="aone">当前投资<i></i></a>
            <ol>
              <li>
              <a href="${base}/user/collect.htm?type=current">投资汇总</a>
              <a href="${base}/user/current.htm">投资明细</a>
              <a href="${base}/user/bonus.htm?type=current">分红明细</a>
              </li>
            </ol>
          </li>
           <li><a href="#" class="aone">历史投资<i></i></a>
            <ol>
              <li>
              <a href="${base}/user/collect.htm?type=history">投资汇总</a>
              <a href="${base}/user/history.htm">投资明细</a>
              <a href="${base}/user/bonus.htm?type=history">分红明细</a>
              </li>
            </ol>
          </li>
          <li><a href="${base}/user/fund.htm" class="aone">产品信息<i></i></a></li>
          <li class="active"><a href="#" class="aone active">我的账户<i></i></a>
            <ol>
              <li>
              	<a href="${base}/user/info.htm" >个人信息</a>
              	<a href="${base}/user/protect.htm" class="active">安全中心</a>
              </li>
            </ol>
          </li>
        </ul>
      </div>
      <a href="${base}/user/loginout.htm" class="exit_login">退出登录</a>
    </div>
    <div class="user_R">
      <h3 class="r_ty_title">安全中心</h3>
      <h3 class="r_ty_title_2"><a class="back" href="${base}/user/protect.htm"><img src="${base}/front/images/nsd.jpg" height="12" alt=""></a>修改登录密码</h3>
      <div class="change_mail">
      	<form>
        	<p class="pp1"><i class="fl">1</i><i class="fr">2</i></p>
        	<p class="pp2"><i class="fl">认证原邮箱</i><i class="fr">绑定新邮箱</i></p>
        	<div style="width:450px;margin:auto;color:red;text-align:center;" id="sendMsgSuccess">${(info)!}</div>
        	<ul class="ul_2">
        		<li><label>当前邮箱</label><input type="text" class="ipt1" value="${(user.email)!}" disabled="disabled"></li>
        		<li><label>验证码</label><input type="text" class="ipt1" placeholder="请输入邮箱验证码" id="code"><a href="javascript:void(0);" class="get" id="getCodeButton">获取</a></li>
        		<li class="border_none" style="display:none;" id="sendSuccessShow"><span class="tip">邮箱验证码已发送,请打开邮箱输入</span></li>
        		<li class="border_none"><input type="button" class="submit" value="确 定" onclick="subForm()"></li>
        	</ul>
        </form>
      </div> 
    </div>
  </div>
</div>
<!-- main e --> 
<script>
$(function(){
	$("#getCodeButton").click(function(){
		$.ajax({
		type:"post",
		data:{},
		url:"${base}/user/email/getCode.htm",
		dataType:"json",
		success:function(data){
			if(data.status=="00"){
				$("#sendSuccessShow").show();
				$("#sendMsgSuccess").html("")
			}else{
				$("#sendMsgSuccess").html(data.status);
			}
		},error:function(){
			$("#sendMsgSuccess").html("系统错误");
		}
		})
	})
})
	function subForm(){
		$.ajax({
		type:"post",
		data:{code:$("#code").val()},
		url:"${base}/user/email/unbind.htm",
		dataType:"json",
		success:function(data){
			if(data.status=="00"){
				top.location.href="${base}/user/email/toBind.htm";
			}else{
				$("#sendMsgSuccess").html(data.status);
				$("#sendSuccessShow").hide();
			}
		},error:function(){
			$("#sendMsgSuccess").html("系统错误");
			$("#sendSuccessShow").hide();
		}
	  })
	}
</script>
</div>
<!-- footer s -->
[#include "/web/common/footer.ftl"/]
<!-- footer e -->
</body>
</html>
