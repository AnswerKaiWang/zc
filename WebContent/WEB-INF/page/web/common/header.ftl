<!-- header s -->
<header class="header" >
  <div class="wrap"><a href="${base}/index.htm" class="logo"><img src="[@coAttr name="companyLogo"]${base}${companyAttr.contant}[/@coAttr]" alt=""></a>
   	[@cuUser]
    [#if user??]
    <p class="fixp">尊敬的会员:&nbsp;<a href="${base}/user/center.htm">${(user.name)!}</a>&nbsp;您好</p>
    [#else]
    <p class="fixp">您是会员吗？<a href="javascript:void(0);" onClick="showlogin('loginBox')">马上登录</a></p>
    [/#if]
    [/@cuUser]
  	<!--<div class="h_search">
    	<form action="">
        	<input type="text" class="ipt1" value="请输入您要查找的内容" onfocus="this.value=''" onblur="if(this.value==''){this.value='请输入您要查找的内容'}">
            <input type="text" class="ipt2">
        </form>
    </div>-->
    <ul class="navUl">
    	<li [#if !currentPage??]class="active"[/#if]><a href="${base}/index.htm">首页</a></li>
    	[@cuUser]
    	[#if user??]
    	<li [#if currentPage??&&currentPage=="userCenter"]class="active"[/#if]><a href="${base}/user/center.htm">会员中心</a></li>
    	[#else]
    	<li><a href="javascript:void(0);" onClick="showlogin('loginBox')">会员中心</a></li>
    	[/#if]
    	[/@cuUser]
    	<li [#if currentPage??&&currentPage=="fund"]class="active"[/#if]><a href="${base}/user/fund.htm">产品信息</a></li>
    	<li [#if currentPage??&&currentPage=="about"]class="active"[/#if]><a href="${base}/about.htm">关于我们</a></li>
    </ul>
  </div>
</header>
<!-- header e -->
<div class="loginBox" style="height:380px;">
  <a href="javascript:void(0);" class="close" title="关闭">×</a>
  <form id="loginForm" onsubmit="return false;">
      <ul>
      	  <li style="color:red;" id="errorMsg"></li>
          <li class="cl">
            <label class="lb1"></label>
            <select name="" class="hideselect1" style="display: none;">
              <option value=""></option>
            </select>
            <div class="select_div1">
              <p class="firstP1"></p>
              <p class="clid1"></p>
              <ul class="select_ul1">
                <li>身份证/护照/营业执照/其他证照</li>
              </ul>
            </div>
          </li>
          <li><label class="lb2"></label><input type="text" class="ipt1" placeholder="证件号码" name="cardNo" value=""></li>
          <li><label class="lb3"></label><input type="password" class="ipt1" placeholder="输入6位查询密码或交易密码" name="password" value=""></li>
          <li><label class="lb4"></label><input type="text" class="ipt1 yzm" placeholder="验证码" name="validate"><a href="#" class="yzma" ><img src="${base}/loginImage.htm" alt="" onClick="this.src='${base}/loginImage.htm?' + new Date().getTime();"></a></li>
          <li style="padding-bottom: 14px;"><input type="button" class="submit" value="登 陆" onclick="login()"></li>
          <!--<li class="forgetpassword"><a href="#">忘记密码？</a></li>-->
      </ul>
  </form>
</div>
<script>
$(function(){
	//导航条
	[#if currentPage??&&currentPage=="index"]
	 var HH=0;//$('.footer').outerHeight(true);
	  $('.slides').height($(window).height()-HH)
	  $('.bd').height($(window).height()-HH)
	  $('.bd').find('ul').height($(window).height()-HH)
	  
	  $(window).resize(function(){
	  var HH=0;//$('.footer').outerHeight(true);
	  $('.slides').height($(window).height()-HH)
	  $('.bd').height($(window).height()-HH)
	  $('.bd').find('ul').height($(window).height()-HH)

    });
	[#else]
	var offT=$(".header").height();
	 $(window).scroll(function(){
		var winTop = $(window).scrollTop();
		if (winTop>=offT){
			$('.header').addClass('header_active');
		}else{
		  $('.header').removeClass('header_active');
		};
	  });
	[/#if]
	  
	[#if needLogin??]
	  showlogin('loginBox');
	[/#if]
});
function login(){
	$.ajax({
		type:"post",
		url:"${base}/login.htm",
		dataType:"json",
		data:$("#loginForm").serializeArray(),
		success:function(dat){
			if(dat.error=="00"){
				window.location.href="${base}/user/center.htm";
			}else{
				$("#errorMsg").html(dat.error);
			}
		},error:function(){
			alert("系统出错");
		}
	
	})
}
</script>