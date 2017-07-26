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
  <div class="step_top_zc step_3"> <a href="${base}/cura/login.htm" class="a1">已有账号？请直接登录</a>
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
  <div class="register_box register_box_3">
    <p class="welcome_registration">欢迎注册</p>
    <form action="" id="regThreeForm"> 
     <ul class="ul">
        <li><label>客户姓名：</label><span class="sp"><input type="text" name="name" id="regName" onblur="javascript:checkCnAndChar('regName');" class="ipt1" placeholder="中文/拼音"></span></li>
        <li><label>客户性别：</label><span class="sex_sp">
        	<input type="radio" name="gender" value=1 checked>先生
        	<input type="radio" name="gender" value=0 id="gender">女士</span></li>
        <li><label>所在城市：</label>
          <select name="city" id="city" class="ipt1">
            	<option value="">请选择所在城市</option>
	        	[@dict name="city" ]
	        	[#list dictList as st]
	        		<option value="${st.id}" [#if st.id=='${loginSuccessKey.cityId}']selected=selected[/#if]>${st.name}</option>
	        	[/#list]
	        	[/@dict]
          </select>
        </li>
        <li><label>电子邮件：</label><span class="sp"><input type="text" name="email" id="regEmail" onblur="javascript:checkEmail('regEmail');" class="ipt1" placeholder="请输入邮箱地址"></span></li>
        <li style="width: 100%;"><label>通讯地址：</label><span class="sp"><input type="text" name="address" style="width: 628px;" id="address" class="ipt1" placeholder="请输入地址信息"></span></li>
      </ul>
      <button type="button" class="submit" id="regThreeBtn">注册完成</button>
    </form>    
  </div>
</div>
<link type="text/css" rel="stylesheet" href="${base}/frontCura/style/dahong.css" />
<script type="text/javascript"  src="${base}/frontCura/js/easydropdown.min.js"></script>
  <script type="text/javascript">
  !function(){
    	//laydate.skin('molv');
    	laydate({elem: '#date_a'});      
  }();
  </script>
<!-- register_wrap e --> 
<script type="text/javascript" src="${base}/frontCura/js/placeholder.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
  $('input[placeholder], textarea[placeholder]').each(function(){
    $(this).is('input')?$(this).iePlaceholder():$(this).iePlaceholder({onInput: false});
  });
  $("#regThreeBtn").on("click",function(){
  		$(this).css("disabled","disabled");
  		var params = {};
  		$.each($("#regThreeForm").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        });
  		$.ajax({
  			url: '${base}/cura/reg/checkThree.htm',
  			type:"POST",
  			dataType:"json",
  			data: params,
  			success:function(data){
  				if(!!data){
  					if(data.code == '00'){//跳转到基金产品
  						toProduct('${base}');
  					}else{
  						alertNotification("提示",data.message,"确定");
  					}
  				}
  			}
  		});
  });
});
</script> 
[#include "/cura/common/footer.ftl"]
</body>
</html>