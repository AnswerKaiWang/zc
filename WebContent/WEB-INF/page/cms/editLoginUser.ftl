<script>
$(function(){
	
})	

function loginMemberSubmitForm(parentIndex){
	var s=$("#loginMemberAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#loginMemberAddForm").serializeArray(),
			url:"${base}/admin/member/updateLoginMember.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
					top.location.href="${base}/admin/main.htm"
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

<div style="width:500px;height:300px;padding:15px;overfolw:auto;">
<form class="form-horizontal" id="loginMemberAddForm">
			<div class="form-group">
			    <label class="col-xs-3 control-label">用户名</label>
			    <div class="col-xs-7">
			    	<div class="form-control active">${member.userName}</div>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">原密码</label>
			    <div class="col-xs-7">
			        <input type="password" class="form-control" placeholder="新密码框不输入,此框填写无效" name="oldPassword" id="oldPassword" value="">
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">新密码</label>
			    <div class="col-xs-7">
			        <input type="password" class="form-control" placeholder="新密码/不输入不修改" name="newPassword" id="newPassword" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">确认新密码</label>
			    <div class="col-xs-7">
			        <input type="password" class="form-control" placeholder="新密码框不输入,此框填写无效" name="reNewPassword" id="reNewPassword" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">邮箱</label>
			    <div class="col-xs-7">
			    	<input type="text" class="form-control" placeholder="邮箱" name="email" id="email" value="${(member.email)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">姓名</label>
			    <div class="col-xs-7">
			    	<input type="text" class="form-control" placeholder="姓名" name="realName" id="realName" value="${(member.realName)!}">
			    </div>
			</div>
</form>
</div>