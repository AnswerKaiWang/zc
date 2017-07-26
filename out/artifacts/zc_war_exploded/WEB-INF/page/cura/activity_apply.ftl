<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<meta name="renderer" content="webkit" />
<title>无标题文档</title>
[#include "/cura/common/js.ftl"]
</head>
<body>
<!-- main s -->
<div class="main">
  <div class="w1000"> 
    <!-- expert s -->
    <div class="expert">
      <p class="title">在场专家<span>Present Expert</span></p>
      <ul>
        <li><a href="#">
          <p class="imgtxtbox"><img src="${base}/frontCura/images/zj.jpg" width="200" height="230" alt=""><i></i><span class="txt">于北京成功举办,上海中城联盟投资管理股份有限公司总裁。上海中城联盟投资管理股份有限公司总裁。</span></p>
          <strong>严畅</strong><b>博士&nbsp;&nbsp;海外教育专家</b></a></li>
        <li><a href="#">
          <p class="imgtxtbox"><img src="${base}/frontCura/images/zj.jpg" width="200" height="230" alt=""><i></i><span class="txt">于北京成功举办,上海中城联盟投资管理股份有限公司总裁。上海中城联盟投资管理股份有限公司总裁。</span></p>
          <strong>严畅</strong><b>博士&nbsp;&nbsp;海外教育专家</b></a></li>
        <li><a href="#">
          <p class="imgtxtbox"><img src="${base}/frontCura/images/zj.jpg" width="200" height="230" alt=""><i></i><span class="txt">于北京成功举办,上海中城联盟投资管理股份有限公司总裁。上海中城联盟投资管理股份有限公司总裁。</span></p>
          <strong>严畅</strong><b>博士&nbsp;&nbsp;海外教育专家</b></a></li>
        <li><a href="#">
          <p class="imgtxtbox"><img src="${base}/frontCura/images/zj.jpg" width="200" height="230" alt=""><i></i><span class="txt">于北京成功举办,上海中城联盟投资管理股份有限公司总裁。上海中城联盟投资管理股份有限公司总裁。</span></p>
          <strong>严畅</strong><b>博士&nbsp;&nbsp;海外教育专家</b></a></li>
      </ul>
    </div>
    <p class="bottom_bj"><span class="bj_L"></span><span class="bj_R"></span></p>
    <a href="javascript:void(0);" class="a_sign" id="a_sign">活动报名</a> 
    <!-- expert e --> 
  </div>
</div>
<!-- main e --> 
<!-- 活动报名弹窗 s -->
<div class="sign_popup">
  <p class="title">活动报名<span>感谢报名，我们会尽快联系您</span></p>
  <form action="">
    <ul>
      <li>
        <label>姓名：</label>
        <span class="placeholder_wrap"><input type="text" class="ipt1" placeholder="请输入姓名"></span>
      </li>
      <li>
        <label>电话：</label>
        <span class="placeholder_wrap"><input type="text" class="ipt1" placeholder="请输入电话号码"></span>
      </li>
      <li>
        <label>人数：</label>
        <span class="placeholder_wrap"><input type="text" class="ipt1" placeholder="请输入您参加活动的人数"></span>
      </li>
      <li>
        <input type="submit" class="submit" value="我要参加">
      </li>
    </ul>
  </form>
</div>
<!-- 活动报名弹窗 e --> 
<!-- 预约成功弹窗 s -->
<div class="bookingfinish_popup">
  <p class="title">预约成功</p>
  <p class="txt">财富顾问会在下个工作日内与您联系</p>
  <p class="y_button"><a href="javascript:void(0);" class="a1 close_bookingfinish_popup">完成预约</a><a href="#" class="a2">预约查询</a></p>
</div>
<!-- 预约成功弹窗 e --> 
<script type="text/javascript" src="${base}/frontCura/js/placeholder.min.js"></script> 
<script type="text/javascript">
//placeholder
$(document).ready(function(){
  $('input[placeholder], textarea[placeholder]').each(function(){
    $(this).is('input')?$(this).iePlaceholder():$(this).iePlaceholder({onInput: false});
  });
});
</script>
<link type="text/css" rel="stylesheet" href="${base}/frontCura/style/layer.css" />
<script type="text/javascript" src="${base}/frontCura/js/layer.js"></script> 
<script type="text/javascript">
$(function(){
	$('#a_sign').on('click', function(){
		layer.open({
		  type: 1,
		  title: false,
		  closeBtn:2,
		  area : ['auto' , 'auto'],
		  shadeClose :true,
		  content: $('.sign_popup')//弹出活动报名弹窗
		}); 
	});
	
	
		layer.open({
		  type: 1,
		  title: false,
		  closeBtn:2,
		  area : ['auto' , 'auto'],
		  shadeClose :true,
		  content: $('.bookingfinish_popup')//弹出预约成功弹窗
		}); 
		
	//确定预约按钮(关闭弹窗)	
	$('.close_bookingfinish_popup').on('click', function(){
		layer.closeAll();
	});
		
});
</script>
<!-- 返回顶部 s --> 
<a href="javascript:void(0);" id="back_top"><i class="ico ico-shangjiantou"></i><span>返回顶部</span></a> 
<!-- 返回顶部 e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>