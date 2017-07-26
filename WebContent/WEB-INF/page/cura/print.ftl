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
<div class="cppc_popup_2" style="display:block;height:auto;overflow:visible;">
<!-- 产品评测弹窗-2 s -->
  <p class="title"><span>私募基金投资者风险调查问卷（个人投资者使用）</span></p>
  <form action="" id="riskEvaluationForm">
    <ul class="UL_1">
      <li>
        <label>投资者姓名：</label>
        <span class="placeholder_wrap">
        <input type="text" class="ipt1" name="custName" readOnly id="custName" placeholder="" value="${name}">
        </span> </li>
      <li>
        <label>证件类型：</label>
        <span class="placeholder_wrap">
	        <select class="ipt1" name="cardType" id="cardType">
	            [@dict name="perCardType" ]
	        	[#list dictList as st]
	        		[#if loginSuccessKey.cardTypeId == st.id]
	        			<option value="${st.id}">${st.name}</option>
	        		[/#if]
	        	[/#list]
	        	[/@dict]
			 </select>
        </span>
      </li>
      <li>
        <label>证件号码：</label>
        <span class="placeholder_wrap">
        <input type="text" class="ipt1" name="cardNo" id="cardNo" readOnly value="${loginSuccessKey.cardNo}" placeholder="">
        </span> </li>
      <li>
        <label>联系方式：</label>
        <span class="placeholder_wrap">
        <input type="text" class="ipt1" name="link" id="link" readOnly placeholder="" value="${loginSuccessKey.addr}">
        </span> </li>
      <li>
        <label>填写日期：</label>
        <span class="placeholder_wrap">
        <input type="text" class="ipt1" name="evalTime" readOnly id="evalTime" placeholder="">
        </span> </li>
    </ul>
    <div class="txt_1"><b>风险提示：</b>私募基金投资需承担各类风险，本金可能遭受损失。同时，私募基金投资还要考虑市场风险、信用风险、流动性风险、操作风险等各类投资风险。您在基金认购过程中应当注意核对自己的风险识别和风险承受能力，选择与自己风险识别能力和风险承受能力相匹配的私募基金。
      以下一系列问题可在您选择合适的私募基金前，协助评估风险承受能力、理财方式及投资目标。
      符合金融资产不低于300万元人民币（金融资产包括银行存款、股票、债券、基金份额、资产管理计划、银行理财产品、信托计划、保险产品、期货权益等）</div>
    <div class="Middle_scroll" id="Middle_scroll" style="display:block;height:auto;overflow:visible;">
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
  </form>
  </div>
<script> 
$(function(){
	$(".cppc_popup_2").printArea();
});
</script>
</body>
</html>