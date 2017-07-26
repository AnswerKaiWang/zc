<!-- 风险测评封装 -->
<!-- 产品评测弹窗-2 s -->
<div class="cppc_popup_2">
  <p class="title"><span>私募基金投资者风险调查问卷（[#if loginSuccessKey.userType=='geren']个人[/#if][#if loginSuccessKey.userType=='qiye']机构[/#if]投资者使用）</span></p>
  <form action="" id="riskEvaluationForm">
    <ul class="UL_1">
      <li>
        <label>投资者姓名：</label>
        <span class="placeholder_wrap">
        <input type="text" class="ipt1" name="custName" readOnly id="custName" placeholder="" value="${name}">
        </span> </li>
      <li>
        <label>联系方式：</label>
        <span class="placeholder_wrap">
        <input type="text" class="ipt1" name="link" id="link" readOnly placeholder="" value="${loginSuccessKey.phone}">
        </span> </li>
      <li>
        <label>证件类型：</label>
        <span class="placeholder_wrap">
	        <input class="ipt1" name="cardType" id="cardType" 
	            [@dict name="perCardType" ]
	        	[#list dictList as st]
	        		[#if loginSuccessKey.cardTypeId == st.id]
	        			value = "${st.name}"
	        		[/#if]
	        	[/#list]
	        	[/@dict]
	        	>
        </span>
      </li>
      <li>
        <label>证件号码：</label>
        <span class="placeholder_wrap">
        <input type="text" class="ipt1" name="cardNo" id="cardNo" readOnly value="${loginSuccessKey.cardNo}" placeholder="">
        </span> 
      </li>
      <li>
        <label>填写日期：</label>
        <span class="placeholder_wrap">
        <input type="text" class="ipt1" name="evalTime" readOnly id="evalTime" placeholder="">
        </span> 
      </li>
    </ul>
    <div class="txt_1"><b>风险提示：</b>私募基金投资需承担各类风险，本金可能遭受损失。同时，私募基金投资还要考虑市场风险、信用风险、流动性风险、操作风险等各类投资风险。您在基金认购过程中应当注意核对自己的风险识别和风险承受能力，选择与自己风险识别能力和风险承受能力相匹配的私募基金。
      以下一系列问题可在您选择合适的私募基金前，协助评估风险承受能力、理财方式及投资目标。
      符合金融资产不低于300万元人民币（金融资产包括银行存款、股票、债券、基金份额、资产管理计划、银行理财产品、信托计划、保险产品、期货权益等）</div>
    <div class="Middle_scroll" id="Middle_scroll">
      [#list titles as t]
      	  <h3 class="Big_title">${t.index}.${t.title}</h3>
      	  [#list t.subjects as s]
	      <h4 class="Small_title">${s.sort}、${s.subject}</h4>
	      <ul class="input_wrap" id="tp_${s.sort}">
	      	 [#list s.answers as a]
	        	<li><label><input type="radio" name="topic${s.sort}" value="${s.qeId}_${a.qaId}" ><i>${a.prefix}、${a.answer}</i></label></li>
	         [/#list]
	      </ul>
	      [/#list]
      [/#list]
    </div>
    <div class="txt_2">重要申明：<br>
      投资者应购买与其风险偏好相适应的产品。本风险调查问卷旨在协助投资者了解自身对投资风险的承受能力，为保护合法权益，请真实、准确、完整地填写本问卷。如因存在欺诈、隐瞒或其它不实、遗漏陈述而导致调查结果与实际情况不符的，本公司不承担任何责任，由投资者自行承担相应后果。 </div>
    <p class="button_w">
      <button type="button" id="evaluationSubmitBtn" class="submit">提交</button>
    </p>
  </form>
</div>
<!-- 产品评测弹窗-1 s -->
<div class="cppc_popup_1">
  <p class="title">您的风险评级：<b id="riskBear"></b> </p>
  <p class="txt">本产品属于<span class="pink" id="riskLevel"></span><span id="riskNotify"></span></p>
  <p class="y_button"><a href="javascript:void(0);" class="a1 close_bookingfinish_popup">继续测评</a></p>
</div>
<!-- 产品评测弹窗-1 e -->
<link rel="stylesheet" href="${base}/frontCura/style/mCustomScrollbar.css">
<script src="${base}/frontCura/js/mCustomScrollbar.concat.min.js"></script>
<script> 
$(function(){
	$('#show_cppc_popup_2').on('click', function(){
		layer.open({
		  type: 1,
		  title: false,
		  closeBtn:2,
		  area : ['auto' , 'auto'],
		  offset: ['20px'],
		  shadeClose :true,
		  fix: false,
		  content: $('.cppc_popup_2')//弹出产品评测弹窗-2
		}); 
	});
	//继续测评按钮(关闭弹窗)	
	$('.close_bookingfinish_popup').on('click', function(){
		layer.closeAll();
		layer.open({
		  type: 1,
		  title: false,
		  closeBtn:2,
		  area : ['auto' , 'auto'],
		  offset: ['20px'],
		  shadeClose :true,
		  fix: false,
		  content: $('.cppc_popup_2')//弹出产品评测弹窗-2
		}); 
	});
	
	$("#evalTime").val(getNow());
});
</script> 
<script>
	//滚动条
    (function($){
      $(window).on("load",function(){        
        $("#Middle_scroll").mCustomScrollbar();
      });
      $("#evaluationSubmitBtn").on("click",function(){
      		var can = true;
      		$("ul[id^='tp_']").each(function(index,ele){
      			var v = $(ele).find("input[type='radio']:checked");
      			if(!v || v.length == 0){
      				var topics = $(ele).attr("id").replace("tp_","");
      				alertNotification("提示","第"+topics+"题未填写!","确定");
      				can = false;
      				return false;
      			}
      		});
      		if(!can){
      			return false;
      		}
	      	var params = {};
	  		$.each($("#riskEvaluationForm").serializeArray(),function(key,value){
	        		params[value.name]=value.value;
	        });
	        submitForm('${base}/cura/fund/risk/evaluation.htm',params,
	        	function(dd){
	        	layer.closeAll();
	        	alertNotification("提示","测评完成!","确定",function(){
	        		//测评完成弹出提示框
	        		layer.open({
					  type: 1,
					  title: false,
					  closeBtn:2,
					  area : ['400px' , '300px'],
					  shadeClose :true,
					  content: $('.cppc_popup_1')//弹出产品评测弹窗-1
					  ,
					  success:function(layero,index){
					  	$("#riskLevel").text(dd.data.riskLevel);
					  	$("#riskBear").text(dd.data.riskBear);
					  	$("#riskNotify").text(dd.data.riskNotify);
					  }
					}); 
	        		//window.location.reload();
	        	});
	        });
      });
    })(jQuery);
</script>