<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>安全中心-个人中心-[@coAttr name="webSiteName" /]</title>
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
	<div class="wrap"><span>会员中心</span><a href="${base}/index.htm">首页</a>/<a href="${base}/user/center.htm">会员中心</a>/<a href="#" class="active">安全中心</a></div>
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
              <a href="${base}/user/current.htm">投资汇总</a>
              <a href="${base}/user/current.htm">投资明细</a>
              <a href="${base}/user/bonus.htm?type=current">分红明细</a>
              </li>
            </ol>
          </li>
           <li><a href="#" class="aone">历史投资<i></i></a>
            <ol>
              <li>
              <a href="${base}/user/current.htm">投资汇总</a>
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
      <div class="aqzx">
        <ul>
          <li [#if !(user.password)??]class="unverified"[/#if]>
              <span class="sp_1">登录密码</span>
              <span class="sp_2">保障账户安全。建议您定期更换密码</span>
              <span class="sp_3"><a href="${base}/user/password.htm">修改 ></a></span>
          </li>
          <li [#if !(user.phone)??]class="unverified"[/#if]>
              <span class="sp_1">手机号码</span>
              <span class="sp_2">保障账户与资金安全,是您在中城投资重要的身份凭证</span>
              <span class="sp_3">
              ${(user.phone)!}
              [#if !(user.phone)??]
              	<a href="${base}/user/phone/toBind.htm">绑定 ></a>
              [#else]
              <a href="${base}/user/phone/toUnBind.htm">修改 ></a>
              [/#if]
              </span>
          </li>
          <li [#if !(user.cardNo)??]class="unverified"[/#if]>
              <span class="sp_1">实名认证</span>
              <span class="sp_2">保障账户安全,直邮通过实名认证,才能投资。</span>
              <span class="sp_3">${(user.name)!}  ${(user.cardNo)!}</span>
          </li>
          <li [#if !(user.email)??]class="unverified"[/#if]>
              <span class="sp_1">电子邮箱</span>
              <span class="sp_2">邮件接收账户通知,及时了解账户信息变动情况</span>
              <span class="sp_3">
              ${((user.email)!"")}
              [#if !(user.email)??]
              	<a href="${base}/user/email/toBind.htm">绑定 ></a>
              [#else]
              <a href="${base}/user/email/toBind.htm">修改 ></a>
              [/#if]
              </span>
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>
<!-- main e --> 
</div>
<!-- footer s -->
[#include "/web/common/footer.ftl"/]
<!-- footer e -->
</body>
</html>
