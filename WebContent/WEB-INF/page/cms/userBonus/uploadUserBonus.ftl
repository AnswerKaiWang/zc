<script>
 var userBonusFileUploader
$(function(){
	 userBonusFileUploader = WebUploader.create({
    	server: '${base}/admin/userBonus/uploadUserBonus.htm',
    	pick:'#userBonusExcelAdd',
    	compress: false,
    	accept: {
        	title: 'excel格式',
        	extensions: 'xls,xlsx'
    	}
	});
	userBonusFileUploader.on( 'beforeFileQueued', function( file ) {
    	userBonusFileUploader.reset();
	});
	userBonusFileUploader.on( 'fileQueued', function( file ) {
    	$("#userBonusUploadDiv #thelist").html( '<div id="' + file.id + '" class="item">' +
        '<h4 class="info">' + file.name + '</h4>' +
    	'</div>' );
	});
	userBonusFileUploader.on('uploadSuccess', function( file,res) {
		$("#userBonusUploadDiv #thelist").html("");
		userBonusFileUploader.reset();
		closeMsg(loadFileUpload)
		if(res.status!="00"&&res.status!="11"){
			alertMsg(res.status)
		}else if(res.status=="00"){
			var html=res.allCount+"<br >";
			html+=res.successCount+"<br >";
			html+=res.errorCount+"<br >";
			html+=res.saveCount+"<br >";
			$("#userBonusUploadDiv #callbackMsg").html(html);
		}else{
			var html=res.allCount+"<br >";
			html+=res.successCount+"<br >";
			html+=res.errorCount+"<br >";
			html+=res.saveCount+"<br >";
			html+=JSON.stringify(res.errors,null,"<br>");
			$("#userBonusUploadDiv #callbackMsg").html(html);
		}
		
	});
	userBonusFileUploader.on('uploadError', function(file) {
		$("#userBonusUploadDiv #thelist").html("");
		userBonusFileUploader.reset();
    	alertMsg("文件上传异常,请重试")
	});
	userBonusFileUploader.on( 'startUpload', function( ) {
		if(userBonusFileUploader.getFiles().length<1){
			alertMsg("请选择一个文件")
			return false;
		}
		loadFileUpload=loadMsg();
	});
	$("#userBonusUploadDiv #ctlBtn").click(function(){
		$("#userBonusUploadDiv #callbackMsg").html();
		userBonusFileUploader.upload()
	})
})	

</script>

<div style="width:400px;height:300px;padding:15px;overflow:auto;" id="userBonusUploadDiv">
		<div style="padding-bottom:15px;">
		<a href="${base}/static/user_bonus.xlsx">点我下载模板</a>
		<br >
		</div>
	 	<div id="thelist"></div>
		<div class="btns">
				<div id="userBonusExcelAdd" style="display:inline-block;line-height:1.428571429;vertical-align:middle;margin: 0 12px 0 0;">选择文件</div>
				<button id="ctlBtn" class="btn btn-primary fa fa-plus" >开始上传</button>
		</div>
		<div id="callbackMsg">
		</div>
</div>