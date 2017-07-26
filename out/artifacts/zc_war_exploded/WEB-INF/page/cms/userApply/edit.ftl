<script>
$(function(){
	formValidate("#userApplyEditForm",{
		fundId:{
			required: true
		},
		userSecondId:{
			required: true
		}
	});
	/***
	$("#userApplyEditForm #fundId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/fund/searchFundList.htm",
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
  	$("#userApplyEditForm #userSecondId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/userSecond/searchCustList.htm",
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
  	**/
  	$("#userApplyEditForm #fundId").append("<option value='${user.fundId}' selected>${user.fundName}</option>");
  	$("#userApplyEditForm #select2-fundId-container").html('${user.fundName}');
  	$("#userApplyEditForm #userSecondId").append("<option value='${user.userSecondId}' selected>${user.custName}</option>");
  	$("#userApplyEditForm #select2-userSecondId-container").html('${user.custName}');
});
function userApplyEditForm(parentIndex){
	var s=$("#userApplyEditForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#userApplyEditForm").serializeArray(),
			url:"${base}/admin/userApply/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('修改成功', 1);
					$('#userApplyListMain #userApplyTable').bootstrapTable("refresh");
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
<form class="form-horizontal" id="userApplyEditForm">
	<div class="tab-pane fade in active" id="userApplyAddBaseInfo">
		<input type="hidden"  name="id" id="id" value="${(user.id)!}">
    	<div class="form-group">
		    <label class="col-xs-3 control-label">产品名称</label>
		    <div class="col-xs-8">
		        <select class="form-control" name="fundId" id="fundId">
		        </select>
		    </div>
		</div>
		<div class="form-group">
		    <label class="col-xs-3 control-label">客户姓名</label>
		    <div class="col-xs-8">
		         <select class="form-control" name="userSecondId" id="userSecondId">
				</select>
		    </div>
		</div>
    	<div class="form-group">
		    <label class="col-xs-3 control-label">预约方式</label>
		    <div class="col-xs-8">
		        <select class="form-control" name="applyWay" id="applyWay">
		        	[@dict name="yuYueType" ]
                	[#list dictList as st]	
                		[#if st.id==user.applyWay]
                			<option value="${st.id}" selected=selected>${st.name}</option>
                		[/#if]
                	[/#list]
                	[/@dict]
		        </select>
		    </div>
		</div>
    	<div class="form-group">
		    <label class="col-xs-3 control-label">预约金额</label>
		    <div class="col-xs-8">
		        <input type="text" class="form-control" placeholder="预约金额" name="applyMoney" id="applyMoney" value="${(user.applyMoney)!}">
		    </div>
		</div>
    	<div class="form-group">
		    <label class="col-xs-3 control-label">确认金额(元)</label>
		    <div class="col-xs-8">
		        <input type="text" class="form-control" placeholder="确认金额(元)" name="confirMoney" id="confirMoney" value="${(user.confirMoney)!}">
		    </div>
		</div>
		<div class="form-group">
		    <label class="col-xs-3 control-label">预约状态</label>
		    <div class="col-xs-8">
		    	<select  class="form-control" name="applyStatus" id="applyStatus">
		    		[@dict name="yuYueStatus" ]
                	[#list dictList as st]
                		<option value="${st.id}" [#if st.id==user.applyStatus]selected=selected[/#if]>${st.name}</option>
                	[/#list]
                	[/@dict]
		    	</select>
		    </div>
		</div>
		<div class="form-group">
		    <label class="col-xs-3 control-label">备注</label>
		    <div class="col-xs-8">
		        <textarea type="text" class="form-control" placeholder="备注" name="note" id="note">${(user.applyMoney)!}</textarea>
		    </div>
		</div>
	</div>
</form>
</div>