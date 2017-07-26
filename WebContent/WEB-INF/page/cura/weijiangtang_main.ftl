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
<div class="banner"></div>
<!-- banner e -->
<style type="text/css">
/*本页样式*/
body{background-color: #f9f9f9;}
</style>
<!-- main s -->
<div class="main">
  <p class="ty_title"><span>市场活动/<i>ACTIVITIES</i></span></p>
  <p class="wjt_tab_title"><a href="${base}/cura/activity/ago.htm">往期回顾</a><a href="${base}/cura/lecture/main.htm" class="active">微讲堂</a></p>
  <div class="wjt_Left">
    <dl class="wl_t_dl">
      <dt><img src="${base}/frontCura/images/gg.jpg" alt="" width="222" height="202"></dt>
      <dd>
        <h3>${lecture.title}</h3>
        <h4>最后更新: ${lecture.lastestTime}</h4>
        <h5><span id="playNum">${lecture.vedios[0].playNum}</span>次播放</h5>
        <div class="bdsharebuttonbox bdsharebuttonbox_style_2"><i class="jiao"></i><a class="aa">分享到：</a>
        	<a href="#" class="bds_more" data-cmd="more"></a>
        	<a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
        	<a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
        	<a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a>
        	<a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a></div>
      </dd>
    </dl>
    <dl class="dl_audio jp-audio" role="application" aria-label="media player" id="jp_container_1">
      <dt><a href="javascript:void(0);" class="jp-play ico ico-play" data-describe="播放/暂停键"></a></dt>
      <dd>
        <div class="p_title"><span class="fl lti">${lecture.vedios[0].name}</span><span class="fr">
        <i  class="jp-current-time" role="timer" aria-label="time"  data-describe="实时播放长度"></i>/<i class="jp-duration" role="timer" aria-label="duration" data-describe="音频长度"></i></span></div>
        <div class="p_speed jp-progress" data-describe="播放进度条" >
          <div class="jp-seek-bar">
            <div class="jp-play-bar"></div>
          </div>
        </div>
        <div class="share_quantity">
          <div class="control_keys_wrap"> <a href="javascript:void(0);" class="jp-stop ico ico-tingzhi fl" data-describe="停止播放键"></a>
          <a href="javascript:void(0);" class="jp-repeat ico ico-circulation fl"  data-describe="循环播放键" title=""></a>
            <div class="jp-volume-controls"> <a href="javascript:void(0);" class="fl jp-mute ico ico-yl-1"  data-describe="静音键"></a>
              <div class="jp-volume-bar"  data-describe="音量进度条">
                <div class="jp-volume-bar-value"></div>
              </div>
              <a href="javascript:void(0);" class="fr jp-volume-max ico ico-yl-2"  data-describe="最大音量键"></a> </div>
          </div>
          <span class="dz"><i class="ico ico-heart-o"></i>${lecture.vedios[0].favorNum}</span><span class="fx"><i class="ico ico-fenxiang"></i>${lecture.vedios[0].shareNum}</span></div>
      </dd>
    </dl>
    <style type="text/css">
	.control_keys_wrap{float: left;display: none;}
 	.control_keys_wrap .ico{font-size: 15px;color: #b9b9b9;}
	.ico.jp-stop{font-size: 20px;float: left;vertical-align: middle;margin-top: -2px;}
	.ico.jp-stop.active{color: #EF6D39;}
	.ico.jp-repeat{font-size: 20px;float: left;vertical-align: middle;margin-top: -2px;margin-left: 15px;}
	.ico.jp-repeat.active{color: #EF6D39;}
    .jp-volume-controls{height: 20px;width: 160px;float: left;margin-left: 15px;}
    .jp-volume-controls .ico{margin-top: 2px;}
	.ico.ico-yl-5{color: #EF6D39;}
	.ico.jp-volume-max.active{color: #EF6D39;}
	.jp-volume-bar{background-color: #e2e2e2;height: 7px;width: 100px;margin:6px auto 0px;float: left;margin-left:10px;cursor: pointer;}
	.jp-volume-bar{background-color: #e2e2e2;height: 7px;width: 100px;}
	.jp-volume-bar-value{background-color: #EF6D39;height: 100%;}
    </style>
    <script  type="text/javascript" src="${base}/frontCura/js/jquery-1.9.1.min.js"></script> 
    <script type="text/javascript" src="${base}/frontCura/js/jquery.jplayer.min.js"></script>
    <div id="jquery_jplayer_1" class="jp-jplayer" style="width: 0px; height: 0px;"></div>
    <script type="text/javascript">
    $(document).ready(function(){
    	initPlay("${lecture.vedios[0].path}");
    });
    function initPlay(source){
    	$("#jquery_jplayer_1").jPlayer({
            ready: function (event) {
                $(this).jPlayer("setMedia", {
                    m4a: "${base}"+source,//音频文件地址
                    oga: "${base}"+source
                });
            },
            swfPath: "audio/jplayer",
            supplied: "m4a, oga",
            wmode: "window",
            useStateClassSkin: true,
            autoBlur: false,
            smoothPlayBar: true,
            keyEnabled: true,
            remainingDuration: false,
            toggleDuration: true,
			 ended: function() {  
					$('.jp-play').addClass('ico-play').removeClass('ico-pause');  
                }  
        });
		//-------------样式-------------
	  	//--播放/暂停键
		$(".jp-play").click(function(){
			  if($('#jp_container_1').hasClass('jp-state-playing')){
			  $('.jp-play').addClass('ico-play').removeClass('ico-pause');
			}else{
			  $('.jp-play').removeClass('ico-play').addClass('ico-pause');
			  $(".jp-stop").removeClass('active')
			}
		});
		
			//--停止键
			$(".jp-stop").click(function(){
			  $(".jp-stop").addClass('active')
			if($('#jp_container_1').hasClass('jp-state-playing')){
			  $(".jp-stop").addClass('active')
			  $('.jp-play').addClass('ico-play').removeClass('ico-pause')
			  };
			});
		//--静音键
		$(".jp-mute").click(function(){
			if($('.jp-mute').hasClass('ico-yl-1')){
			  $('.jp-mute').removeClass('ico-yl-1').addClass('ico-yl-5');
			  $(".jp-volume-max").removeClass('active');
			}else{
			  $('.jp-mute').removeClass('ico-yl-5').addClass('ico-yl-1');
			};
		});
		//--最大音量键
		$(".jp-volume-max").click(function(){
		  $('.jp-mute').removeClass('ico-yl-5').addClass('ico-yl-1');
		  $(".jp-volume-max").addClass('active');
		});
		
		//--音量进度条键
		$('.jp-volume-bar').click(function(){
		  $('.jp-mute').removeClass('ico-yl-5').addClass('ico-yl-1');
		  $(".jp-volume-max").removeClass('active');
		});
		//--循环播放键
		$('.jp-repeat').click(function(){
			$(this).toggleClass('active');
		});
    }
    function resetPlayUrl(self){
    	var p = $(self).attr("durl");
    	var dpn = $(self).attr("dpn");//播放次数
    	var dfn = $(self).attr("dfn");//点赞次数
    	var dsn = $(self).attr("dsn");//分享次数
    	$("#jquery_jplayer_1").jPlayer("destroy");
    	initPlay(p);
    	$("#playNum").text(dpn);
    	$("#jquery_jplayer_1").jPlayer("load");
    	$("#jquery_jplayer_1").jPlayer("stop");
    	$(".jp-stop").click();
    	$(".jp-play").click();
    	$("#jquery_jplayer_1").jPlayer("play");
    }
    </script> 
    <p class="zj_title">专辑里的声音</p>
    <ul class="zj_list">
      [#list lecture.vedios as v]
      	<li> <a href="javascript:void(0);" onclick="javascript:resetPlayUrl(this);" class="al fl" durl="${v.path}" dpn="${v.playNum}" dfn="${v.favorNum}" dsn="${v.shareNum}">
      		<i class="ico ico-play"></i>
      		<span>${v.name}</span></a> <span class="fr rsp"><em>${(v.createTime).substring(0,10)}</em><i class="ico ico-fenxiang"></i></span> </li>
      [/#list]
    </ul>
    <!-- 分享代码 s -->
    <div class="bdsharebuttonbox bdsharebuttonbox_style_1"><i class="jiao"></i><a class="aa">分享到：</a><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a></div>
    <script type="text/javascript">
    window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"24"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
    </script> 
    <!-- 分享代码 e --> 
  </div>
  <div class="wjt_Right">
    <p class="zjtj_title">专辑推荐</p>
    [#list recs as rec]
    <dl class="zjtj_list">
      <dt><a href="#"><img src="${base}${rec.cover}" alt="" width="84" height="84"></a>
        <p class="bj"><span></span></p>
      </dt>
      <dd>
        <h3><a href="${base}/cura/lecture/detail.htm?id=${rec.id}">${rec.title}</a></h3>
        <h4>${rec.fileNum}个声音</h4>
      </dd>
    </dl>
    [/#list]
  </div>
  <p class="clear"></p>
</div>
<!-- main e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>