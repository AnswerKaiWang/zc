<script>
var contentEditor;	
$(function(){
	formValidate("#newsAddForm",{
		fundId:{
			required: true
		},
		userSecondId:{
			required: true
		}
	});
	contentEditor = new wangEditor('content');
	contentEditor.config.uploadImgUrl = '${base}/admin/upload.htm';
    contentEditor.config.uploadParams = {
        token: 'abcdefg',
        user: 'wangfupeng1988'
    };
    contentEditor.config.uploadHeaders = {
        'Accept' : 'text/x-json'
    };
    contentEditor.config.hideLinkImg = true;
    contentEditor.create();
    laydateToId('publishTime');
    var fileUploader = WebUploader.create({
    	// 文件接收服务端。
    	server: '${base}/admin/fileUpload.htm',
    	pick: '#coverPicker',
    	auto:true,
    	compress: false
	});
	fileUploader.on('uploadSuccess', function( file,res) {
		closeMsg(loadFileUpload)
		if(res.status!="00"){
			alertMsg("文件上传异常,请重试")
			$("#cover").val("")
		}else{
			$("#cover").val(res.url);
		}
	});
	fileUploader.on( 'uploadError', function( file ) {
		closeMsg(fileUploader)
		$("#cover").val("")
    	alertMsg("文件上传异常,请重试")
	});
	fileUploader.on( 'startUpload', function(  ) {
		loadFileUpload=loadMsg();
	});
});

function newsAddForm(parentIndex){
	var s=$("#newsAddForm").validate().form();
	if(s){
		$("#content").html(contentEditor.$txt.html());
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#newsAddForm").serializeArray(),
			url:"${base}/admin/news/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#newsListMain #newsTable').bootstrapTable("refresh");
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
<div style="width:900px;height:650px;padding:15px;">
<form class="form-horizontal" id="newsAddForm">
	<br>
	<div class="form-group">
	    <label class="col-xs-2 control-label">标题</label>
	    <div class="col-xs-10">
	        <input type="text" class="form-control" name="title" id="title" >
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">封面</label>
	    <div class="col-xs-8">
	    	<input type="text" class="form-control" id="cover" name="cover" readOnly >
	    </div>
	    <div class="col-xs-2">
	    	<div id="coverPicker">选择</div>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">简介</label>
	    <div class="col-xs-10">
	    	<input type="text" class="form-control" name="brief" id="brief">
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">来源</label>
	    <div class="col-xs-10">
	    	<input type="text" class="form-control" name="source" id="source">
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">相关推荐</label>
	    <div class="col-xs-10">
	    	<select class="form-control" name="reference" id="reference">
	    		<option value=0>否</option>
	    		<option value=1>是</option>
	    	</select>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">发布日期</label>
	    <div class="col-xs-10">
	    	<input type="text" class="form-control laydate-icon" name="publishTime" id="publishTime" >
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">内容</label>
	    <div class="col-xs-10">
	    	<textarea  style="height:300px;" class="form-control" name="content" id="content"></textarea>
	    </div>
	</div>
</form>
</div>