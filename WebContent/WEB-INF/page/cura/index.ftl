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
<div class="index_wrap"> 
  <!-- index_header s -->
  <header class="index_header" >
    <div class="wrap"> <a href="${base}/index.htm" class="logo fl"> <img src="${base}/frontCura/images/logo.png" alt=""></a>
      <div class="hd_r fr">
        <ul>
        [#if loginSuccessKey??]
          <!-- 登陆后 s -->
          <li class="user_name">${name}[#if loginSuccessKey.gender ==1]先生[/#if][#if loginSuccessKey.gender ==0]女士[/#if]，欢迎您！
          	&nbsp;&nbsp;<a href="${base}/cura/logout.htm">[&nbsp;退出&nbsp;]</a>
          </li>
          
         [#if loginSuccessKey.consultName != null]
        	<li class="guwena"><i class="ico ico-kefu"></i>财富顾问</li>
        [/#if]
        [#if loginSuccessKey.consultName == null]
        	<li><a href="javascript:void(0);" id="show_book_popup"><i class="ico ico-shijian"></i>预约财富顾问<i class="ico ico-hot"></i></a></li>
        [/#if]
        
          <li><a href="javascript:void(0);" onclick="javascript:toCustAccount('${base}');">查看账户</a></li>
          <!--
		        <li><a href="javascript:void(0)">在线客服</a></li>
		        -->
          <li onclick="javascript:toMessage('${base}');"><i class="ico ico-iconfontyoujian"></i><a href="javascript:void(0);" class="mail">${loginSuccessKey.unread}</a>封未读通知</li> 
          <!-- 登陆后 e -->
        [/#if]
        [#if !loginSuccessKey??]
          <!-- 登陆前 s -->
           <li><a href="javascript:void(0);" id="show_book_popup"><i class="ico ico-shijian"></i>预约财富顾问<i class="ico ico-hot"></i></a></li>
          <li><a href="${base}/cura/login.htm" class="dl">登录</a>
          		<a href="${base}/cura/reg.htm" class="zc">注册</a></li>
          <!-- 登陆前 e -->
        [/#if]
          <li class="weixina"><i class="ico ico-weixin"></i>关注我们</li>
          <li><i class="ico ico-phone_1"></i><span class="tel">400-800-1000</span></li>
        </ul>
      </div>
    </div>
  </header>
 [#if loginSuccessKey.consultName != null]
	<div class="guwenBox"><i class="jiao"></i><i class="ico ico-kefu"></i><em>${loginSuccessKey.consultPhone}</em></div>
[/#if]
  <div class="weixinBox">
    <i class="jiao"></i><img src="${base}/frontCura/images/cd.jpg" alt=""><img src="${base}/frontCura/images/cd1.png" alt="">
  </div>
  <!-- index_header e --> 
  <!-- index_main s -->
  <div class="index_main">
    <h3 class="h3_title animated fadeInDown">您身边的高端财富顾问<span>YOUR SIDE OF HIGH-END FINANCIAL ADVISER</span></h3>
    <nav class="animated fadeInUp">
      <ul>
        <li><a href="${base}/cura/news.htm"><span>财智资讯</span><i>Financial information</i></a></li>
        <li><a href="javascript:void(0);" onclick="javascript:toProduct('${base}');"><span>基金产品</span><i>Fund products</i></a></li>
        <li><a href="javascript:void(0);" onclick="javascript:toCustCenter('${base}');"><span>客户中心</span><i>Customer Center</i></a></li>
        <li><a href="${base}/cura/about.htm"><span>关于我们</span><i>About us</i></a></li>
      </ul>
    </nav>
  </div>
  <!-- index_main e --> 
  <script type="text/javascript">
//首页
  function setsize(){
    $('.index_wrap').height($(window).height());
    var H=$('.index_main').height()/2;
    var L=$('.index_main').width()/2;
    $('.index_main').css({'margin-top':-H,'margin-left':-L});
  }; 

  setsize();
  $(window).resize(function(){
    setsize();
  });
</script> 
</div>
[#include "/cura/common/caifu.ftl"]
</body>
</html>