<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>投资汇总-[#if type??&&type=="history"]历史投资[#else]当前投资[/#if]-[@coAttr name="webSiteName" /]</title>
<link type="text/css" rel="stylesheet" href="${base}/front/style/global.css" />
<link type="text/css" rel="stylesheet" href="${base}/front/style/index.css" />
<script  type="text/javascript" src="${base}/front/js/jquery-1.9.1.min.js"></script>
<script  type="text/javascript" src="${base}/front/js/common.js"></script>
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
	<div class="wrap"><span>会员中心</span><a href="${base}/index.htm">首页</a>/<a href="${base}/user/center.htm">会员中心</a>/<a href="#" class="active">投资汇总</a></div>
</div>
<!-- main s -->
<div class="main">
  <div class="inner_wrap">
    <div class="user_L">
      <div class="timg"> <img src="${base}[@coAttr name="userCenterLeftPic" /]" alt=""> <img src="${base}/front/images/gh.png" alt="" class="gh"> </div>
      <div class="l_menu">
        <ul>
          <li><a href="${base}/user/center.htm" class="aone">个人会员中心<i></i></a></li>
          <li [#if type??&&type=="current"]class="active"[/#if]><a href="#" href="javascript:void(0):" class="aone [#if type??&&type=="current"]active[/#if]" >当前投资<i></i></a>
            <ol>
              <li>
              <a href="${base}/user/collect.htm?type=current" [#if type??&&type=="current"]class="active"[/#if]>投资汇总</a>
              <a href="${base}/user/current.htm">投资明细</a>
              <a href="${base}/user/bonus.htm?type=current">分红明细</a>
              </li>
            </ol>
          </li>
           <li [#if type??&&type=="history"]class="active"[/#if]><a href="#" class="aone [#if type??&&type=="history"]active[/#if]">历史投资<i></i></a>
            <ol>
              <li>
              <a href="${base}/user/collect.htm?type=history" [#if type??&&type=="history"]class="active"[/#if]>投资汇总</a>
              <a href="${base}/user/history.htm">投资明细</a>
              <a href="${base}/user/bonus.htm?type=history">分红明细</a>
              </li>
            </ol>
          </li>
          <li><a href="${base}/user/fund.htm" class="aone">产品信息<i></i></a></li>
          <li><a href="#" class="aone">我的账户<i></i></a>
            <ol>
              <li>
              	<a href="${base}/user/info.htm">个人信息</a>
              	<a href="${base}/user/protect.htm">安全中心</a>
              </li>
            </ol>
          </li>
        </ul>
      </div>
      <a href="${base}/user/loginout.htm" class="exit_login">退出登录</a>
    </div>
    <div class="user_R">
      <!--<div class="tip_T"><a href="#" class="close"></a><span>今天是您的生日，中诚投资祝您生日快乐！网站向您的账户发放了10元生日红包，投资抵10查看投资抵10...</span></div>-->
      <div class="user_head">
      	<dl class="dl_name">
      		<dt><img src="images/bqe.jpg" alt=""><i class="bj_1"></i><i class="bj_2"></i><a href="#">编辑头像</a></dt>
      		<dd>
            	<h2 style="margin-top:15px;">上午好,&nbsp;&nbsp;${(user.name)!'用户'}</h2>
            	<!--<h4>证件号码：${(user.username)!}</h4>-->
            </dd>
      	</dl>
        <p class="login_record">上次登录时间：[#if (user.lastLoginTime)??]${(user.lastLoginTime)?string("yyyy-MM-dd HH:mm:ss")}[/#if]</p>
      </div>
      <!--
      <div class="tz_sc">
      	<form action="">
        	<p><span>日期状态：</span>
        	<input type="text" class="ipt1" id="date_a" value="[#if startDate??]${startDate?string("yyyy-MM-dd")}[/#if]">
        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	<a href="${base}/user/center.htm?fromDate=1" [#if fromDate??&&fromDate=="1"]class="active"[/#if]>今天</a>
        	<a href="${base}/user/center.htm?fromDate=7" [#if fromDate??&&fromDate=="7"]class="active"[/#if]>最近一周</a>
        	<a href="${base}/user/center.htm?fromDate=30" [#if fromDate??&&fromDate=="30"]class="active"[/#if]>最近一个月</a>
        	<a href="${base}/user/center.htm?fromDate=90" [#if fromDate??&&fromDate=="90"]class="active"[/#if]>最近三个月</a>
        	</p>
        </form>
      </div>
      -->
      <link type="text/css" rel="stylesheet" href="${base}/front/style/laydate.css" />
      <link type="text/css" rel="stylesheet" href="${base}/front/style/dahong.css" />
      <script type="text/javascript" src="${base}/front/js/laydate.js"></script> 
      <script type="text/javascript">
      !function(){
      	laydate.skin('molv');
      	laydate({elem: '#date_a',choose:function(dates){
			window.location.href="${base}/user/center.htm?fromDate="+dates
        }});
      }();
      </script>
      <div class="grcp_list">
        <ul>
          <li class="li_title">
          	<span class="sp_1" style="text-align:center;width:58px;">序列号</span>
          	<span class="sp_1" style="text-align:center;width:250px;">产品名称</span>
          	<span class="sp_1" style="text-align:center;width:150px;">成立日期</span>
          	<span class="sp_1" style="text-align:center;width:100px;">产品期限</span>
          	<span class="sp_1" style="width:150px;text-align:right;">存续份额(元)&nbsp;</span>
          	</li>
          [#if cunxus??]
          	[#list cunxus as cx]
           	<li>
           		<a href="${base}/user/fundInfo.htm?id=${cx.fundId}" target="_blank">
           		<span class="sp_1" style="text-align:center;width:58px;">${(cx_index+1)?string("00")}</span>
           		<span class="sp_1" style="text-align:center;width:250px;">${(cx.fundName)!}</span>
           		<span class="sp_1" style="text-align:center;width:150px;">[#if (cx.beginTime)??]${(cx.beginTime)?string("yyyy-MM-dd")}[/#if]</span>
           		<span class="sp_1" style="text-align:center;width:100px;">${(cx.duration)!}</span>
           		<span class="sp_2" style="width:150px;text-align:right;">${money(cx.money)}&nbsp;</span>
           		</a>
           	</li>
           [/#list]
          [#else]
          	 <li><span class="sp_1" style="width:100%;">暂无记录</span></li>
          [/#if]
        </ul>
        <a href="javascript:void(0);" class="showlmore">显示更多条</a>
      </div>
    </div>
  </div>
</div>
<!-- main e --> 
</div>
[#include "/web/common/footer.ftl"/]
</body>
</html>
