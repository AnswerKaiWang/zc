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
<!-- top s -->
<div class="top">
  <div class="wrap">
    <div class="R fr">
      <ul>
        	<!-- 登陆后 s -->
	         [#if name??]
		        <li class="user_name">${name!}[#if loginSuccessKey.gender ==1]先生[/#if][#if loginSuccessKey.gender ==0]女士[/#if]，欢迎您！&nbsp;&nbsp;<a href="${base}/cura/logout.htm">[&nbsp;退出&nbsp;]</li>
		        [#if loginSuccessKey.consultName != null]
		        	<li class="guwena"><i class="ico ico-kefu"></i>财富顾问</li>
		        [/#if]
		        [#if loginSuccessKey.consultName == null]
		        	<li><a href="javascript:void(0);" id="show_book_popup"><i class="ico ico-shijian"></i>财富顾问<i class="ico ico-hot"></i></a></li>
		        [/#if]
		        <li><a href="javascript:void(0);" onclick="javascript:toCustAccount('${base}');">查看账户</a></li>
		        <!--
		        <li><a href="javascript:void(0)">在线客服</a></li>
		        -->
		        <li onclick="javascript:toMessage('${base}');"><i class="ico ico-iconfontyoujian"></i><a href="javascript:void(0);" class="mail">${loginSuccessKey.unread}</a>封未读通知</li> 
	         [/#if]
	        <!-- 登陆后 e--> 
	        <!-- 登陆前 s -->
	         [#if !name??]
		        <li><a href="javascript:void(0);" id="show_book_popup"><i class="ico ico-shijian"></i>财富顾问<i class="ico ico-hot"></i></a></li>
		        <li><a href="${base}/cura/login.htm" class="dl">登录</a><a href="${base}/cura/reg.htm" class="zc">注册</a></li>
	        [/#if]
	        <!-- 登陆前 e -->
        <li class="weixina"><i class="ico ico-weixin"></i>关注我们</li>
        <li><i class="ico ico-phone_1"></i><span class="tel">400-800-1000</span></li>
      </ul>
    </div>
  </div>
</div>
[#if loginSuccessKey.consultName != null]
	<div class="guwenBox"><i class="jiao"></i><i class="ico ico-kefu"></i><em>${loginSuccessKey.consultPhone}</em></div>
[/#if]
[#include "/cura/common/caifu.ftl"]
<div class="weixinBox">
  <i class="jiao"></i><img src="${base}/frontCura/images/cd.jpg" alt=""><img src="${base}/frontCura/images/cd1.png" alt="">
</div>
<header class="header">
  <div class="wrap"> <a href="${base}/" class="logo"><img src="${base}/frontCura/images/logo.png" alt=""></a>
    <nav class="nav">
      <ul>
        <li><a href="${base}/cura/news.htm" class="active">财智资讯</a></li>
        <li><a href="javascript:void(0);" onclick="javascript:toProduct('${base}');">基金产品</a></li>
        <li><a href="javascript:void(0);" onclick="javascript:toCustCenter('${base}');">客户中心</a></li>
        <li><a href="${base}/cura/about.htm">关于我们</a></li>
      </ul>
    </nav>
  </div>
</header>
<!-- header e --> 
<!-- banner s -->
<div class="banner"></div>
<!-- banner e --> 
<!-- main s -->
<div class="main">
  <p class="js_tab_title">
	<a href="${base}/cura/about.htm">中城投资介绍</a>
	<a href="${base}/cura/about/cf.htm" class="active">中城联合财富介绍 </a></p>
  <p class="js_ty_title"><span class="j_sp">中城联合财富</span></p>
  <script  type="text/javascript" src="${base}/frontCura/js/wow.min.js"></script> 
  <script type="text/javascript">
  new WOW().init();
  </script> 
  <!-- brief_6 s  -->
  <div class="brief_6">
    <p class="js_ty_title_2"><span class="j_sp">财富服务人群</span></p>
    <div class="txt wow fadeInDown">为客户提供优质的财富管理和投资服务<br>
      帮助企业、家庭、个人实现资产增长</div>
    <ul class="ul wow fadeInUp">
      <li><span>中城联盟</span></li>
      <li><span>转型资本</span></li>
      <li><span>投资机构</span></li>
      <li><span>特定圈层</span></li>
    </ul>
  </div>
  <!-- brief_6 e  --> 
  <!-- brief_7 s  -->
  <div class="brief_7">
    <p class="js_ty_title_2"><span class="j_sp">我们的职责</span></p>
    <div class="txt wow zoomIn">为客户提供优质的财富管理和投资服务<br>
      帮助企业<br>
      家庭<br>
      个人实现资产稳健增长</div>
  </div>
  <!-- brief_7 e  --> 
  <!-- brief_8 s  -->
  <div class="brief_8">
    <p class="js_ty_title_2"><span class="j_sp">财富服务能力</span></p>
    <div class="dl_w wow lightSpeedIn">
      <dl>
        <dt><span>产品筛选</span></dt>
        <dd>依托中城投资基金投资与管理能力，有效锁定优质基础资产，严格筛选适合财富投资的基金产品，确保客户利益</dd>
      </dl>
      <dl>
        <dt><span>风险控制</span></dt>
        <dd>以财富视角，参与产品前端市场风险的把握，跟踪产品发售后续情况的变动，确保投资人的财富安全，为客户提供产品的“全周期服务”</dd>
      </dl>
      <dl>
        <dt><span>客户服务</span></dt>
        <dd>了解、引导、挖掘客户投资理财需求，建立精准营销的客户管理与服务体系，为客户提供财富管理的规划及解决方案</dd>
      </dl>
    </div>
  </div>
  <!-- brief_8 e  --> 
  <!-- brief_9 s  -->
  <div class="brief_9">
    <p class="js_ty_title_2"><span class="j_sp">财富投资理念</span></p>
    <div class="txt wow fadeInLeft">安全、长期、无间隙 </div>
  </div>
  <!-- brief_9 e  --> 
  <!-- brief_10 s  -->
  <div class="brief_10">
    <p class="js_ty_title_2"><span class="j_sp">中城观点</span></p>
    <div class="Img wow fadeInUp"><img src="${base}/frontCura/images/v-03.jpg" alt=""> </div>
  </div>
  <!-- brief_10 e  --> 
  <!-- brief_11 s  -->
  <div class="brief_11">
    <p class="js_ty_title_2"><span class="j_sp">产品类型</span></p>
    <div class="Img wow fadeInRight"><img src="${base}/frontCura/images/v-04.jpg" alt=""> </div>
  </div>
  <!-- brief_11 e  --> 
  <!-- brief_12 s  -->
  <div class="brief_12">
    <p class="js_ty_title_2"><span class="j_sp">服务覆盖城市</span></p>
    <div class="Img wow fadeInLeft"><img src="${base}/frontCura/images/v-05.jpg" width="900" alt=""> </div>
  </div>
  <!-- brief_12 e  --> 
</div>
<!-- main e --> 
<!-- 返回顶部 s --> 
<a href="javascript:void(0);" id="back_top"><i class="ico ico-shangjiantou"></i><span>返回顶部</span></a> 
<!-- 返回顶部 e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>