<script>
var ctxEditor;
$(function(){
	formValidate("#sysConfigAddForm",{
		fundId:{
			required: true
		},
		userSecondId:{
			required: true
		}
	});
	ctxEditor = new wangEditor('sysValue');
    ctxEditor.config.uploadImgUrl = '${base}/admin/upload.htm';
    ctxEditor.config.uploadParams = {
        token: 'abcdefg',
        user: 'wangfupeng1988'
    };
    ctxEditor.config.uploadHeaders = {
        'Accept' : 'text/x-json'
    };
    ctxEditor.config.hideLinkImg = true;
    ctxEditor.create();
    
    var fundFileUploader = WebUploader.create({
    	// 文件接收服务端。
    	server: '${base}/admin/fileUpload.htm',
    	pick: '#selectImgBtn',
    	auto:true,
    	compress: false
	});
	
	fundFileUploader.on('uploadSuccess', function( file,res) {
		closeMsg(loadFileUpload)
		if(res.status!="00"){
			alertMsg("文件上传异常,请重试")
			ctxEditor.$txt.html('');
		}else{
			ctxEditor.$txt.html(res.url)
		}
	});
	fundFileUploader.on( 'uploadError', function( file ) {
		closeMsg(loadFileUpload)
		ctxEditor.$txt.html('');
    	alertMsg("文件上传异常,请重试")
	});
	fundFileUploader.on( 'startUpload', function(  ) {
		loadFileUpload=loadMsg();
	});
    
    $("#type").on("change",function(){
    	var t = $(this).val();
    	if(t ==1){//文本
    		ctxEditor.enable();
    		$("#selectImgBtn").css("display","none");
    		$("#selectTypeBtn").removeClass("col-xs-8");
		    $("#selectTypeBtn").addClass("col-xs-10");
    	}else if(t ==2){//图片
    		ctxEditor.disable();
    		$("#selectTypeBtn").addClass("col-xs-8");
    		$("#selectImgBtn").css("display","");
    	}else if(t ==3){//纯文本
    		ctxEditor.enable();
    		$("#selectTypeBtn").addClass("col-xs-8");
    		$("#selectImgBtn").css("display","");
    	}
    });
})	
function sysConfigAddForm(parentIndex){
	var s=$("#sysConfigAddForm").validate().form();
	if(s){
		var t  = $("#sysConfigAddForm #type").val(); 
		if(t == 1){
			$("#sysValue").html(ctxEditor.$txt.text());
		}else{
			$("#sysValue").val(ctxEditor.$txt.text());
		}
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#sysConfigAddForm").serializeArray(),
			url:"${base}/admin/sysConfig/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#sysConfigListMain #sysConfigTable').bootstrapTable("refresh");
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
<div style="width:800px;height:500px;padding:15px;">
<form class="form-horizontal" id="sysConfigAddForm">
	<br>
	<div class="form-group">
	    <label class="col-xs-2 control-label">类型</label>
	    <div class="col-xs-10" id="selectTypeBtn">
	    	<select class="form-control" name="type" id="type">
	    		<option value=1>格式化文本</option>
	    		<option value=2>图片</option>
	    		<option value=3>纯文本</option>
	    	</select>
	    </div>
	    <div class="col-xs-2" id="selectImgBtn" style="display:none;">选择</div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">名称</label>
	    <div class="col-xs-10">
	        <input type="text" class="form-control" name="name" id="name" >
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">键</label>
	    <div class="col-xs-10">
	    	<input type="text" class="form-control" name="sysKey" id="sysKey" >
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">内容</label>
	    <div class="col-xs-10">
	    	<textarea class="form-control" style="height:300px;" name="sysValue" id="sysValue"></textarea>
	    </div>
	</div>
</form>
</div>