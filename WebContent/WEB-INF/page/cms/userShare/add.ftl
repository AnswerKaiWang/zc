<script>
$(function(){
	formValidate("#userShareAddForm",{
		cardNo:{
			required: true
		},
		okTime:{
			required: true
		},money:{
			required: true,
			number:true,
			dec:2,
			min:0
		},fundAccountMoney:{
			required: true,
			number:true,
			dec:4,
			min:0
		},share:{
			required: true,
			number:true,
			dec:0,
			min:0
		}
	})
laydate({
   		fixed:true,
   		elem: '#userShareAddOkTime',
    	istime: true,
    	format: 'YYYY-MM-DD'
   	});
})	

function userShareSubmitForm(parentIndex){
	var s=$("#userShareAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#userShareAddForm").serializeArray(),
			url:"${base}/admin/userShare/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#userShareListMain #userShareTable').bootstrapTable("refresh")
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
<form class="form-horizontal" id="userShareAddForm">
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">基金</label>
			    <div class="col-xs-5">
			        <select class="form-control" name="fundId" id="fundId">
					      [#list funds as f]
					     <option value="${f.id}">${f.name}</option>
					      [/#list]
					</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">基金账户</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="基金账户" name="userNo" id="userNo" value="">
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">证件号码</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="证件号码" name="cardNo" id="cardNo" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">业务类型</label>
			    <div class="col-xs-5">
			    	<select  class="form-control" name="type" id="type">
			    		[#list orderTypes as s]
			    			<option value="${s}">${s.description}</option>
			    		[/#list]
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">确认时间</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control laydate-icon" placeholder="确认时间" name="okTime" id="userShareAddOkTime" value="${.now?string("yyyy-MM-dd")}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">单位净值</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="单位净值" name="fundAccountMoney" id="fundAccountMoney" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">确认份额</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="确认份额" name="share" id="share" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">认购金额</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="认购金额" name="money" id="money" value="">
			    </div>
			</div>
</form>
</div>