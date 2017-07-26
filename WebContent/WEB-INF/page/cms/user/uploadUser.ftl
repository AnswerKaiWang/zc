<script>
 var userFileUploader
$(function(){
	 userFileUploader = WebUploader.create({
    	server: '${base}/admin/user/uploadUser.htm',
    	pick:'#userExcelAdd',
    	compress: false,
    	accept: {
        	title: 'excel格式',
        	extensions: 'xls,xlsx'
    	}
	});
	userFileUploader.on( 'beforeFileQueued', function( file ) {
    	userFileUploader.reset();
	});
	userFileUploader.on( 'fileQueued', function( file ) {
    	$("#userUploadDiv #thelist").html( '<div id="' + file.id + '" class="item">' +
        '<h4 class="info">' + file.name + '</h4>' +
    	'</div>' );
	});
	userFileUploader.on('uploadSuccess', function( file,res) {
		$("#userUploadDiv #thelist").html("");
		userFileUploader.reset();
		closeMsg(loadFileUpload)
		if(res.status!="00"&&res.status!="11"){
			alertMsg(res.status)
		}else if(res.status=="00"){
			var html=res.allCount+"<br >";
			html+=res.successCount+"<br >";
			html+=res.errorCount+"<br >";
			html+=res.saveCount+"<br >";
			$("#userUploadDiv #callbackMsg").html(html);
		}else{
			var html=res.allCount+"<br >";
			html+=res.successCount+"<br >";
			html+=res.errorCount+"<br >";
			html+=res.saveCount+"<br >";
			html+=JSON.stringify(res.errors,null,"<br>");
			$("#userUploadDiv #callbackMsg").html(html);
		}
		
	});
	userFileUploader.on('uploadError', function(file) {
		$("#userUploadDiv #thelist").html("");
		userFileUploader.reset();
    	alertMsg("文件上传异常,请重试")
	});
	userFileUploader.on( 'startUpload', function( ) {
		if(userFileUploader.getFiles().length<1){
			alertMsg("请选择一个文件")
			return false;
		}
		loadFileUpload=loadMsg();
	});
	$("#userUploadDiv #ctlBtn").click(function(){
		$("#userUploadDiv #callbackMsg").html();
		userFileUploader.upload()
	})
})	

</script>

<div style="width:400px;height:300px;padding:15px;overflow:auto;" id="userUploadDiv">
		<div style="padding-bottom:15px;">
		<a href="${base}/static/user.xlsx">点我下载模板</a>
		<br >
		</div>
	 	<div id="thelist"></div>
		<div class="btns">
				<div id="userExcelAdd" style="display:inline-block;line-height:1.428571429;vertical-align:middle;margin: 0 12px 0 0;">选择文件</div>
				<button id="ctlBtn" class="btn btn-primary fa fa-plus" >开始上传</button>
		</div>
		<div id="callbackMsg">
		</div>
</div>