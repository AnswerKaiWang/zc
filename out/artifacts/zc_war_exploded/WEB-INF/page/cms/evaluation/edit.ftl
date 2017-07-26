<script>
$(function(){
	formValidate("#fundRiskEvaluationEditForm",{
		riskLevel:{
			required: true
		},
		riskNature:{
			required: true
		}
	});
});
function fundRiskEvaluationEditForm(parentIndex){
	var s=$("#fundRiskEvaluationEditForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#fundRiskEvaluationEditForm").serializeArray(),
			url:"${base}/admin/risk/evaluation/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#fundRiskEvaluationListMain #fundRiskEvaluationTable').bootstrapTable("refresh");
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
<form class="form-horizontal" id="fundRiskEvaluationEditForm">
	<input type="hidden" name="id" id="id" value="${(evaluation.id)!}">
	<br>
	<div class="form-group">
	    <label class="col-xs-3 control-label">产品风险等级</label>
	    <div class="col-xs-9">
	        <select class="form-control" name="riskLevel" id="riskLevel">
	        	[@dict name="fundRiskLevel" ]
            	[#list dictList as st]
            		<option value="${st.id}" [#if st.id==evaluation.riskLevel]selected=selected[/#if]>${st.name}</option>
            	[/#list]
            	[/@dict]
	        </select>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">产品风险性质</label>
	    <div class="col-xs-9">
	    	<input type="text" class="form-control" name="riskNature" id="riskNature" value="${(evaluation.riskNature)!}">
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">产品风险描述</label>
	    <div class="col-xs-9">
	    	<textarea class="form-control" name="riskIntroduce" id="riskIntroduce" >${(evaluation.riskIntroduce)!}</textarea>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">适合的投资者</label>
	    <div class="col-xs-9">
	    	<textarea class="form-control" name="suitInvestor" id="suitInvestor" >${(evaluation.suitInvestor)!}</textarea>
	    </div>
	</div>
</form>
</div>