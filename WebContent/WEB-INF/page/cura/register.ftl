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
<style type="text/css">
/*本页样式*/
body{background-color: #f9f9f9;}
</style>
<!-- register_wrap s -->
<div class="register_wrap">
  <div class="step_top_zc step_1"> <a href="${base}/cura/login.htm" class="a1">已有账号？请直接登录</a>
    <ul>
      <li class="L"><span>1</span></li>
      <li class="M"><span>2</span></li>
      <li class="R"><span>3</span></li>
    </ul>
    <ol>
      <li class="L">合格投资者确认</li>
      <li class="M">手机验证</li>
      <li class="R">完善账户信息，注册完成</li>
    </ol>
  </div>
  <div class="register_box register_box_1">
    <div class="L"><img src="${base}${sysConfig('reg_right_pic')}" width="221" height="499"  alt=""></div>
    <div class="R">
      <form action="">
        <h3 class="title">合格投资者承诺函</h3>
        <div class="txt">
          <p>根据《私募投资基金监督管理暂行办法》第四章第十四条规定："私募基金管理人、私募基金销售机构不得向合格投资者之外的单位和个人募集资金，不得通过报刊、电台、电视、互联网等公众传播媒体或者讲座、报告会、分析会和布告、传单、手机短信、微信、博客和电子邮件等方式，向不特定对象宣传推介。"</p>
          <p>中城投资及联合财富中心谨遵《私募投资基金监督管理暂行办法》之规定，只向特定投资者展示私募基金产品信息，不构成任何投资推介建议。</p>
          <p>您如有意了解私募投资基金且满足《私募投资基金监督管理暂行办法》关于"合规投资者"标准之规定，即：</p>
        </div>
        <ul class="ul">
          <li>
            <input type="checkbox" name="chk" class="ckb" checked>
            <span>具备相应风险识别能力和风险承担能力；</span></li>
          <li>
            <input type="checkbox" name="chk" class="ckb" checked>
            <span>投资于单只私募基金的金额不低于100 万元；</span></li>
          <li>
            <input type="checkbox" name="chk" class="ckb" checked>
            <span>个人金融类资产不低于300万元或者最近三年个人年均收入不低于50万元人民币机构净资产不低于1000万元人民币；</span></li>
        </ul>
        <h5 class="h5">请您详细阅读本提示，并确认为合格投资者，方可进入页面获取私募基金相关展示信息。</h5>
        <p class="button_p">
          <button type="button" id="knowId" class="submit">我知道了</button>
          <input type="checkbox" name="remeberMe" id="rememberMe" class="ckb" checked>
          <span>记住我的选择</span></p>
      </form>
    </div>
  </div>
</div>
<script>
    $(function(){
    	$("#knowId").on("click",function(){
    		var len = $(".ckb:checked").length;
    		if(!len || len != 4 ){
    			alertNotification("提示","请勾选所有选项!");
    			return false;
    		}
    		window.document.location='${base}/cura/reg/two.htm';
    	});
    });
</script>
<!-- register_wrap e --> 
[#include "/cura/common/footer.ftl"]
</body>
</html>