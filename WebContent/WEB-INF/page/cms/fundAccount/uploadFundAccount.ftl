<script>
 var fundAccountFileUploader
$(function(){
	 fundAccountFileUploader = WebUploader.create({
    	server: '${base}/admin/fundAccount/uploadFundAccount.htm',
    	pick:'#fundAccountExcelAdd',
    	compress: false,
    	accept: {
        	title: 'excel格式',
        	extensions: 'xls,xlsx'
    	}
	});
	fundAccountFileUploader.on( 'beforeFileQueued', function( file ) {
    	fundAccountFileUploader.reset();
	});
	fundAccountFileUploader.on( 'fileQueued', function( file ) {
    	$("#fundAccountUploadDiv #thelist").html( '<div id="' + file.id + '" class="item">' +
        '<h4 class="info">' + file.name + '</h4>' +
    	'</div>' );
	});
	fundAccountFileUploader.on('uploadSuccess', function( file,res) {
		$("#fundAccountUploadDiv #thelist").html("");
		fundAccountFileUploader.reset();
		closeMsg(loadFileUpload)
		if(res.status!="00"&&res.status!="11"){
			alertMsg(res.status)
		}else if(res.status=="00"){
			var html=res.allCount+"<br >";
			html+=res.successCount+"<br >";
			html+=res.errorCount+"<br >";
			html+=res.saveCount+"<br >";
			$("#fundAccountUploadDiv #callbackMsg").html(html);
		}else{
			var html=res.allCount+"<br >";
			html+=res.successCount+"<br >";
			html+=res.errorCount+"<br >";
			html+=res.saveCount+"<br >";
			html+=JSON.stringify(res.errors,null,"<br>");
			$("#fundAccountUploadDiv #callbackMsg").html(html);
		}
		
	});
	fundAccountFileUploader.on('uploadError', function(file) {
		$("#fundAccountUploadDiv #thelist").html("");
		fundAccountFileUploader.reset();
    	alertMsg("文件上传异常,请重试")
	});
	fundAccountFileUploader.on( 'startUpload', function( ) {
		if(fundAccountFileUploader.getFiles().length<1){
			alertMsg("请选择一个文件")
			return false;
		}
		loadFileUpload=loadMsg();
	});
	$("#fundAccountUploadDiv #ctlBtn").click(function(){
		$("#fundAccountUploadDiv #callbackMsg").html();
		fundAccountFileUploader.upload()
	})
})	

</script>

<div style="width:400px;height:300px;padding:15px;overflow:auto;" id="fundAccountUploadDiv">
		<div style="padding-bottom:15px;">
		<a href="${base}/static/fund_nav.xlsx">点我下载模板</a>
		<br >
		</div>
	 	<div id="thelist"></div>
		<div class="btns">
				<div id="fundAccountExcelAdd" style="display:inline-block;line-height:1.428571429;vertical-align:middle;margin: 0 12px 0 0;">选择文件</div>
				<button id="ctlBtn" class="btn btn-primary fa fa-plus" >开始上传</button>
		</div>
		<div id="callbackMsg">
		</div>
</div>