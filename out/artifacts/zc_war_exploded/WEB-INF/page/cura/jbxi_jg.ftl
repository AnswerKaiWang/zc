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
[#include "/cura/common/userInfo.ftl"]
[#include "/cura/common/caifu.ftl"]
<style type="text/css">
/*本页样式*/
body{background-color: #f9f9f9;}
</style>
<!-- main s -->
<div class="main">
  <!-- queryPage_Left s -->
  <div class="queryPage_Left">
    <ul class="Menu">
      <li><a href="jbxi_jg.html" class="active">基本信息</a></li>
      <li><a href="grxi_jg.html">个人信息</a></li>
    </ul>
  </div>
  <!-- queryPage_Left e -->
  <!-- queryPage_Right s -->
  <div class="queryPage_Right">
    <p class="search_tab_title">
    	<a href="${base}/cura/cust/account.htm">账户与安全</a>
    	<a href="#" class="active">客户资料</a><a href="#">风险测评</a>
    	<a href="${base}/cura/cust/survey.htm">问卷调查</a>
    </p>
    <!-- info_public s -->
    <div class="info_public">
    <form action="" id="jgBaseForm">
    	<input type="hidden" name="id" id="id" value="${loginSuccessKey.userSecondId}">
     	<input type="hidden" name="productId" id="productId" value="${productId}">
      <p class="info_ty_title"><span>基本信息</span></p>
      <ul class="UL">
      	<li><label><i></i>客户代码：</label>${loginSuccessKey.custNo}</li>
      	<li><label><i>*</i>客户姓名：</label><span class="placeholder_wrap">
      		<input type="text" name="name" class="ipt1" placeholder="请输入姓名" value="${loginSuccessKey.name}"></span></li>
      	<li><label><i></i>手机号码：</label>${loginSuccessKey.phone}</li>
      	<li><label><i></i>固定座机：</label><span class="placeholder_wrap">
      		<input type="text" name="conTel" class="ipt1" placeholder="请输入电话号码" value="${loginSuccessKey.tel}"></span></li>
      	<li><label><i></i>电子邮箱：</label><span class="placeholder_wrap">${loginSuccessKey.email}</span></li>
      	<li><label><i></i>所在城市：</label>
      		<select  name="city" class="ipt1">
	      		<option value="">未知</option>
	        	[@dict name="city" ]
	        	[#list dictList as st]
	        		<option value="${st.id}" [#if st.id=='${loginSuccessKey.cityId}']selected=selected[/#if]>${st.name}</option>
	        	[/#list]
	        	[/@dict]
      		</select>
      	</li>
      	<li><label><i></i>邮编：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" name="conZip" placeholder="请输入邮编" value="${loginSuccessKey.zip}"></span></li>
      	<li><label><i></i>通讯地址：</label><span class="placeholder_wrap" >
      		<input type="text" name="conAddr" class="ipt1" placeholder="请输入通讯地址" value="${loginSuccessKey.addr}"></span></li>
      	<li><label><i></i>邀请码：</label><span class="placeholder_wrap">
      		<input type="text" name="welcomeCode" class="ipt1" placeholder="请输入邀请码" value="${loginSuccessKey.welcomeCode}"></span></li>
      	<li><label><i>*</i>公司营业执照：</label><span class="placeholder_wrap">
      		<input type="text" name="cardNo"  class="ipt1" placeholder="请输入公司营业执照" value="${loginSuccessKey.cardNo}"></span></li>
      	<li><label><i></i>组织机构代码：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" name="comCode" placeholder="请输入组织机构代码"  value="${loginSuccessKey.comCode}"></span></li>
      	<li><label><i></i>税务登记证：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" name="shuiwu" placeholder="请输入税务登记证"  value="${loginSuccessKey.shuiwu}"></span></li>
      	<li><label><i></i>开户许可证号：</label><span class="placeholder_wrap">
      		<input type="text" name="kaihu" class="ipt1" placeholder="请输入开户许可证号" value="${loginSuccessKey.kaihu}"></span></li>
      	<li><label><i></i>机构信用代码证：</label><span class="placeholder_wrap">
      		<input type="text" class="ipt1" name="xinyong" placeholder="请输入机构信用代码证" value="${loginSuccessKey.xinyong}"></span></li>
      </ul>
      <div class="yi_txt">
        <p><i class="ico ico-lamp"></i>&nbsp;请您完善以上信息，便于了解更多产品信息</p>
        <p><input type="checkbox" class="c" >&nbsp;我已同意授权开通
        	<a href="javascript:void(0);" class="show_user_xieyi_2">《中城投资旗下基金管理人平台注册》</a></p>
      </div>
      <button type="button" class="submit" id="jgNextSubmitBtn">下一步</button>
      </form>
    </div>
    <!-- info_public e -->
  </div>
  <script type="text/javascript">
	$('.select').select2({
		  theme: "classic",
		  minimumResultsForSearch: Infinity
	});
	$("#jgNextSubmitBtn").on("click",function(e){
			e.preventDefault();
			var params = {};
	  		$.each($("#jgBaseForm").serializeArray(),function(key,value){
	        		params[value.name]=value.value;
	        });
	        submitForm('${base}/cura/cust/info1.htm',params,function(data){
	        	alertNotification("提示","是否进行下一步？","确定",function(){//下一步
	        		window.document.location = '${base}/cura/cust.htm?productId=${productId}';
	        	});
	        });
		});
	</script> 
  <!-- queryPage_Right e -->
  <!-- 用户注册协议-2 s -->
  <div class="user_xieyi xieyi_2">
    <a href="javascript:void(0);" class="close_xieyi" title="关闭"><i class="ico ico-guanbi1"></i></a>
    <h3 class="title">《中城投资旗下基金管理人平台注册》</h3>
    <div class="text" id="xieyi_content_2">
      上海中城联盟财富金融信息服务有限公司 用户服务协议
  甲方：【投资人姓名】（以下简称“投资人”）
  身份证号：
  
  乙方：上海中城联盟财富金融信息服务有限公司（以下简称“中城财富”）
  地址： 上海市奉贤区海坤路99号第1 幢2023室
  法定代表人： 王珊
  
  
  
  第一条 服务内容
  （一）乙方根据交易规定，为甲方及其拟进行的交易提供公开、公平、公正的交易居间服务，进行信息发布、组织交易、项目推介、交易方权益登记及查询、交易价款及收益结算等服务。具体内容如下：
  1、信息发布：乙方按照交易规定，经交易向对方同意，将其提供的交易信息通过乙方渠道在乙方注册会员内部向甲方公布的服务。
  2、交易服务：乙方按照交易规定及甲方的需求，为交易提供电子交易文件签署、交易价款支付和收益资金结算等服务支持，以保障甲方与交易向对方顺利进行交易的服务。
  3、项目推介：乙方通过乙方渠道向甲方提供交易机会或其他相关信息推介的服务。
  4、权益登记及查询：根据甲方的委托，乙方通过交易系统在会员资产登记时对交易双方在交易过程中财产权益的持有人及份额、转让价格、预计收益时间及金额、注销以及被司法、行政机关采取强制措施等信息予以记录并提供查询的服务。
  （二）乙方根据交易规定和市场需求，将不断完善服务内容。乙方将通过官方网站向注册会员公布全部服务内容，增加或减少的服务内容不再向甲方作个别通知，自乙方官方网站公布之日或公布中规定的服务生效之日起生效，对甲乙双方产生法律约束力，甲方如不同意乙方的服务内容，有权在书面通知乙方后停止使用全部或部分乙方的服务内容。
  
  第二条 资金结算
  甲方应按照乙方要求绑定银行卡并进行身份验证。甲方同意，甲方支付的受让价款及转让标的对应收益资金的划转经其绑定的银行卡支付，并由【上海银联电子支付服务有限公司】（以下简称“代收代付机构”）代为进行，甲方按照各方另行签订的交易合同的约定，将交易价款支付至代收代付机构的支付系统，该支付系统与将与交易相对方指定的银行账户进行关联：
  如交易有回购或还款条款的，款项将通过代收代付机构，转账至乙方绑定的银行卡。具体以各方另行签订的交易协议为准。
  甲方理解并同意其上述行为受银行卡对应的发卡银行（以下简称“发卡行”）及代收代付机构的操作规则限制，由于甲方违反操作规则而造成的支付失败及相应服务费由其自行承担。甲方最终的款项支付服务是由发卡行及代收代付机构提供的，需要向发卡行及代收代付机构请求查证，乙方不对资金到账时间做任何承诺，也不承担与此相关的任何责任。
  甲方使用上述服务，即表示甲方不可撤销地授权乙方及代收代付机构进行相关操作，且该等操作是不可逆转的，甲方不能以任何理由拒绝付款或要求取消交易。
  
  第三条 甲方声明与承诺
      甲方向乙方申请按本协议约定通过乙方渠道进行交易，现就有关事项做出如下声明与承诺：
  （一）甲方以自有合法资金进行投资，不存在法律、法规、规章和监管部门或乙方相关交易规则禁止或限制交易的情形；
  （二）甲方承诺自觉遵守国家法律、法规和规章，已充分理解并愿意遵守乙方的各项规则制度，依法、诚信开展交易活动；
  （三）甲方保证向乙方提供的包括但不限于文件、资料、证件均真实、准确、完整、有效、合法；
  （四）甲方充分了解并愿意承担该受让行为的全部风险。
  
  第四条 甲方的权利和义务
  （一）甲方有权享有乙方提供的交易信息发布、组织交易、项目推介、权益登记及查询、资金结算等居间服务；
  （二）甲方有权使用乙方提供的交易系统；
  （三）甲方作为乙方会员，享有会员的相关权益；
  
  第五条 乙方的权利和义务
  （一）乙方应按照本协议约定的内容，向甲方提供相关居间服务；
  （二）乙方应不断完善交易信息系统，为甲方提供高效、便利的居间服务；
  （三）乙方有义务按照会员管理规定，维护甲方的会员权益；
  
  第六条 保密与信息披露
  （一）任何一方未经另一方事先书面同意，不得单方面将与本协议以及本协议项下交易的任何信息向任何第三方披露，但根据本条第（二）款约定已作出公开披露的信息除外；
  （二）本条不限制一方根据适用法律、法规和有权机关的司法或执法要求，就与本协议项下交易有关信息进行披露；
  
    </div>
  </div>
  <!-- 用户注册协议-2 e -->
  <link rel="stylesheet" href="${base}/frontCura/style/mCustomScrollbar.css">
  <script src="${base}/frontCura/js/mCustomScrollbar.concat.min.js"></script> 
  <script>
	//滚动条
	(function($){
	  $(window).on("load",function(){        
		$("#xieyi_content_2").mCustomScrollbar();        
	  });
	})(jQuery);
  </script>
</div>
<!-- main e --> 
<!-- footer s -->
[#include "/cura/common/footer.ftl"]
<!-- footer e -->
</body>
</html>