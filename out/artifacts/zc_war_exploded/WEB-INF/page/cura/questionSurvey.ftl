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
[#include "/cura/common/userInfo.ftl"]
<style type="text/css">
/*本页样式*/
body{background-color: #f9f9f9;}
</style>
<!-- main s -->
<div class="main"> 
  <!-- queryPage_Left s -->
  <div class="queryPage_Left">
    <ul class="Menu">
      <li><a href="${base}/cura/cust/me.htm">我的投资</a></li>
      <li><a href="${base}/cura/cust/base.htm" class="active">我的账户</a></li>
      <li><a href="${base}/cura/cust/message.htm" >我的消息</a></li>
    </ul>
  </div>
  <!-- queryPage_Left e --> 
  <!-- queryPage_Right s -->
  <div class="queryPage_Right">
    <p class="search_tab_title">
    <a href="${base}/cura/cust/account.htm">账户与安全</a>
    <a href="${base}/cura/cust/base.htm">客户资料</a>
    <a href="${base}/cura/cust/survey.htm" class="active">问卷调查</a></p>
    <div class="wjdc_page">
      <p class="title_1">高端客户服务调查问卷</p>
      <p class="title_2">为了不断提升我们的服务品质，更好的满足您的需要，成为您贴心的财富顾问，请协助我们进行以下内容的了解：</p>
      <form action="" id="qsSubmitForm">
      	<input type="hidden" class="ipt1" name="qsId" value="${qsId}">
      	[#assign ind = 1 /]
      	[#list suveys as s ]
      		<h3 class="Big_title">${s.index}.${s.qsTypeName}</h3>
	        [#list s.topics as t]
	         <h4 class="Small_title">${t.sort}、${t.title}</h4>
	         <ul class="input_wrap" id="tp_${ind}" sid="${s.index}" did="${t.sort}" tid ="${t.type}">
	         	  [#if t.type ==1]
	         	  		[#list t.answers as a]
	         	  			<li><label><input type="radio" name="topic${ind}" value="${t.id}_${a.id}"><i>${a.prefix}、${a.answer} </i></label></li>
	         	  		[/#list]
	         	  [/#if]
	         	  [#if t.type ==2]
	         	  		[#list t.answers as a]
	         	  			<li><label><input type="checkbox" name="topic${ind}" value="${t.id}_${a.id}"><i>${a.prefix}、${a.answer} </i></label></li>
	         	  		[/#list]
	         	  [/#if]
	         	  [#if t.type ==3]
	         	  		<li style="width:100%;">
	         	  			<input type="hidden" name="topicSpan${ind}" value="${t.id}_${a.id}">
	         	  			<textarea name="topic${ind}" style="width:100%;" rows="6" id="topic${ind}"></textarea>
	         	  		</li>
	         	  [/#if]
	          </ul>
	          [#assign ind = ind+1 /]
	        [/#list]
      	[/#list]
        <p class="button_w">
          <button type="button" id="qsSumbitBtn" class="submit">提交</button>
        </p>
      </form>
    </div>
  </div>
  <!-- queryPage_Right e --> 
<script>
	$(function(){
		$("#qsSumbitBtn").on("click",function(){
			var can = true;
      		$("#qsSubmitForm ul[id^='tp_']").each(function(index,ele){
      			var tpid = $(ele).attr("tid");
      			var sind = $(ele).attr("sid");
      			var tind = $(ele).attr("did");
      			if(!!tpid){
      				if(tpid == 1){
      					var v = $(ele).find("input[type='radio']:checked");
		      			if(!v || v.length == 0){
		      				var topics = $(ele).attr("id").replace("tp_","");
		      				alertNotification("提示","第"+sind+"栏第"+tind+"题未填写!","确定");
		      				can = false;
		      				return false;
		      			}
      				}if(tpid == 2){
      					var v = $(ele).find("input[type='checkbox']:checked");
		      			if(!v || v.length == 0){
		      				var topics = $(ele).attr("id").replace("tp_","");
		      				alertNotification("提示","第"+sind+"栏第"+tind+"题未填写!","确定");
		      				can = false;
		      				return false;
		      			}
      				}
      			}
      			
      		});
      		if(!can){
      			return false;
      		}
	      	var params = {};
	  		$.each($("#qsSubmitForm").serializeArray(),function(key,value){
	  			var k = value.name;
	  			var v = value.value;
	  			if(params.hasOwnProperty(k)){
	  				params[k] = params[k]+","+v;
	  			}else{
	  				params[k]=v;
	  			}
	        });
	        console.log(params);
	        submitForm('${base}/cura/cust/survey/add.htm',params,
	        	function(dd){
	        	layer.closeAll();
	        	alertNotification("提示","保存完成!","确定");
	        });
		});
		
	});
	
</script>  
</div>
<!-- main e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>