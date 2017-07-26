<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>个人中心-[@coAttr name="webSiteName" /]</title>
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
	<div class="wrap"><span>会员中心</span><a href="${base}/index.htm">首页</a>/<a href="${base}/user/center.htm" class="active">会员中心</a></div>
</div>
<!-- main s -->
<div class="main">
  <div class="inner_wrap">
    <div class="user_L">
      <div class="timg"> <img src="${base}[@coAttr name="userCenterLeftPic" /]" alt=""> <img src="${base}/front/images/gh.png" alt="" class="gh"> </div>
      <div class="l_menu">
        <ul>
          <li class="active"><a href="${base}/user/center.htm" class="aone">个人会员中心<i></i></a></li>
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
      [@coAttr name="userCenterTopTip" ][#if (companyAttr.contant)??]<div class="tip_T"><a href="#" class="close"></a><span>${(companyAttr.contant)!"欢迎"}</span></div>[/#if][/@coAttr]
      <div class="user_head">
      	<dl class="dl_name">
      		<dt><img src="images/bqe.jpg" alt=""><i class="bj_1"></i><i class="bj_2"></i><a href="#">编辑头像</a></dt>
      		<dd>
            	<h2 style="margin-top:15px;">${(welcomeText)!},&nbsp;&nbsp;${(user.name)!'用户'}</h2>
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
      <div class="jjxx">
      	[#if (cunxus)??&&(cunxus)?size>0]
          	[#list cunxus as cx]
          		<dl>
          <dt><span>${(cx.fundName)!}-${cx.bei}<br /><h4 style="font-weight: normal;color: #878787;font-size: 15px;line-height: 1.8em;">成立日期:[#if (cx.beginTime)??]${(cx.beginTime)?string("yyyy-MM-dd")}[/#if]</h4></span><a href="${base}/user/fundInfo.htm?id=${cx.fundId}" target="_blank">查看详情>></a></dt>
          <dd>
            <div class="block_1">
              <p><i class="cl">${(cx.size)!}</i></p>
              <p>产品规模</p>
            </div>
            <div class="block_2">
              <p><i class="cl">${(cx.duration)!}</i></p>
              <p>存续期</p>
            </div>
            <div class="block_3">
              <p><i class="cl">${money(cx.money)}</i></p>
              <p>投资金额</p>
            </div>
          </dd>
        </dl>
          	[/#list]
        [#else]
        [/#if]
      </div>
      
      <!--<div class="grcp_list">
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
           		<a href="${base}/user/fundInfo.htm?id=${cx.fundId}">
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
      </div>-->
    </div>
  </div>
</div>
<!-- main e --> 
</div>
[#include "/web/common/footer.ftl"/]
</body>
</html>
