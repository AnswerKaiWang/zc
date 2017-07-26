<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>首页-[@coAttr name="webSiteName" /]</title>
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
[#assign currentPage="index" /]
[#include "/web/common/header.ftl"/]
<!-- slides s -->
<div class="slides">
  <div class="hd"></div>
  <div class="bd">
      <ul>
      		[@coAttr name="firstPic1,firstPic2,firstPic3,firstPic4,firstPic5,firstPic6,firstPic7,firstPic8" type="xx"]
      			[#list companyAttr as fp]
      			[#if (fp.contant)??]
      			<li><a href="${(firstPicHrefs[fp_index].contant)!"#"}" target="_blank"><img src="${base}${(fp.contant)!}" class="img-responsive"></a></li>
      			[/#if]
      			[/#list]
      		[/@coAttr]
      </ul>
  </div>
  <div class="butwrap"><a class="prev" href="javascript:void(0)"></a><a class="next" href="javascript:void(0)"></a></div>
</div>
<script type="text/javascript" src="${base}/front/js/jquery.SuperSlide.2.1.1.js"></script>
<script type="text/javascript">
	$('.hd').append("<i></i><span></span>")
   jQuery(".slides").slide({mainCell:".bd ul",effect:"fade",autoPlay:true,trigger:"click",interTime:3000,mouseOverStop:"false",
		startFun:function(i,c){
			$('.hd').find('i').text("0"+(i+1));
			$('.hd').find('span').text("/0"+c);
		}
   });
</script>
<!-- slides e --> 
[#include "/web/common/footer.ftl"/]
</body>
</html>
