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
<!-- banner s -->
<div class="banner"></div>
<!-- banner e --> 
<!-- wqhd_1 s -->
<div class="wqhd_1">
  <div class="w1000">
    <p class="wqhd_ty_title">现场报道<i>reports</i></p>
    <dl class="DL">
      <dt><a href="###"><img src="${base}${activity.agoCover}" width="468" height="148" alt=""></a></dt>
      <dd>
        <h3 class="h3"><span>${activity.agoTitle}</span><i>${activity.agoDate}</i></h3>
        <p class="P"> ${activity.liveReport} </p>
      </dd>
    </dl>
  </div>
</div>
<!-- wqhd_1 e --> 
<!-- wqhd_2 s -->
<div class="wqhd_2">
  <div class="w1000">
    <p class="wqhd_ty_title">嘉宾介绍<i>The guest</i></p>
    <div class="ul_w_picScroll_L">
      <div class="hd"> <a href="javascript:void(0);" class="next"><i class="ico ico-you"></i></a> <a href="javascript:void(0);" class="prev"><i class="ico ico-zu"></i></a></div>
      <div class="bd">
        <ul>
        	[#list activity.guests as g]
          	<li><a href="###" class="abox"><img src="${base}${g.avatar}" alt=""><i class="bj"></i>
          	<span class="txt"><i>${g.brief}</i></span></a>
            <h3>${g.name}</h3>
            <h4>${g.actor}</h4>
            </li>
        	[/#list]
        </ul>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript" src="${base}/frontCura/js/jquery.SuperSlide.2.1.1.js"></script>
<script type="text/javascript">
  jQuery(".ul_w_picScroll_L").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"leftLoop",scroll:4,vis:4});  
</script> 
<!-- wqhd_2 e --> 
<!-- wqhd_3 s -->
<div class="wqhd_3">
  <div class="w1000">
    <p class="wqhd_ty_title">现场集锦<i>highlights</i></p>
    <div class="picFocus">
      <div class="M">
        <div class="bd">
          <ul>
          	[#list activity.leftFiles as g]
          		<li><a href="###"><img src="${base}${g.path}" width="554" height="354" alt=""></a></li>
          	[/#list]
            [#list activity.rightFiles as g]
          		<li><a href="###"><img src="${base}${g.path}" width="554" height="354" alt=""></a></li>
          	[/#list]
          </ul>
        </div>
      </div>
      <div class="hd">
        <ul class="ul_L">
          [#list activity.leftFiles as g]
          		<li><a href="###"><img src="${base}${g.path}" width="184" height="100" alt=""></a></li>
          	[/#list]
        </ul>
        <ul class="ul_R">
        	 [#list activity.rightFiles as g]
          		<li><a href="###"><img src="${base}${g.path}" width="184" height="100" alt=""></a></li>
          	[/#list]
        </ul>
      </div>
    </div>
    <script  type="text/javascript" src="${base}/frontCura/js/jquery.SuperSlide.2.1.1.js"></script> 
    <script type="text/javascript">
	jQuery(".picFocus").slide({ mainCell:".bd ul",effect:"top",autoPlay:true,delayTime:300,
	startFun:function(i,c){
        $(".picFocus").find('ol').find('li').removeClass('active')
        $(".picFocus").find('ol').find('li').eq(i).addClass('active')
    }
	 });
    </script> 
  </div>
</div>
<!-- wqhd_3 e --> 
<!-- wqhd_4 s -->
<div class="wqhd_4">
  <div class="w1000">
    <p class="wqhd_ty_title">视频回顾<i>video</i></p>
    <div class="CT">
      <ul>
      	[#list activity.videos as g]
      		<li><a href="###"><img src="${base}/frontCura/images/wq.jpg" alt="">
      		<i class="bj"></i>
      			<video src="${base}${g.path}" controls="controls">
您的浏览器不支持 video 标签。
</video>
         	 <p class="v_title">${g.actTime}&nbsp;&nbsp;${g.name}</p>
          	 </a>
          	</li>
      	[/#list]
      </ul>
    </div>
  </div>
</div>
<!-- wqhd_4 e --> 
<!-- wqhd_5 s -->
<div class="wqhd_5">
  <div class="w1000">
    <p class="wqhd_ty_title">文件分享<i>File sharing</i></p>
    <ul>
    		[#list activity.files as f]
            <li>
        		<p><span class="fl">${activity.startTime}</span><span class="fr"><a href="${base}${f.avatar}" target="_blank">查看</a></span></p>
        		<h3><a href="#">${f.name}</a></h3>
      		</li>
        	[/#list]
    </ul>
  </div>
</div>
<!-- wqhd_5 e -->
<div class="wrap">
  <dl class="disclaimer">
    <dt>免责声明</dt>
    <dd>
      <p>1、本网站信息均来源于市场公开资料，中城仅基于上述公开资料阐述中城观点，并不保证其准确性、完整性、实时性或正确性。本网站的信息和内容仅供参考，请谨慎使用。</p>
      <p>2、本网站信息中署名"中城投资"、"中城联合财富"的文章，以及图片和音视频资料，版权均属于中城投资及联合财富中心所有。如需转载请与中城联合财富联系，并在授权的范围内注明来源和作者保证作品的完整性。违反上述声明者，本网站将追究相关法律责任。</p>
      <p>3、本网站转载其他媒体或机构的作品，并不意味赞同其观点或证实其内容的真实性。如其他媒体、网站或个人从本网下载使用，必须保留本网注明的"来源"，并自负版权等法律责任。</p>
    </dd>
  </dl>
</div>
<!-- 返回顶部 s --> 
<a href="javascript:void(0);" id="back_top"><i class="ico ico-shangjiantou"></i><span>返回顶部</span></a> 
<!-- 返回顶部 e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>