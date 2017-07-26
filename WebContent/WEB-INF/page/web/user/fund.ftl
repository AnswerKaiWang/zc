<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>基金信息-个人中心-[@coAttr name="webSiteName" /]</title>
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
[#assign currentPage="fund"]
[#include "/web/common/header.ftl"/]
<div class="Mt"></div>
<div class="position_title">
	<div class="wrap"><span>会员中心</span><a href="${base}/index.htm">首页</a>/<a href="${base}/user/center.htm" >会员中心</a>/<a href="#" class="active">产品信息</a></div>
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
          <li class="active"><a href="${base}/user/fund.htm" class="aone active">产品信息<i></i></a></li>
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
      <h3 class="r_ty_title">产品信息</h3>
      <div class="jjxx">
      	[#if (info.list)??&&(info.list)?size>0]
          	[#list info.list as il]
          		<dl>
          <dt><span>${il.name}<br /><h4 style="font-weight: normal;color: #878787;font-size: 15px;line-height: 1.8em;">成立日期:[#if (il.beginTime)??]${(il.beginTime)?string("yyyy-MM-dd")}[/#if]</h4></span><a href="${base}/user/fundInfo.htm?id=${il.id}" target="_blank">查看详情>></a></dt>
          <dd>
            <div class="block_1">
              <p><i class="cl">${(il.size)!}</i></p>
              <p>产品规模</p>
            </div>
            <div class="block_2">
              <p><i class="cl">${(il.duration)!}</i></p>
              <p>存续期</p>
            </div>
            <div class="block_3">
              <p><i class="cl">${(il.status.description)!}</i></p>
              <p>基金状态</p>
            </div>
          </dd>
        </dl>
          	[/#list]
        [#else]
        [/#if]
      </div>
      <div class="page_2" id="pageLi">
      	<a href="${base}/user/fund.htm?page=${info.firstPage}" ><<</a>
      	<a href="${base}/user/fund.htm?page=${info.prePage}" ><</a>
      	[#list info.navigatepageNums as inn]
      	<a href="[#if inn==info.pageNum]#[#else]${base}/user/fund.htm?page=${inn}[/#if]" [#if inn==info.pageNum]class="active"[/#if] data-id="${inn}">${inn}</a>
      	[/#list]
      	<a href="${base}/user/fund.htm?page=${info.nextPage}" >></a>
        <a href="${base}/user/fund.htm?page=${info.lastPage}" >>></a>
      </div>
    </div>
  </div>
</div>
<!-- main e --> 
</div>
[#include "/web/common/footer.ftl"/]
</body>
</html>
