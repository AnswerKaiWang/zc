<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>安全保障-[@coAttr name="webSiteName" /]</title>
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
	<div class="wrap"><span>安全保障</span><a href="${base}/index.htm">首页</a>/<a href="${base}/security.htm" class="active">安全保障</a></div>
</div>
<!-- main s -->
<div class="tzaq">
  <div class="wrap">
    <div class="imgb fl"><img src="${base}/front/images/nse.jpg" alt=""></div>
    <div class="txtb fr">
      <p class="ty_inner_title"><span>投资安全</span><i>INVESTMENT SECURITY</i></p>
      <div class="tx">
      	[@coAttr name="companySecurityCon1" /]
      </div>
    </div>
  </div>
</div>
<div class="zjaq">
  <div class="wrap">
    <div class="imgb fr"><img src="${base}/front/images/nse-02.jpg" alt=""></div>
    <div class="txtb fl">
      <p class="ty_inner_title"><span>资金安全</span><i>CAPITAL SECURITY</i></p>
      <div class="tx">
      [@coAttr name="companySecurityCon2" /]
      </div>
    </div>
  </div>
</div>
<div class="hfhg">
  <div class="wrap">
    <p class="ty_inner_title"><span>合法合规</span><i>LEGAL COMPLIANCE</i></p>
    <div class="tx"> 
    [@coAttr name="companySecurityCon3" /]
     </div>
  </div>
</div>
<!-- main e --> 
[#include "/web/common/footer.ftl"/]
<a href="javascript:void(0);" title="返回顶部" id="backtop"><img src="${base}/front/images/j1_03.png" width="45" height="45" alt=""></a>
</body>
</html>
