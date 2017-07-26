<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<meta name="renderer" content="webkit" />
<title>中城投资</title>
[#include "/cura/common/js.ftl"]
</head>
<body>
[#include "/cura/common/header.ftl"]
[#include "/cura/common/caifu.ftl"]
<!-- header e -->
<!-- banner_2 s -->
<div class="banner_2"><img src="${base}/frontCura/images/banner_2.jpg" alt=""></div>
<!-- banner_2 e -->
<!-- main s -->
<div class="main">
  <div class="w1000">
  	<!-- introduction s -->
    <div class="introduction">
    	<h3 class="h3"><span><em> ${activity.title}</em></span>活动介绍</h3>
      <p class="title"><span class="j_sp">${activity.subhead}</span></p>
      <div class="txt">
       	${activity.content}
      </div>
    </div>
    <p class="bottom_bj"><span class="bj_L"></span><span class="bj_R"></span></p>
  	<!-- introduction e --> 
  	<!-- Highlights s -->
    <div class="Highlights">
      <p class="title">活动亮点<span>Highlights</span></p>
      <div class="list_w">
        ${activity.lightspot}
      </div>
    </div>
    <p class="bottom_bj"><span class="bj_L"></span><span class="bj_R"></span></p>
  	<!-- Highlights e --> 
  	<!-- Arrangement s -->
    <div class="Arrangement">
      <p class="title">活动议程<span>The Arrangement</span></p>
      ${activity.agenda}
    </div>
    <p class="bottom_bj"><span class="bj_L"></span><span class="bj_R"></span></p>
  	<!-- Arrangement e --> 
    <!-- expert s -->
    <div class="expert">
      <p class="title">活动嘉宾<span>Present Expert</span></p>
      <ul>
      	[#list activity.guests as g]
        <li><a href="#">
          <p class="imgtxtbox"><img src="${base}${g.avatar}" width="200" height="230" alt=""><i></i><span class="txt">${g.brief}</span></p>
          <strong>${g.name}</strong><b>${g.education}&nbsp;&nbsp;${g.actor}</b></a></li>
        [/#list]
      </ul>
    </div>
    <p class="bottom_bj"><span class="bj_L"></span><span class="bj_R"></span></p>
    <a href="javascript:void(0);" class="a_sign" id="a_sign" onclick="javascript:openApply('${activity.id}');">活动报名</a> 
    <!-- expert e --> 
  </div>
</div>
<!-- main e --> 
[#include "/cura/common/apply.ftl"]
<!-- 返回顶部 s --> 
<a href="javascript:void(0);" id="back_top"><i class="ico ico-shangjiantou"></i><span>返回顶部</span></a> 
<!-- 返回顶部 e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>