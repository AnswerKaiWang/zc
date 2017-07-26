<!-- footer s -->
<footer  class="footer" >
  <div class="wrap">
    <p class="p1"><span class="fl"><a href="#">帮助中心</a>|<a href="#">安全保障</a>|<a href="${base}/about.htm">关于我们</a>|<a href="#" class="blink">友情链接</a></span><span class="fr"><!--<a href="###" class="weixina">微信公众号</a><a href="#" class="appdown">APP下载</a>--></span></p>
    <p class="p2">
    	<span class="fl">
    	Copyright ©[@coAttr name="copyright" /] [@coAttr name="webSiteName" /]
    	版权所有 [@coAttr name="webBei" /]
    	</span>
    	<span class="fr">
    		<b>[@coAttr name="tel" /]</b>
    	([@coAttr name="serviceTime" /])</span>
    </p>
  </div>
</footer>
<div class="linkBox">
	<i class="jiao"></i>
	[@coAttr name="linkHref" type="like"]
	[#assign linkHrefs=companyAttr]
	[/@coAttr]
	[@coAttr name="link1,link2,link3,link4,link5,link6,link7,link8" type="xx"]
      			[#list companyAttr as fp]
      			[#if (fp.contant)??]
      				<a href="${(linkHrefs[fp_index]).contant!"#"}" target="_blank">${(fp.contant)!}</a>
      			[/#if]
      			[/#list]
    [/@coAttr]
	</div>
<div class="weixinBox"><i class="jiao"></i>
		<img src="[@coAttr name="weiChatQr"]${base}${companyAttr.contant}[/@coAttr]" alt="">
		<p>扫一扫，关注微信公众号</p>
</div>
<div class="appdownBox"><i class="jiao"></i>
		<img src="[@coAttr name="appDownQr"]${base}${companyAttr.contant}[/@coAttr]" alt="">
		<p>扫一扫，下载手机APP</p>
</div>
<!-- footer e -->