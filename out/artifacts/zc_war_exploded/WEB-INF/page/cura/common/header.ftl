<!-- top s -->
<div class="top">
  <div class="wrap">
    <div class="R fr">
      <ul>
	        <!-- 登陆后 s -->
	         [#if loginSuccessKey??]
		        <li class="user_name">
		        	${name!}
		       	 	[#if loginSuccessKey.gender ==1]先生[/#if][#if loginSuccessKey.gender ==0]女士[/#if]，欢迎您！&nbsp;&nbsp;<a href="${base}/cura/logout.htm">[&nbsp;退出&nbsp;]</a>
		        </li>
		        [#if loginSuccessKey.consultName != null]
		        	<li class="guwena"><i class="ico ico-kefu"></i>您的财富顾问</li>
		        [/#if]
		        [#if loginSuccessKey.consultName == null]
		        	<li><a href="javascript:void(0);" id="show_book_popup"><i class="ico ico-shijian"></i>预约财富顾问<i class="ico ico-hot"></i></a></li>
		        [/#if]
		        
		        <li><a href="javascript:void(0);" onclick="javascript:toCustAccount('${base}');">查看账户</a></li>
		        <!--
		        <li><a href="javascript:void(0)">在线客服</a></li>
		        -->
		        <li onclick="javascript:toMessage('${base}');"><i class="ico ico-iconfontyoujian"></i><a href="javascript:void(0);" id="unreadMsgId" class="mail">${loginSuccessKey.unread}</a>封未读通知</li> 
	         [/#if]
	        <!-- 登陆后 e--> 
	        <!-- 登陆前 s -->
	         [#if !loginSuccessKey??]
		        <li><a href="javascript:void(0);" id="show_book_popup"><i class="ico ico-shijian"></i>预约财富顾问<i class="ico ico-hot"></i></a></li>
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
<div class="weixinBox"><i class="jiao"></i><img src="${base}/frontCura/images/cd.jpg" alt=""><img src="${base}/frontCura/images/cd1.png" alt="">
</div>
<!-- top e -->

<!-- header s -->
<header class="header">
  <div class="wrap"> <a href="${base}/" class="logo"><img src="${base}/frontCura/images/logo.png" alt=""></a>
    <nav class="nav">
      <ul>
      	<li class="show_dropdown">
           <a href="${base}/cura/news.htm">财智资讯</a>
        </li>
        <li><a href="javascript:void(0);" onclick="javascript:toProduct('${base}');">基金产品</a></li>
        <li><a href="javascript:void(0);" onclick="javascript:toCustCenter('${base}');">客户中心</a></li>
        <li><a href="${base}/cura/about.htm">关于我们</a></li>
      </ul>
    </nav>
  </div>
</header>
<!-- header e -->