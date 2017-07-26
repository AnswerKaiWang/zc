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
		        <li class="guwena"><i class="ico ico-kefu"></i>财富顾问</li>
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
        <li><a href="${base}/cura/news.htm">财智资讯</a></li>
        <li><a href="javascript:void(0);" onclick="javascript:toProduct('${base}');">基金产品</a></li>
        <li><a href="javascript:void(0);" onclick="javascript:toCustCenter('${base}');">客户中心</a></li>
        <li><a href="${base}/cura/about.htm" class="active">关于我们</a></li>
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
  	<a href="${base}/cura/about.htm" class="active">中城投资介绍</a>
  	<a href="${base}/cura/about/cf.htm">中城联合财富介绍 </a></p>
  <p class="js_ty_title"><span class="j_sp">中城投资</span></p>
  <script  type="text/javascript" src="${base}/frontCura/js/wow.min.js"></script> 
  <script type="text/javascript">
  new WOW().init();
  </script> 
  <!-- brief_1 s  -->
  <div class="brief_1">
    <dl class="dl_1">
      <dt><span>股票代码-833880</span><img src="${base}/frontCura/images/h.jpg" width="108" height="114" alt=""></dt>
      <dd>中城投资是国内历史最长的房地产私募投资管理机构。专注房地产全价值链和新产业链PE投资，提供主要大类配置的投资和资产管理服务。<br>
        中城投资成立于 2002年9月28日，创始股东12家，现有股东 55 家，注册资本 16.36 亿元。<br>
        2015年10月26日，中城投资成功挂牌新三板 </dd>
    </dl>
    <dl class="dl_2">
      <dt><img src="${base}/frontCura/images/g.jpg" width="570" height="280" alt=""></dt>
      <dd>
        <h3>路林 总裁</h3><span>Lu Lin CEO</span>
        <h4>经济学博士、复旦大学经济学博士</h4>
        曾任职于中共中央宣传部、大恒新纪元科技股份有限公司（600288.SS）、中国高科集团股份有限公司（600730.SS）、上海互联网创业投资有限公司。2004年4月起任中城投资总裁。<br>现任中国财富管理50人论坛成员、上海国际股权投资基金协会副理事长。 </dd>
    </dl>
  </div>
  <!-- brief_1 e  --> 
  <!-- brief_2 s  -->
  <div class="brief_2">
    <p class="js_ty_title_2"><span class="j_sp">三大业务中心</span></p>
    <div class="dl_w">
      <dl class="wow fadeInLeft">
        <dt><span>投资开发</span></dt>
        <dd>自有资金投资、房地产基金投资管理;<br>
          房地产投资开发管理、不动产的运营管理和金融产品创设;<br>
          项目及企业并购业务</dd>
      </dl>
      <dl class="wow fadeInUp">
        <dt><span>基金发展</span></dt>
        <dd>发起投资并管理房地产投资基金<br>
          股权投资基金、证券投资基金、海外投资基金</dd>
      </dl>
      <dl class="wow fadeInRight">
        <dt><span>联合财富</span></dt>
        <dd>依托中城投资基金产品能力<br>
          为财富个人和财富机构提供优质的财富管理和投资服务</dd>
      </dl>
    </div>
  </div>
  <!-- brief_2 e  --> 
  <!-- brief_3 s  -->
  <div class="brief_3">
    <p class="title">中国房地产协会<b>榜首</b><span>2016中国房地产基金公司10强</span></p>
    <ul class="UL">
      <li class="wow flipInY"><span><em>卓越房地产基金管理机构</em><i>上海证券报</i></span></li>
      <li class="wow flipInY"><span><em>最佳全资产管理机构</em><i>融资中国</i></span></li>
      <li class="wow flipInY"><span><em>最佳中国房地产基金管理人</em><i>第一财经</i></span></li>
    </ul>
    <div class="txt wow fadeInRight"> 招商银行、工商银行、民生银行等私人银行“合格房地产基金管理人”首选名单<br>
      中国证券投资基金业协会首批会员<br>
      辖下中国证券投资基金业协会备案的私募基金管理机构5家<br>
      上海国际股权投资基金协会副理事长单位 </div>
  </div>
  <!-- brief_3 e  --> 
  <!-- brief_4 s  -->
  <div class="brief_4">
    <p class="js_ty_title_2"><span class="j_sp">业务类别</span></p>
    <div class="CT wow fadeInUp"> <img src="${base}/frontCura/images/fgs.jpg" alt=""> </div>
  </div>
  <!-- brief_4 e  --> 
  <!-- brief_5 s  -->
  <div class="brief_5">
    <p class="js_ty_title_2">
    <span class="j_sp">中城投资股东企业</span></p>
      <div class="ulWrap">
        <ul>
          <li><span><img src="${base}/frontCura/images/lg.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg2.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg3.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg4.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg5.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg6.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg7.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg8.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg9.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg10.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg11.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg12.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg13.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg14.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg15.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg16.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg17.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg18.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg19.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg20.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg21.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg22.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg23.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg24.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg25.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg26.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg27.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg28.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg29.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg30.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg31.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg32.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg33.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg34.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg35.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg36.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg37.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg38.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg39.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg40.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg41.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg42.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg43.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg44.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg45.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg46.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg47.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg48.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg49.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg50.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg51.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg52.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg53.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
          <li><span><img src="${base}/frontCura/images/lg54.jpg" onload="DrawImage(this,132,105);" alt=""></span></li>
        </ul>
      </div>
      <a class="prev" href="javascript:void(0)"><i class="ico ico-zu"></i></a>
      <a class="next" href="javascript:void(0)"><i class="ico ico-you"></i></a>
  </div>
  <!-- brief_5 e  --> 
  <script  type="text/javascript" src="${base}/frontCura/js/jquery.SuperSlide.2.1.1.js"></script> 
  <script type="text/javascript">
              jQuery(".brief_5").slide({mainCell:".bd .ulWrap",autoPage:true,effect:"leftLoop",autoPlay:true,vis:1,interTime:3000});
   </script> 
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