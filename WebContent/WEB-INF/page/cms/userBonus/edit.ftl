<script>
$(function(){
	formValidate("#userBonusAddForm",{
		cardNo:{
			required: true
		},
		okTime:{
			required: true
		},oneMoney:{
			required: true,
			number:true,
			dec:2,
			min:0
		},share:{
			required: true,
			number:true,
			dec:0,
			min:0
		},totalMoney:{
			required: true,
			number:true,
			dec:2,
			min:0
		},realMoney:{
			number:true,
			dec:2,
			min:0
		}
	})
laydate({
   		fixed:true,
   		elem: '#userBonusAddOkTime',
    	istime: true,
    	format: 'YYYY-MM-DD'
   	});
laydate({
   		fixed:true,
   		elem: '#userBonusAddDengjiTime',
    	istime: true,
    	format: 'YYYY-MM-DD'
   	});
laydate({
   		fixed:true,
   		elem: '#userBonusAddSendTime',
    	istime: true,
    	format: 'YYYY-MM-DD'
   	});
})	

function userBonusSubmitForm(parentIndex){
	var s=$("#userBonusAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#userBonusAddForm").serializeArray(),
			url:"${base}/admin/userBonus/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
					$('#userBonusListMain #userBonusTable').bootstrapTable("refresh")
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
<form class="form-horizontal" id="userBonusAddForm">
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">基金</label>
			    <div class="col-xs-5">
			        ${(fund.name)!}
			          <input type="hidden"  name="id" value="${(userBonus.id)!}">
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">证件号码</label>
			    <div class="col-xs-5">
			         ${(user.name)!}--${(user.cardNo)!}
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">分红方式</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="分红方式" name="type" id="type" value="${(userBonus.type)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">确认时间</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control laydate-icon" placeholder="确认时间" name="okTime" id="userBonusAddOkTime" value="${(userBonus.okTime)!?string("yyyy-MM-dd")}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">登记时间</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control laydate-icon" placeholder="登记时间" name="dengjiTime" id="userBonusAddDengjiTime" value="${(userBonus.dengjiTime)!?string("yyyy-MM-dd")}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">发放时间</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control laydate-icon" placeholder="发放时间" name="sendTime" id="userBonusAddSendTime" value="${(userBonus.sendTime)!?string("yyyy-MM-dd")}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">分红基数份额</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="分红基数份额" name="share" id="share" value="${userBonus.share}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">每单位分红额</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="每单位分红额" name="oneMoney" id="oneMoney" value="${money(userBonus.oneMoney)}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">应发红利</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="应发红利" name="totalMoney" id="totalMoney" value="${money(userBonus.totalMoney)}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">实发红利</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="实发红利" name="realMoney" id="realMoney" value="${money(userBonus.realMoney)}">
			    </div>
			</div>
</form>
</div>