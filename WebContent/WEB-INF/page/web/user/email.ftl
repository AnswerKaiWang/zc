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
      <h3 class="r_ty_title_2"><a class="back" href="${base}/user/protect.htm"><img src="${base}/front/images/nsd.jpg" height="12" alt=""></a>修改邮箱</h3>
      <div class="change_mail">
      	<div style="width:450px;margin:auto;color:red;text-align:center;">${(info)!}</div>
        <ul class="ul_1">
            <li><a href="${base}/user/email/canGetCode.htm">
            	<h3>能接收验证码</h3>
            	<p>通过原邮件接收验证码的方式修改</p>
            </a></li>
            <li><a href="#">
            	<h3>无法接收验证码</h3>
            	<p>通过手机号码接收验证码的方式修改</p>
            </a></li>
        </ul>
      </div> 
    </div>
  </div>
</div>
<!-- main e --> 
<script>
	
</script>
</div>
<!-- footer s -->
[#include "/web/common/footer.ftl"/]
<!-- footer e -->
</body>
</html>
