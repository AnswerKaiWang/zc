<script>
$(function(){
	formValidate("#companyAddForm",{
		name:{
			required: true
			},
		companyNo:{
			required: true
			}
	})
	var fileIds=["companyLogo","weiChatQr","appDownQr","userCenterLeftPic"];
	for(var i=0;i<fileIds.length;i++ ){
		companyAttrFileUpload(fileIds[i]);
	}
	var firstPicIndex=0;
	$('#companyAddForm a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
  		    var activeTab = $(e.target).text();
  		    if(activeTab=="首页图片"&&firstPicIndex==0){
  		    	var firstPics=["firstPic1","firstPic2","firstPic3","firstPic4","firstPic5","firstPic6","firstPic7","firstPic8"];
  		    	for(var i=0;i<firstPics.length;i++ ){
					companyAttrFileUpload(firstPics[i]);
				}
				firstPicIndex++;
  		    } 
	})
})	
function companyAttrFileUpload(vv){
	var fundFileUploader = WebUploader.create({
    	// 文件接收服务端。
    	server: '${base}/admin/fileUpload.htm',
    	pick: '#'+vv+'Picker',
    	auto:true,
    	compress: false
	});
	
	fundFileUploader.on('uploadSuccess', function( file,res) {
		if(res.status!="00"){
			layer.msg("文件上传异常,请重试")
			$("#"+vv+"PickerName").html("")
			$("#"+vv+"Url").val("")
		}else{
			$("#"+vv+"PickerName").html("<a href='${base}"+res.url+"' target='_blank'>"+res.url+"</a>")
			$("#"+vv+"Url").val(res.url)
		}
	});
	fundFileUploader.on('uploadError', function( file ) {
		$("#"+vv+"Url").val("")
    	layer.msg("文件上传异常,请重试")
	});

}
function companySubmitForm(parentIndex){
	var s=$("#companyAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#companyAddForm").serializeArray(),
			url:"${base}/admin/company/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
					$('#companyListMain #companyTable').bootstrapTable("refresh");
				}else{
					alertMsg(data.error,0)
				}
			},error:function(){
				closeMsg(o);
				alertMsg("系统异常,请重试")
			}
		})
	}
}
</script>

<div style="width:600px;height:500px;padding:15px;">
<form class="form-horizontal" id="companyAddForm">
   <ul  class="nav nav-tabs">
   	<li class="active">
      <a href="#companyAddBaseInfo" data-toggle="tab">
        	 基本信息
      </a>
   	</li>
   <li><a href="#companyAddLink" data-toggle="tab">友情链接</a></li>
   <li><a href="#companyAddFirstPic" data-toggle="tab">首页图片</a></li>
   <li><a href="#companyAddAbout" data-toggle="tab">关于我们</a></li>
	</ul>
	<div class="tab-content">
		<div class="tab-pane fade in active" id="companyAddBaseInfo">
		<br>
			<div class="form-group">
			    <label class="col-xs-3 control-label">公司编号</label>
			    <div class="col-xs-9">
			        <input type="text" class="form-control" placeholder="公司编号" name="companyNo" id="companyNo" value="${(company.companyNo)!}">
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">公司名称</label>
			    <div class="col-xs-9">
			        <input type="text" class="form-control" placeholder="公司名称" name="name" id="name" value="${(company.name)!}">
			         <input type="hidden"  name="id"  value="${company.id}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">公司简称</label>
			    <div class="col-xs-9">
			        <input type="text" class="form-control" placeholder="公司简称" name="companyAbbr" id="companyAbbr" value="${(company.companyAbbr)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">站点名称</label>
			    <div class="col-xs-9">
			        <input type="text" class="form-control" placeholder="站点名称" name="at[webSiteName]"  value="${at['webSiteName']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">域名</label>
			    <div class="col-xs-9">
			        <input type="text" class="form-control" placeholder="域名"   name="at[domain]" value="${at['domain']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">服务热线</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="服务热线" name="at['tel']"  value="${at['tel']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">客服邮箱</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="客服邮箱" name="at['email']" value="${at['email']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">人工服务时间</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="人工服务时间" name="at['serviceTime']" value="${at['serviceTime']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">邮编</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="邮编" name="at['zip']" value="${at['zip']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">传真</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="传真" name="at['tax']" value="${at['tax']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">地址</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="地址" name="at['address']" value="${at['address']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">百度地图坐标lng</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="lng" name="at['lng']" value="${at['lng']}">
			    	<a href="http://api.map.baidu.com/lbsapi/getpoint/index.html" target="_blank">如何获取</a>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">百度地图坐标lat</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="lat" name="at['lat']" value="${at['lat']}">
			    	<a href="http://api.map.baidu.com/lbsapi/getpoint/index.html" target="_blank">如何获取</a>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">网站copyright</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="网站copyright" name="at['copyright']" value="${at['copyright']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">网站备案</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="网站备案" name="at['webBei']" value="${at['webBei']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">用户中心欢迎语</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="用户中心欢迎语" name="at['userCenterTopTip']" value="${at['userCenterTopTip']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">公司logo</label>
			    <div class="col-xs-9">
			    	<input  name="at['companyLogo']" id="companyLogoUrl" value="${at['companyLogo']}">
			    	<div id="companyLogoPickerName"><a href="${base}${at['companyLogo']}" target="_blank">${at['companyLogo']}</a></div>
			    	<div id="companyLogoPicker">选择文件</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">微信二维码</label>
			    <div class="col-xs-9">
			    	<input  name="at['weiChatQr']" id="weiChatQrUrl" value="${at['weiChatQr']}">
			    	<div id="weiChatQrPickerName"><a href="${base}${at['weiChatQr']}" target="_blank">${at['weiChatQr']}</a></div>
			    	<div id="weiChatQrPicker">选择文件</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">app下载二维码</label>
			    <div class="col-xs-9">
			    	<input   name="at['appDownQr']" id="appDownQrUrl" value="${at['appDownQr']}">
			    	<div id="appDownQrPickerName"><a href="${base}${at['appDownQr']}" target="_blank">${at['appDownQr']}</a></div>
			    	<div id="appDownQrPicker">选择文件</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">用户中心左图片</label>
			    <div class="col-xs-9">
			    	<input   name="at['userCenterLeftPic']" id="userCenterLeftPicUrl" value="${at['userCenterLeftPic']}">
			    	<div id="userCenterLeftPicPickerName"><a href="${base}${at['userCenterLeftPic']}" target="_blank">${at['userCenterLeftPic']}</a></div>
			    	<div id="userCenterLeftPicPicker">选择文件</div>
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="companyAddLink">
		<br>
			<div class="form-group">
			    <label class="col-xs-3 control-label">友情链接1</label>
			    <div class="col-xs-9">
			    <input type="text" class="form-control" placeholder="名字" name="at['link1']" value="${at['link1']}">
			    <input type="text" class="form-control" placeholder="链接" name="at['linkHref1']" value="${at['linkHref1']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">友情链接2</label>
			    <div class="col-xs-9">
			    <input type="text" class="form-control" placeholder="名字" name="at['link2']" value="${at['link2']}">
			    <input type="text" class="form-control" placeholder="链接" name="at['linkHref2']" value="${at['linkHref2']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">友情链接3</label>
			    <div class="col-xs-9">
			    <input type="text" class="form-control" placeholder="名字" name="at['link3']" value="${at['link3']}">
			    <input type="text" class="form-control" placeholder="链接" name="at['linkHref3']" value="${at['linkHref3']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">友情链接4</label>
			    <div class="col-xs-9">
			    <input type="text" class="form-control" placeholder="名字" name="at['link4']" value="${at['link4']}">
			    <input type="text" class="form-control" placeholder="链接" name="at['linkHref4']" value="${at['linkHref4']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">友情链接5</label>
			    <div class="col-xs-9">
			    <input type="text" class="form-control" placeholder="名字" name="at['link5']" value="${at['link5']}">
			    <input type="text" class="form-control" placeholder="链接" name="at['linkHref5']" value="${at['linkHref5']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">友情链接6</label>
			    <div class="col-xs-9">
			    <input type="text" class="form-control" placeholder="名字" name="at['link6']" value="${at['link6']}">
			    <input type="text" class="form-control" placeholder="链接" name="at['linkHref6']" value="${at['linkHref6']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">友情链接7</label>
			    <div class="col-xs-9">
			    <input type="text" class="form-control" placeholder="名字" name="at['link7']" value="${at['link7']}">
			    <input type="text" class="form-control" placeholder="链接" name="at['linkHref7']" value="${at['linkHref7']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">友情链接8</label>
			    <div class="col-xs-9">
			    <input type="text" class="form-control" placeholder="名字" name="at['link8']" value="${at['link8']}">
			    <input type="text" class="form-control" placeholder="链接" name="at['linkHref8']" value="${at['linkHref8']}">
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="companyAddFirstPic">
		<br>
			<div class="form-group">
			    <label class="col-xs-3 control-label">首页图片1</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="链接" name="at['firstPicHref1']" value="${at['firstPicHref1']}">
			    	<input   name="at['firstPic1']" id="firstPic1Url" value="${at['firstPic1']}">
			    	<div id="firstPic1PickerName"><a href="${base}${at['firstPic1']}" target="_blank">${at['firstPic1']}</a></div>
			    	<div id="firstPic1Picker">选择文件</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">首页图片2</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="链接" name="at['firstPicHref2']" value="${at['firstPicHref2']}">
			    	<input   name="at['firstPic2']" id="firstPic2Url" value="${at['firstPic2']}">
			    	<div id="firstPic2PickerName"><a href="${base}${at['firstPic2']}" target="_blank">${at['firstPic2']}</a></div>
			    	<div id="firstPic2Picker">选择文件</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">首页图片3</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="链接" name="at['firstPicHref3']" value="${at['firstPicHref3']}">
			    	<input   name="at['firstPic3']" id="firstPic3Url" value="${at['firstPic3']}">
			    	<div id="firstPic3PickerName"><a href="${base}${at['firstPic3']}" target="_blank">${at['firstPic3']}</a></div>
			    	<div id="firstPic3Picker">选择文件</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">首页图片4</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="链接" name="at['firstPicHref4']" value="${at['firstPicHref4']}">
			    	<input   name="at['firstPic4']" id="firstPic4Url" value="${at['firstPic4']}">
			    	<div id="firstPic4PickerName"><a href="${base}${at['firstPic4']}" target="_blank">${at['firstPic4']}</a></div>
			    	<div id="firstPic4Picker">选择文件</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">首页图片5</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="链接" name="at['firstPicHref5']" value="${at['firstPicHref5']}">
			    	<input   name="at['firstPic5']" id="firstPic5Url" value="${at['firstPic5']}">
			    	<div id="firstPic5PickerName"><a href="${base}${at['firstPic5']}" target="_blank">${at['firstPic5']}</a></div>
			    	<div id="firstPic5Picker">选择文件</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">首页图片6</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="链接" name="at['firstPicHref6']" value="${at['firstPicHref6']}">
			    	<input   name="at['firstPic6']" id="firstPic6Url" value="${at['firstPic6']}">
			    	<div id="firstPic6PickerName"><a href="${base}${at['firstPic6']}" target="_blank">${at['firstPic6']}</a></div>
			    	<div id="firstPic6Picker">选择文件</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">首页图片7</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="链接" name="at['firstPicHref7']" value="${at['firstPicHref7']}">
			    	<input   name="at['firstPic7']" id="firstPic7Url" value="${at['firstPic7']}">
			    	<div id="firstPic7PickerName"><a href="${base}${at['firstPic7']}" target="_blank">${at['firstPic7']}</a></div>
			    	<div id="firstPic7Picker">选择文件</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">首页图片8</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="链接" name="at['firstPicHref8']" value="${at['firstPicHref8']}">
			    	<input type="text"  name="at['firstPic8']" id="firstPic8Url" value="${at['firstPic8']}">
			    	<div id="firstPic8PickerName"><a href="${base}${at['firstPic8']}" target="_blank">${at['firstPic8']}</a></div>
			    	<div id="firstPic8Picker">选择文件</div>
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="companyAddAbout">
		<br>
			<div class="form-group">
			    <label class="col-xs-3 control-label">关于我们名字</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="关于我们名字" name="at['aboutName']" value="${at['aboutName']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">关于我们内容</label>
			    <div class="col-xs-9">
			    	<textarea placeholder="关于我们内容" class="form-control"  name="at['aboutContant']" >${at['aboutContant']}</textarea>
			    </div>
			</div>
		</div>
	</div>
</form>
</div>