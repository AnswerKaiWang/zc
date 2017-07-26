<script>
$(function(){
	formValidate("#fundRiskBearAddForm",{
		riskLevel:{
			required: true
		},
		riskNature:{
			required: true
		}
	});
	$("#fundRiskBearAddForm #riskId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/risk/searchRiskList.htm",
	    	dataType: 'json',
	    	delay: 250,
	    	cache: false,
	    	type: 'POST',
	    	data: function (params) {
	      		return {search: params.term}
	    	},
	    	processResults: function (data, page) { 
	    		return {results: data}
	    	}  
    	}
  	});
});
function fundRiskBearAddForm(parentIndex){
	var s=$("#fundRiskBearAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#fundRiskBearAddForm").serializeArray(),
			url:"${base}/admin/risk/bear/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#fundRiskBearListMain #fundRiskBearTable').bootstrapTable("refresh");
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
<form class="form-horizontal" id="fundRiskBearAddForm">
	<br>
	<div class="form-group">
	    <label class="col-xs-3 control-label">风险偏好总得分</label>
	    <div class="col-xs-4">
	        <input type="text" class="form-control" name="scoreMin" id="scoreMin">
	    </div>
	    <div class="col-xs-1">
	       	至
	    </div>
	    <div class="col-xs-4">
	        <input type="text" class="form-control" name="scoreMax" id="scoreMax">
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">风险承受能力类型</label>
	    <div class="col-xs-9">
	    	<input type="text" class="form-control" name="riskBear" id="riskBear">
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">您可以接受的情况</label>
	    <div class="col-xs-9">
	    	<textarea class="form-control" name="riskNotification" id="riskNotification" ></textarea>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">适合的产品风险等级</label>
	    <div class="col-xs-9">
	    	<select class="form-control" name="riskId" id="riskId" ></select>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">适合的产品风险范围</label>
	    <div class="col-xs-9">
	    	<textarea class="form-control" name="suitRiskArea" id="suitRiskArea" ></textarea>
	    </div>
	</div>
</form>
</div>