<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>当前投资-投资明细-个人中心-[@coAttr name="webSiteName" /]</title>
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
	<div class="wrap"><span>会员中心</span><a href="${base}/index.htm">首页</a>/<a href="${base}/user/center.htm" >会员中心</a>/<a href="#" class="active">投资明细</a></div>
</div>
<!-- main s -->
<div class="main">
  <div class="inner_wrap">
    <div class="user_L">
      <div class="timg"> <img src="${base}[@coAttr name="userCenterLeftPic" /]" alt=""> <img src="${base}/front/images/gh.png" alt="" class="gh"> </div>
      <div class="l_menu">
          <ul>
          <li><a href="${base}/user/center.htm" class="aone">个人会员中心<i></i></a></li>
          <li class="active"><a href="#" class="aone active">当前投资<i></i></a>
            <ol>
              <li>
              <a href="${base}/user/collect.htm?type=current">投资汇总</a>
              <a href="${base}/user/current.htm" class="active">投资明细</a>
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
      <h3 class="r_ty_title">当前投资</h3>
      <div class="tz_sc">
      	<form action="${base}/user/current.htm" onkeydown="if(event.keyCode==13)return false;" method="post" id="currentForm">
        	<p id="oneColoumForm"><span>交易日期：</span>
        					<input type="text" class="ipt1" id="date_a" name="startTime" value="[#if (bo.startTime)??]${bo.startTime?string("yyyy-MM-dd")}[/#if]">
        						<em class="em">-</em>
        					 <input type="text" class="ipt1" id="date_b" name="endTime" value="[#if (bo.endTime)??]${bo.endTime?string("yyyy-MM-dd")}[/#if]">
        					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        					 <a href="javascript:void(0);" [#if (bo.timeType)??&&bo.timeType=="1"]class="active"[/#if] data-id="1">全部</a>
        					 <a href="javascript:void(0);" [#if (bo.timeType)??&&bo.timeType=="7"]class="active"[/#if] data-id="7">最近一周</a>
        					 <a href="javascript:void(0);" [#if (bo.timeType)??&&bo.timeType=="30"]class="active"[/#if] data-id="30">最近一个月</a>
        					 <a href="javascript:void(0);" [#if (bo.timeType)??&&bo.timeType=="90"]class="active"[/#if] data-id="90">最近三个月</a>
        	</p>
        	<p id="twoColoumForm"><span>业务类型：</span>
        					 <a href="javascript:void(0);" [#if !(bo.orderType)??]class="active"[/#if] data-id="">全部</a>
        					 <a href="javascript:void(0);" [#if (bo.orderType)??&&bo.orderType=="ok"]class="active"[/#if] data-id="ok">认购</a>
        					 <a href="javascript:void(0);" [#if (bo.orderType)??&&bo.orderType=="add"]class="active"[/#if] data-id="add">申购</a>
        					 <a href="javascript:void(0);" [#if (bo.orderType)??&&bo.orderType=="back"]class="active"[/#if] data-id="back">赎回</a>
        					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        					 <span>产品名称：</span>
        					 <input type="text" class="ipt1" name="name" value="${(bo.name)!}">
        					 <input type="hidden"  name="orderType" id="orderType" value="${(bo.orderType)!}">
        					 <input type="hidden"  name="timeType" id="timeType" value="${(bo.timeType)!}">
        					 <input type="hidden"  name="page" id="page" value="${(info.pageNum)!"0"}">
        					 <input type="submit" class="submit" value="查询" onclick="$("#currentForm").submit()">
        	</p>
        </form>
      </div>
      <link type="text/css" rel="stylesheet" href="${base}/front/style/laydate.css" />
      <link type="text/css" rel="stylesheet" href="${base}/front/style/dahong.css" />
      <script type="text/javascript" src="${base}/front/js/laydate.js"></script> 
      <script type="text/javascript">
      !function(){
      laydate.skin('molv');
      laydate({elem: '#date_a',choose:function(dates){
			$("#oneColoumForm").find("a").removeClass("active");
			$("#timeType").val("");
			$("#page").val("1");
        }});
      laydate({elem: '#date_b',choose:function(dates){
			$("#oneColoumForm").find("a").removeClass("active");
			$("#timeType").val("");
			$("#page").val("1");
        }});
      $("#oneColoumForm").find("a").click(function(){
      		$("#timeType").val($(this).data("id"));
      		$("#page").val("1");
      		$("#currentForm").submit();
      })
      $("#twoColoumForm").find("a").click(function(){
      		$("#orderType").val($(this).data("id"));
      		$("#page").val("1");
      		$("#currentForm").submit();
      })
      }();
      </script>
      <div class="dqtz_list">
        <ul>
         <li class="li_title">
         	<span class="sp_1" style="text-align:center;width:58px;">序列号</span>
          	<span class="sp_2" style="text-align:center;width:190px;">产品名称</span>
          	<span class="sp_3" style="text-align:center;width:80px;">业务类型</span>
          	<span class="sp_4" style="text-align:center;width:100px;">确认日期</span>
          	<span class="sp_4" style="text-align:right;width:90px;">单位净值(元)</span>
          	<span class="sp_4" style="text-align:right;width:90px;">确认份额(份)</span>
          	<span class="sp_4" style="text-align:right;width:90px;">确认金额(元)</span>
		  </li>
          [#if (info.list)??&&(info.list)?size>0]
          [#list info.list as il]
          <li><a href="${base}/user/fundInfo.htm?id=${il.fundId}" target="_blank">
          	<span class="sp_1" style="text-align:center;width:58px;">${(il_index+1)?string("00")}</span>
          	<span class="sp_2" style="text-align:center;width:190px;">${(il.fundName)!}</span>
          	<span class="sp_4" style="text-align:center;width:80px;">${(il.type.description)!}</span>
          	<span class="sp_4" style="text-align:center;width:100px;">${(il.okTime)?string("yyyy-MM-dd")}</span>
          	<span class="sp_4" style="text-align:right;width:90px;">${money4(il.fundAccountMoney)}</span>
          	<span class="sp_4" style="text-align:right;width:90px;">${il.share}</span>
          	<span class="sp_4" style="text-align:right;width:90px;">${money(il.money)!}</span>
          	</a>
          </li>
          [/#list]
          [#else]
         <li><a href="###"><span class="sp_2" style="width:100%;">暂无记录 </span></a></li>
          [/#if]
        </ul>
      </div>
      <div class="page_2" id="pageLi">
      	<a href="javascript:void(0);" data-id="${info.firstPage}"><<</a>
      	<a href="javascript:void(0);" data-id="${info.prePage}"><</a>
      	[#list info.navigatepageNums as inn]
      	<a href="javascript:void(0);" [#if inn==info.pageNum]class="active"[/#if] data-id="${inn}">${inn}</a>
      	[/#list]
      	<a href="javascript:void(0);" data-id="${info.nextPage}">></a>
        <a href="javascript:void(0);" data-id="${info.lastPage}">>></a>
      </div>
      <script>
      $(function(){
      	$("#pageLi").find("a").click(function(){
      		$("#page").val($(this).data("id"));
      		$("#currentForm").submit();
     	 })
      })
      </script>
    </div>
  </div>
</div>
<!-- main e --> 
</div>
[#include "/web/common/footer.ftl"/]
</body>
</html>
