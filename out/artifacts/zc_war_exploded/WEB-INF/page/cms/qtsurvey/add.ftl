<script>
$(function(){
	formValidate("#qtSurveyAddForm",{
		name:{
			required: true
		},
		startTime:{
			required: true
		},
		endTime:{
			required: true
		}
	});
	laydateToId('startTime');
   	laydateToId('endTime');
})	
function qtSurveyAddSubmitForm(parentIndex){
	var s=$("#qtSurveyAddForm").validate().form();
	if(s){
		var st = $("#startTime").val().replace(new RegExp(/(-)/g),"");
		var et = $("#endTime").val().replace(new RegExp(/(-)/g),"");
		if(st > et){
			alertMsg("结束日期必须大于开始日期!");
			return false;
		}
		
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#qtSurveyAddForm").serializeArray(),
			url:"${base}/admin/qtSurvey/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加调查问卷成功');
					$('#qtSurveyListMain #qtSurveyTable').bootstrapTable("refresh");
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
<form class="form-horizontal" id="qtSurveyAddForm">
	<br>
	<div class="form-group">
	    <label class="col-xs-3 control-label">名称</label>
	    <div class="col-xs-9">
	        <textarea type="text" class="form-control" placeholder="名称" name="name" id="name"></textarea>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">开始日期</label>
	    <div class="col-xs-9">
	    	<input type="text" class="form-control laydate-icon" name="startTime" id="startTime">
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">结束日期</label>
	    <div class="col-xs-9">
	    	<input type="text" class="form-control laydate-icon"  name="endTime" id="endTime">
	    </div>
	</div>
</form>
</div>