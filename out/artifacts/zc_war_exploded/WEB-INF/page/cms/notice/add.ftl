<script>
$(function(){
	formValidate("#noticeAddForm",{
		title:{
			required: true
		}
	});
});	
function noticeAddForm(parentIndex){
	var s=$("#noticeAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#noticeAddForm").serializeArray(),
			url:"${base}/admin/notice/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#noticeListMain #noticeTable').bootstrapTable("refresh");
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
<div style="width:600px;height:400px;padding:15px;">
<form class="form-horizontal" id="noticeAddForm">
	<br>
	<div class="form-group">
	    <label class="col-xs-3 control-label">内容</label>
	    <div class="col-xs-9">
	        <textarea class="form-control" name="title" id="title" ></textarea>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">备注</label>
	    <div class="col-xs-9">
	    	<textarea class="form-control" name="content" id="content" ></textarea>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">链接</label>
	    <div class="col-xs-9">
	    	<input type="text" class="form-control" name="url" id="url" >
	    </div>
	</div>
</form>
</div>