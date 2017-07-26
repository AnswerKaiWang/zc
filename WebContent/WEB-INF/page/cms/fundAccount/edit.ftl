<script>

$(function(){
	formValidate("#fundAccountAddForm",{
		fundId:{
			required: true
		},
		beginTime:{
			required: true
		},money:{
			required: true,
			number:true,
			dec:4,
			min:0
		}
            
	})
   	 laydate({
   		fixed:true,
   		elem: '#fundAccountAddBeginTime',
    	istime: true,
    	format: 'YYYY-MM-DD'
   	});
})	

function fundSubmitForm(parentIndex){
	var s=$("#fundAccountAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#fundAccountAddForm").serializeArray(),
			url:"${base}/admin/fundAccount/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
					$('#fundAccountListMain #fundAccountTable').bootstrapTable("refresh");
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

<div style="width:600px;height:500px;padding:15px;">
<form class="form-horizontal" id="fundAccountAddForm">
	
		<div class="tab-pane fade in active" id="fundAddBaseInfo">
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">基金</label>
			    <div class="col-xs-5">
			        <select class="form-control" name="fundId" id="fundId">
					      [#list funds as f]
					     <option value="${f.id}" [#if fundAccount.fundId==f.id]selected=selected[/#if]>${f.name}</option>
					      [/#list]
					</select>
					<input name="id" type="hidden" value="${(fundAccount.id)!}" />
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">发布时间</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control laydate-icon" placeholder="发布时间" name="beginTime" id="fundAccountAddBeginTime" value="${(fundAccount.beginTime)?string("yyyy-MM-dd")}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">金额</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="金额" name="money" id="money" value="${money4(fundAccount.money)}">
			    </div>
			</div>
		</div>
</form>
</div>