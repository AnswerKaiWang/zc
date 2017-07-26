﻿<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>帮助中心-[@coAttr name="webSiteName"]${companyAttr.contant}[/@coAttr]</title>
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
[#include "/web/common/header.ftl"/]
<div class="Mt"></div>
<div class="position_title">
	<div class="wrap"><span>帮助中心</span><a href="${base}/index.htm">首页</a>/<a href="#" class="active">帮助中心</a></div>
</div>
<!-- main s -->
<div class="main">
	<div class="hesp_tab_title" id="hesp_tab_title">
	[#list types as ty]
	<a href="${base}/help.htm?type=${ty?url}" [#if type??&&type==ty]class="active"[/#if]>${ty}</a>
	[/#list]
	</div>
    <div class="hesp_tab_show xsbd">
    	[#list helps as he]
      <dl>
        <dt><i>${(he_index)?string("00")}</i>${(he.name)!}</dt>
        <dd>${(he.value)!}</dd>
      </dl>
      [/#list]
    </div>
</div>
<!-- main e --> 
</div>
<script> 

</script> 
<!-- footer s -->
[#include "/web/common/footer.ftl"/]
<!-- footer e -->
</body>
</html>
