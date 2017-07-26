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
<!-- main s -->
<div class="main">
  <p class="product_details_title"><span>${fund.seriesName}</span></p>
  <!-- product_details_Left s -->
  <div class="product_details_Left">
    <div class="product_txt_t">
      <p class="title">${fund.name}<span>（基金备案号－${fund.beiNo}）</span></p>
      <ul class="ul">
        <li>产品规模：${fund.size}</li>
        <li>产品期限：${fund.deadline}</li>
        <li>产品状态：${fund.statusName}</li>
        <li>产品类别：${fund.type}</li>
        <li>基金管理人：${fund.companyName}</li>
        <li>基金托管人：${fund.truster}</li>
        <li>产品风险等级：${fund.riskName}</li>
        <li>产品募集期：${fund.collectStartTime}&nbsp;至&nbsp;${fund.collectEndTime}</li>
        <li>产品缴款期 ：${fund.buyStartTime}&nbsp;至&nbsp;${fund.buyEndTime}</li>
      </ul>
    </div>
    <div class="cpgmlc">
      <p class="title"><span>购买流程</span></p>
      <ul class="ul">
        <li>在线预约财富顾问</li>
        <li>了解产品详情<br>
          知晓投资风险</li>
        <li>确定投资意向</li>
        <li>签署投资合同和协议</li>
        <li>完成支付<br>
          等待投资结果</li>
        <li>认购成功<br>
          查看资产</li>
      </ul>
    </div>
    <div id="product_content_B">
      <p class="cp_tab_title"><a href="javascript:void(0);" class="active">产品介绍</a><a href="javascript:void(0);">产品详情</a><a href="javascript:void(0);">产品文件</a><a href="javascript:void(0);">产品净值</a></p>
      <script type="text/javascript">
      $(function(){
          //tab导航条固定
            var offT=$(".cp_tab_title").offset().top;
           $(window).scroll(function(){
              var winTop = $(window).scrollTop();
              if (winTop>=offT){
                  $('.cp_tab_title').addClass('position_potop');
              }else{
                $('.cp_tab_title').removeClass('position_potop');
              };
              
            });
			$('.cp_tab_show:first').show();
			$('.cp_tab_title').find('a').click(function() {
				$(this).addClass('active').siblings('a').removeClass('active');
				$('.cp_tab_show').eq($('.cp_tab_title').find('a').index(this)).show().siblings('.cp_tab_show').hide();
			});
      });
      </script> 
      <!-- 产品介绍 s -->
      <div class="cp_tab_show tab_cpjs" id="tab_cpjs">
        <dl class="cpjs_dl_txt">
          <dt>产品特点<i>Product features</i></dt>
          <dd>
            ${fund.fundIntro}
          </dd>
        </dl>
        <dl class="cpjs_dl_txt">
          <dt>产品策略<i>Product strategy</i></dt>
          <dd>
            ${fund.fundStrategy}
          </dd>
        </dl>
      </div>
      <!-- 产品介绍 e --> 
      <!-- 产品详情 s -->
      <div class="cp_tab_show tab_cpxq" id="tab_cpxq">
      	<dl class="cpjs_dl_txt">
	      	<dd>
	      		${fund.fundDetail}
	      	</dd>
      	</dl>
      </div>
      <!-- 产品详情 e --> 
      <!-- 产品文件 s -->
      <div class="cp_tab_show tab_cpwj" id="tab_cpwj">
        <ul class="cpwj_ul">
        	[#list files as f]
          		<li><a href="${base}${f.path}" target="_blank"><span class="fl">${f.name}(${f.suffix})</span><span class="fr">查看 <i></i></span></a></li>
            [/#list]
        </ul>
      </div>
      <!-- 产品文件 e --> 
      <!-- 产品净值 s -->
      <div class="cp_tab_show tab_cpjz" id="tab_cpjz">
        <table border="0" cellspacing="0" cellpadding="0" class="cpjz_table">
          <tr>
            <th>发布日期:</th>
            <th>产品净值:</th>
          </tr>
           [#list fundAccounts as fa]
        	<tr>
          		<td>${(fa.beginTime)?string("yyyy-MM-dd")}</td>
          		<td>${money4(fa.money)}</td>
        	</tr>
        	[/#list]
        </table>
      </div>
      <!-- 产品净值 e --> 
    </div>
  </div>
  <!-- product_details_Left e --> 
  <!-- product_details_Right s -->
  <div class="product_details_Right">
    <div class="cp_R_fix">
      <h3 class="h3"><i class="fl">起投金额（万元）：</i><em class="fr ico ico-tishi"></em></h3>
      <p class="txt">${fund.startPerMoneyStr}万元起投<br>
        超出部分需按${fund.incrMoneyStr}万元增投</p>
      <h3 class="h3"><i class="fl">预约金额（元）：</i></h3>
      <form action="" class="form">
        <span class="placeholder_wrap">
        <input type="text" class="ipt1" onkeyup="javascript:checkMoney(this);"  
	                			onafterpaste="javascript:checkMoney(this);" name="appointmentAmount" id="appointmentAmount" placeholder="请输入金额">
        <label>元</label>
        </span>
        <p class="p1" id="capitalId"></p>
        <a href="javascript:void(0);"  class="submit"  id="show_cppc_popup_2">立即预约</a>
      </form>
    </div>
  </div>
  <!-- product_details_Right e --> 
</div>
<!-- main e --> 
<script type="text/javascript">
$(function(){
	//下拉固定等
	var cp_R_fix_t=$('.cp_R_fix').offset().top;	
	$(window).scroll(function () {
		$('.MT').hide();
		$('.top').removeClass('fixed_top');
		$('.header').removeClass('fixed_header');
		var winTop = $(window).scrollTop();
		if(winTop>=cp_R_fix_t){
			$('.cp_R_fix').addClass('fixed_cp_R_fix')
		}else{
			$('.cp_R_fix').removeClass('fixed_cp_R_fix')
		};			
	});
});
</script> 
<!-- 产品评测弹窗-2 s -->
<div class="cppc_popup_2">
  <p class="title"><span>私募基金投资者风险调查问卷（[#if loginSuccessKey.userType=='geren']个人[/#if][#if loginSuccessKey.userType=='qiye']机构[/#if]投资者使用）</span></p>
  <form action="" id="riskEvaluationForm">
    <ul class="UL_1">
      <li>
        <label>投资者姓名：</label>
        <span class="placeholder_wrap">
        <input type="text" class="ipt1" name="custName" id="custName" readOnly value="${name}">
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
        <input type="text" class="ipt1" name="cardNo" readOnly id="cardNo" value="${loginSuccessKey.cardNo}" placeholder="">
        </span> </li>
      <li>
        <label>联系方式：</label>
        <span class="placeholder_wrap">
        <input type="text" class="ipt1" name="link" readOnly id="link" placeholder="" value="${loginSuccessKey.addr}">
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

<link rel="stylesheet" href="${base}/frontCura/style/mCustomScrollbar.css">
<script src="${base}/frontCura/js/mCustomScrollbar.concat.min.js"></script> 
<script type="text/javascript">
$(function(){
	 $(window).on("load",function(){        
        $("#Middle_scroll").mCustomScrollbar();
      });
    var fundLevel = parseInt('${fund.riskLevel}');//产品风险等级
    var userLevel = parseInt('${loginSuccessKey.riskLevel}');//用户风险等级，原始的
	//提交
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
	        submitForm('${base}/cura/fund/risk/evaluation.htm',params,function(dd){
	        	alertNotification("提示","测评完成!","确定",function(){
	        	    layer.closeAll();
	        	    userLevel = parseInt(dd.data.riskLevelId);//测评后的风险等级
	        	    if(userLevel >= fundLevel){
	        	    	//直接预约
	        	    	asyncPost("${base}/cura/fund/appointment.htm",{fundId:'${fund.id}',amount: $("#appointmentAmount").val() },
				    		function(dd){
					    		if(!!dd){
					    			alertNotification("提示","预约成功，等待确认!","确定");
					    		}
				    	});
	        	    }else{
	        	    	riskMsg(dd.data,function(){//继续评测
	        	    		layer.open({
							  type: 1,
							  title: false,
							  closeBtn:2,
							  area : ['auto' , 'auto'],
							  offset: ['20px'],
							  shadeClose :true,
							  fix: false,
							  content: $('.cppc_popup_2')
							});
							$("#evalTime").val(getNow());
	        	    	});
	        	    }
	        	});
	        });
      });
	//立即预约
	$('#show_cppc_popup_2').on('click', function(){
		var cardNo = "${loginSuccessKey.cardNo}";
    	if(!cardNo){
    		alertNotification("温馨提示","请您完善个人信息，便于了解更多产品信息!","确定",function(){
    			window.document.location = "${base}/cura/cust/base.htm?productId=${fund.id}";
    		});
    		return false;
    	}
    	var aa = $("#appointmentAmount").val();
		if(!aa){
			alertNotification("提示","请填写预约金额!","确定");
			$("#appointmentAmount").focus();
			return false;
		}
		//是否进行过测评
		if(!userLevel){//未测评进行测评
			layer.open({
			  type: 1,
			  title: false,
			  closeBtn:2,
			  area : ['auto' , 'auto'],
			  offset: ['20px'],
			  shadeClose :true,
			  fix: false,
			  content: $('.cppc_popup_2')
			});
			$("#evalTime").val(getNow());
		 }else{//直接预约
	    	if(userLevel < fundLevel){
	    		alertConfirm("提示","您当前的风险等级不支持预约该产品，是否重新测评？",
	    			"确定",
	    			function(){
	    				layer.closeAll();
			    		layer.open({
							type: 1,
							title: false,
						  	closeBtn:2,
							area : ['auto' , 'auto'],
							shadeClose :true,
							content: $('.cppc_popup_2')//弹出产品评测弹窗-1
						});
						$("#evalTime").val(getNow());
	    			},
	    			"取消",
	    			function(){
	    				layer.closeAll();
	    			});
				return false;
	    	}
			asyncPost("${base}/cura/fund/appointment.htm",{
	    		fundId:'${fund.id}',
	    		amount: aa 
	    	},
	    	function(data){
	    		if(!!data){
	    			alertNotification("提示","预约成功，等待确认!","确定");
	    		}
	    	});
		}
		 
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
[#include "/cura/common/footer.ftl"]
</body>
</html>