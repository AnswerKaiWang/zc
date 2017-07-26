<script>
$(function(){
	formValidate("#fundApplyAddForm",{
		applyMoneyString:{
			digits:true,
			required: true
		}
            
	})
   	 laydate({
   		fixed:true,
   		elem: '#addApplyEndTime',
    	istime: true,
    	format: 'YYYY-MM-DD hh:mm:ss'
   	});
})	

function fundSubmitForm(parentIndex){
	var s=$("#fundApplyAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#fundApplyAddForm").serializeArray(),
			url:"${base}/admin/fund/updateFundApply.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
					$('#fundListMain #fundTable').bootstrapTable("refresh");
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

<div style="width:600px;height:150px;padding:15px;overflow:auto;">
<form class="form-horizontal" id="fundApplyAddForm">
		<input type="hidden" name="fundId" value="${(fundApply.fundId)!}">
			<div class="form-group">
			    <label class="col-xs-3 control-label">可预约金额</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="可预约金额" name="applyMoneyString" id="applyMoneyString" value="${money(fundApply.applyMoney)}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">是否可预约</label>
			    <div class="col-xs-5">
			    	<select name="used" id="used" class="form-control">
			    		<option value="false" [#if !fundApply.used]selected=selected[/#if]>否</option>
			    		<option value="true" [#if fundApply.used]selected=selected[/#if]>是</option>
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">预约结束日期</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control laydate-icon" placeholder="预约结束日期" name="applyEndTime" id="addApplyEndTime" value="[#if (fundApply.applyEndTime)??]${(fundApply.applyEndTime)!?string("yyyy-MM-dd HH:mm:ss")}[/#if]">
			    </div>
			</div>
</form>
</div>