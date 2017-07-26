<script>
$(function(){
	formValidate("#qtSurveyEditForm",{
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
	laydate({
   		fixed:true,
   		elem: '#startTime',
    	istime: true,
    	format: 'YYYY-MM-DD'
   	});
   	laydate({
   		fixed:true,
   		elem: '#endTime',
    	istime: true,
    	format: 'YYYY-MM-DD'
   	});
})	
function qtSurveyEditSubmitForm(parentIndex){
	var s=$("#qtSurveyEditForm").validate().form();
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
			data:$("#qtSurveyEditForm").serializeArray(),
			url:"${base}/admin/qtSurvey/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
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
<form class="form-horizontal" id="qtSurveyEditForm">
	<input type="hidden" name="id" value="${(survey.id)!}">
	<br>
	<div class="form-group">
	    <label class="col-xs-3 control-label">名称</label>
	    <div class="col-xs-9">
	        <input type="text" class="form-control" placeholder="名称" name="name" id="name" value="${survey.name}">
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">开始日期</label>
	    <div class="col-xs-9">
	    	<input type="text" class="form-control laydate-icon" name="startTime" id="startTime" value="${(survey.startTime?string('yyyy-MM-dd'))!}" >
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">结束日期</label>
	    <div class="col-xs-9">
	    	<input type="text" class="form-control laydate-icon" name="endTime" id="endTime" value="${(survey.endTime)?string('yyyy-MM-dd')}" >
	    </div>
	</div>
</form>
</div>