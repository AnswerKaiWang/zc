<script>
$(function(){
	formValidate("#userApplyConfirmForm",{
		confirMoney:{
			required: true
		}
	});
	
	$("#applyMoney").val(fmtCurrency($("#applyMoney").val()));
	$("#maxValue").val(fmtCurrency($("#maxValue").val()));
});
function userApplyConfirmForm(parentIndex){
	var s=$("#userApplyConfirmForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#userApplyConfirmForm").serializeArray(),
			url:"${base}/admin/userApply/updateStatus.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('修改成功', 1);
					$('#userApplyListMain #userApplyTable').bootstrapTable("refresh")
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
<div style="width:600px;height:300px;padding:15px;">
<form class="form-horizontal" id="userApplyConfirmForm">
	<div class="tab-pane fade in active" id="userApplyAddBaseInfo">
		<input type="hidden"  name="id" id="id" value="${(userApply.id)!}">
		<div class="form-group">
			<label class="col-xs-4 control-label">剩余额度(元)</label>
		    <div class="col-xs-8">
		    	<input type="text" class="form-control" readOnly name="maxValue" id="maxValue" value="${amount.remain}">
		    </div>
		</div>
		<div class="form-group">
		    <label class="col-xs-4 control-label">预约人</label>
		    <div class="col-xs-8">
		        <input type="text" class="form-control" readOnly
		         name="userSecondId" id="userSecondId" value="${userSecond.name}">
		    </div>
		</div>
		<div class="form-group">
		    <label class="col-xs-4 control-label">预约金额(元)</label>
		    <div class="col-xs-8">
		        <input type="text" class="form-control" readOnly 
		         name="applyMoney" id="applyMoney" value="${userApply.applyMoney}">
		    </div>
		</div>
    	<div class="form-group">
		    <label class="col-xs-4 control-label">确认金额(元)</label>
		    <div class="col-xs-8">
		        <input type="text" class="form-control" 
		         name="confirMoney" id="confirMoney" value="${userApply.applyMoney}">
		    </div>
		</div>
	</div>
</form>
</div>