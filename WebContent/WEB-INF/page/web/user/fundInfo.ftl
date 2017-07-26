<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>${(fund.name)!}-产品详情-[@coAttr name="webSiteName" /]</title>
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
<body>
<div class="background_wraper">
[#assign currentPage="fund"]
[#include "/web/common/header.ftl"/]
<div class="Mt"></div>
<div class="position_title">
	<div class="wrap"><span>会员中心</span><a href="${base}/index.htm">首页</a>/<a href="${base}/user/center.htm" >会员中心</a>/<a href="${base}/user/fund.htm">产品信息</a>/<a href="#" class="active">产品详情</a></div>
</div>
<!-- main s -->
<div class="main">
  <dl class="fund_Top">
    <dt>
      <h3>${(fund.name)!}</h3>
      <h4>备案号:${(fund.bei)!}&nbsp;&nbsp;&nbsp;&nbsp;成立日期:[#if (fund.beginTime)??]${(fund.beginTime)?string("yyyy-MM-dd")}[/#if]</h4>
    </dt>
    <dd>
      <div class="block_1">
        <p><b>${(fund.size)!}</b></p>
        <p>产品规模</p>
      </div>
      <div class="block_2">
        <p><b>${(fund.duration)!}</b></p>
        <p>存续期</p>
      </div>
      <div class="block_3">
        <p><b>${(fund.status.description)!}</b></p>
        <p>基金状态</p>
      </div>
    </dd>
  </dl>
  <div class="fund_Bottom">
	<p class="fund_tab_title"><a href="javascript:void(0);" class="active">基金文件</a><a href="javascript:void(0);">净值信息</a></p>
    <!-- 文件详情弹出窗 s -->
    <div class="file_popup">
        <p class="title"><span>文件详情</span><a href="javascript:void(0);" class="close"></a></p>
        <div class="filetextBox"></div>
        <p class="button_p"><a href="#" class="popup_ld">下载</a></p>
    </div> 
    <!-- 文件详情弹出窗 e --> 
    <div class="fund_tab_show jjwj">
      	[#list fundFileTypes as ft]
      		<dl class="file_list">
      			<dt><i class="num"></i>${(ft.description)!}</dt>
      			<dd>
          		<p class="border"></p>
          			<ul>
      		[#if fundFiles??]
      			[#list fundFiles as ff]
      				[#if ft==ff.type][#--class="filename"--]
            		<li><a href="${base}${(ff.url)!}" target="_blank">[#if (ff.beginTime)??]${(ff.beginTime)?string("yyyy-MM-dd")}[/#if]  ${(ff.name)!}</a><a href="${(ff.url)!}" class="download" target="_blank">下载</a>
              			<div class="file_text">${(ff.contant)!"暂无内容"}</div>
            		</li>
      				[/#if]
      			[/#list]
      		[/#if]
      				</ul>
        		</dd>
      		</dl>
      	[/#list]
    </div>
    <div class="fund_tab_show jzxx">
      <table border="0" cellspacing="0" cellpadding="0" class="jz_table">
        <tr>
          <th>日期</th>
          <th>产品代码</th>
          <th>产品名称</th>
          <th>单位净值</th>
        </tr>
        [#list fundAccounts as fa]
        	<tr>
          		<td>${(fa.beginTime)?string("yyyy-MM-dd")}</td>
          		<td>${(fund.no)!}</td>
          		<td>${(fund.name)!}</td>
          		<td>${money(fa.money)}</td>
        	</tr>
        [/#list]
      </table>
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
