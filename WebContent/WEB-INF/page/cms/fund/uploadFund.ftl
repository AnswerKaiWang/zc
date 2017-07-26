<script>
 var fundFileUploader
$(function(){
	 fundFileUploader = WebUploader.create({
    	server: '${base}/admin/fund/uploadFund.htm',
    	pick:'#fundExcelAdd',
    	compress: false,
    	accept: {
        	title: 'excel格式',
        	extensions: 'xls,xlsx'
    	}
	});
	fundFileUploader.on( 'beforeFileQueued', function( file ) {
    	fundFileUploader.reset();
	});
	fundFileUploader.on( 'fileQueued', function( file ) {
    	$("#fundUploadDiv #thelist").html( '<div id="' + file.id + '" class="item">' +
        '<h4 class="info">' + file.name + '</h4>' +
    	'</div>' );
	});
	fundFileUploader.on('uploadSuccess', function( file,res) {
		$("#fundUploadDiv #thelist").html("");
		fundFileUploader.reset();
		closeMsg(loadFileUpload)
		if(res.status!="00"&&res.status!="11"){
			alertMsg(res.status)
		}else if(res.status=="00"){
			var html=res.allCount+"<br >";
			html+=res.successCount+"<br >";
			html+=res.errorCount+"<br >";
			html+=res.saveCount+"<br >";
			$("#fundUploadDiv #callbackMsg").html(html);
		}else{
			var html=res.allCount+"<br >";
			html+=res.successCount+"<br >";
			html+=res.errorCount+"<br >";
			html+=res.saveCount+"<br >";
			html+=JSON.stringify(res.errors,null,"<br>");
			$("#fundUploadDiv #callbackMsg").html(html);
		}
		
	});
	fundFileUploader.on('uploadError', function(file) {
		$("#fundUploadDiv #thelist").html("");
		fundFileUploader.reset();
    	alertMsg("文件上传异常,请重试")
	});
	fundFileUploader.on( 'startUpload', function( ) {
		if(fundFileUploader.getFiles().length<1){
			alertMsg("请选择一个文件")
			return false;
		}
		loadFileUpload=loadMsg();
	});
	$("#fundUploadDiv #ctlBtn").click(function(){
		$("#fundUploadDiv #callbackMsg").html();
		fundFileUploader.upload()
	})
})	

</script>

<div style="width:400px;height:300px;padding:15px;overflow:auto;" id="fundUploadDiv">
		<div style="padding-bottom:15px;">
		<a href="${base}/static/fund_upload.xlsx">点我下载模板</a>
		<br >
		</div>
	 	<div id="thelist"></div>
		<div class="btns">
				<div id="fundExcelAdd" style="display:inline-block;line-height:1.428571429;vertical-align:middle;margin: 0 12px 0 0;">选择文件</div>
				<button id="ctlBtn" class="btn btn-primary fa fa-plus" >开始上传</button>
		</div>
		<div id="callbackMsg">
		</div>
</div>