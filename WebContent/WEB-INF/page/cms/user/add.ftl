<script>
$(function(){
	formValidate("#userAddForm",{
		userNo:{
			required: true
		},
		password:{
			required: true
		}
	})

})	

function fundSubmitForm(parentIndex){
	var s=$("#userAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#userAddForm").serializeArray(),
			url:"${base}/admin/user/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('添加成功', 1);
					$('#userListMain #userTable').bootstrapTable("refresh")
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

<div style="width:600px;height:500px;padding:15px;overflow:auto;">
<form class="form-horizontal" id="userAddForm">
			<div class="form-group">
			    <label class="col-xs-3 control-label">公司</label>
			    <div class="col-xs-5">
			       <select name="companyId" id="companyId" class="form-control">
                    		[#list companys as co]
                    		<option value="${co.id}">${(co.companyAbbr)!}</option>
                    		[/#list]
                   </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">账户类型</label>
			    <div class="col-xs-5">
			        <select class="form-control" name="type" id="type">
                          [#list userTypes as sta]
                               <option value="${sta}">${sta.description}</option>
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
			    <label class="col-xs-3 control-label">姓名</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="姓名" name="name" id="name" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">性别</label>
			    <div class="col-xs-5">
			    	<select  class="form-control" name="sex" id="sex">
			    		<option value="">未知</option>
			    		<option value="0">男</option>
			    		<option value="1">女</option>
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">证件类型</label>
			    <div class="col-xs-5">
			    	<select class="form-control" name="cardType" id="cardType">
                                                [#list cardTypes as sta]
                                                        <option value="${sta}">${sta.description}</option>
                                                [/#list]
					                    </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">证件号码</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="账户号码" name="cardNo" id="cardNo" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">邮编</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="邮编" name="zip" id="zip" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">地址</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="地址" name="address" id="address" value="">
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">手机</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="手机" name="phone" id="phone" value="">
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">座机</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="座机" name="tel" id="tel" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">邮箱</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="邮箱" name="email" id="email" value="">
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">密码</label>
			    <div class="col-xs-5">
			        <input type="password" class="form-control" placeholder="密码" name="password" id="password" value="">
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">交易密码</label>
			    <div class="col-xs-5">
			        <input type="password" class="form-control" placeholder="密码" name="tradePassword" id="tradePassword" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">状态</label>
			    <div class="col-xs-5">
			    	<select  class="form-control" name="status" id="status">
			    		[#list status as s]
			    			<option value="${s}">${s.description}</option>
			    		[/#list]
			    	</select>
			    </div>
			</div>
			
</form>
</div>