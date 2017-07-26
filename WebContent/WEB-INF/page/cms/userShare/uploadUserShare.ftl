<script>
 var userShareFileUploader
$(function(){
	 userShareFileUploader = WebUploader.create({
    	server: '${base}/admin/userShare/uploadUserShare.htm',
    	pick:'#userShareExcelAdd',
    	compress: false,
    	accept: {
        	title: 'excel格式',
        	extensions: 'xls,xlsx'
    	}
	});
	userShareFileUploader.on( 'beforeFileQueued', function( file ) {
    	userShareFileUploader.reset();
	});
	userShareFileUploader.on( 'fileQueued', function( file ) {
    	$("#userShareUploadDiv #thelist").html( '<div id="' + file.id + '" class="item">' +
        '<h4 class="info">' + file.name + '</h4>' +
    	'</div>' );
	});
	userShareFileUploader.on('uploadSuccess', function( file,res) {
		$("#userShareUploadDiv #thelist").html("");
		userShareFileUploader.reset();
		closeMsg(loadFileUpload)
		if(res.status!="00"&&res.status!="11"){
			alertMsg(res.status)
		}else if(res.status=="00"){
			var html=res.allCount+"<br >";
			html+=res.successCount+"<br >";
			html+=res.errorCount+"<br >";
			html+=res.saveCount+"<br >";
			$("#userShareUploadDiv #callbackMsg").html(html);
		}else{
			var html=res.allCount+"<br >";
			html+=res.successCount+"<br >";
			html+=res.errorCount+"<br >";
			html+=res.saveCount+"<br >";
			html+=JSON.stringify(res.errors,null,"<br>");
			$("#userShareUploadDiv #callbackMsg").html(html);
		}
		
	});
	userShareFileUploader.on('uploadError', function(file) {
		$("#userShareUploadDiv #thelist").html("");
		userShareFileUploader.reset();
    	alertMsg("文件上传异常,请重试")
	});
	userShareFileUploader.on( 'startUpload', function( ) {
		if(userShareFileUploader.getFiles().length<1){
			alertMsg("请选择一个文件")
			return false;
		}
		loadFileUpload=loadMsg();
	});
	$("#userShareUploadDiv #ctlBtn").click(function(){
		$("#userShareUploadDiv #callbackMsg").html();
		userShareFileUploader.upload()
	})
})	

</script>

<div style="width:400px;height:300px;padding:15px;overflow:auto;" id="userShareUploadDiv">
		<div style="padding-bottom:15px;">
		<a href="${base}/static/user_share.xlsx">点我下载模板</a>
		<br >
		</div>
	 	<div id="thelist"></div>
		<div class="btns">
				<div id="userShareExcelAdd" style="display:inline-block;line-height:1.428571429;vertical-align:middle;margin: 0 12px 0 0;">选择文件</div>
				<button id="ctlBtn" class="btn btn-primary fa fa-plus" >开始上传</button>
		</div>
		<div id="callbackMsg">
		</div>
</div>