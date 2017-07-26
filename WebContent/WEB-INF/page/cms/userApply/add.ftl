<script>
$(function(){
	formValidate("#userApplyAddForm",{
		fundId:{
			required: true
		},
		userSecondId:{
			required: true
		}
	});
	
	$("#userApplyAddForm #fundId").select2({
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
  	$("#userApplyAddForm #userSecondId").select2({
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
});	
function userApplyAddForm(parentIndex){
	var s=$("#userApplyAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#userApplyAddForm").serializeArray(),
			url:"${base}/admin/userApply/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('添加成功', 1);
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
<div style="width:600px;height:500px;padding:15px;">
<form class="form-horizontal" id="userApplyAddForm">
		<div class="tab-pane fade in active" id="userApplyAddBaseInfo">
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
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
			        </select>
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">预约金额</label>
			    <div class="col-xs-8">
			        <input type="text" class="form-control" placeholder="预约金额" name="applyMoney" id="applyMoney">
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">确认金额(元)</label>
			    <div class="col-xs-8">
			        <input type="text" class="form-control" placeholder="确认金额(元)" name="confirMoney" id="confirMoney">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">预约状态</label>
			    <div class="col-xs-8">
			    	<select  class="form-control" name="applyStatus" id="applyStatus">
			    		[@dict name="yuYueStatus" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">备注</label>
			    <div class="col-xs-8">
			        <textarea type="text" class="form-control" placeholder="备注" name="note" id="note"></textarea>
			    </div>
			</div>
		</div>
</form>
</div>