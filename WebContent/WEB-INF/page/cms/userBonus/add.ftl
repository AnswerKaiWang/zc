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
			url:"${base}/admin/userBonus/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
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
			    <label class="col-xs-3 control-label">分红方式</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="分红方式" name="type" id="type" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">分红日期</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control laydate-icon" placeholder="确认时间" name="okTime" id="userBonusAddOkTime" value="${.now?string("yyyy-MM-dd")}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">登记时间</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control laydate-icon" placeholder="登记时间" name="dengjiTime" id="userBonusAddDengjiTime" value="${.now?string("yyyy-MM-dd")}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">发放时间</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control laydate-icon" placeholder="发放时间" name="sendTime" id="userBonusAddSendTime" value="${.now?string("yyyy-MM-dd")}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">分红基数份额</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="分红基数份额" name="share" id="share" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">每单位分红额</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="每单位分红额" name="oneMoney" id="oneMoney" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">应发红利</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="应发红利" name="totalMoney" id="totalMoney" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">实发红利</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="实发红利" name="realMoney" id="realMoney" value="">
			    </div>
			</div>
</form>
</div>