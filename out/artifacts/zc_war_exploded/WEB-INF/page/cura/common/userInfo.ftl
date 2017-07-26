<div class="banner">
  <div class="user_Box">
    <p class="bjbox"></p>
    <div class="wrap">
      <dl class="L">
        <dt><a href="javascript:void(0);"><img src="#" alt="" width="140" height="140"></a></dt>
        <dd>
          <div class="dd_inner">
          	[@cuSecUser]
            <p>客户姓名：${loginSuccessKey.name}</p>
            <p>客户等级：${loginSuccessKey.level}</p>
            <p>客户类型：${loginSuccessKey.type}</p>
            <p>客户风险评级：
            	<!-- 已过期 -->
            	[#if loginSuccessKey.expired == 1]
            		已过期
            	[/#if]
            	[#if loginSuccessKey.expired == 0]
            		[#if loginSuccessKey.riskLevelName == null]
	            		未测评
	            	[/#if]
	            	[#if loginSuccessKey.riskLevelName != null]
	            		${loginSuccessKey.riskLevelName}　
	            		[#if (loginSuccessKey.evaluationTime)??]
	            			${(loginSuccessKey.evaluationTime)?string('yyyy-MM-dd')}
	            		[/#if]
	            		到期
	            	[/#if]
            	 [/#if]
            <a href="#" class="cxp" id="show_cppc_popup_2">[重新测评]</a><a href="${base}/cura/cust/print.htm" target="_blank" class="cxp">[打印]</a></p>
            [/@cuSecUser]
          </div>
        </dd>
      </dl>
      <div class="R">
        <div class="r_inner">
          <p>我的在投金额：<b>${investAmount}万元</b></p>
        </div>
      </div>
    </div>
  </div>
</div>
[#include "/cura/common/evaluation.ftl"]