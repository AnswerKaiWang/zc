<script>
$(function(){
	formValidate("#userShareAddForm",{
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
			url:"${base}/admin/userShare/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
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
			        ${(fund.name)!}
			          <input type="hidden"  name="id" value="${(userShare.id)!}">
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">用户</label>
			    <div class="col-xs-5">
			    	 ${(user.name)!}--${(user.cardNo)!}
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">类型</label>
			    <div class="col-xs-5">
			    	<select  class="form-control" name="type" id="type">
			    		[#list orderTypes as s]
			    			<option value="${s}" [#if s=userShare.type]selected=selected[/#if]>${s.description}</option>
			    		[/#list]
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">确认时间</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control laydate-icon" placeholder="确认时间" name="okTime" id="userShareAddOkTime" value="${(userShare.okTime)!?string("yyyy-MM-dd")}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">单位净值</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="单位净值" name="fundAccountMoney" id="fundAccountMoney" value="${money4(userShare.fundAccountMoney)}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">确认份额</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="确认份额" name="share" id="share" value="${userShare.share}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">认购金额</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="认购金额" name="money" id="money" value="${money(userShare.money)}">
			    </div>
			</div>
</form>
</div>