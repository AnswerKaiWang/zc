<script>
$(function(){
	formValidate("#memberDefaultForm",{
		password:{
			rangelength:[5,10]
		},
		email:{
			email:email
		}
            
	})

})	

function memberSubmitForm(parentIndex){
	var s=$("#memberDefaultForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#memberDefaultForm").serializeArray(),
			url:"${base}/admin/member/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('修改成功',1);
					$('#memberDefaultTable').bootstrapTable("refresh");
				}else{
					alertMsg(data.error,0)
				}
			},error:function(){
				closeMsg(o);
				alertMsg("系统异常,请重试",0)
			}
		})
	}
}
</script>

<div style="width:600px;padding:15px;">
<form class="form-horizontal" id="memberDefaultForm">
			[@shiro.hasPermission name="canSeeCompany"]
			<div class="form-group">
			    <label class="col-xs-3 control-label">公司</label>
			    <div class="col-xs-5">
			         <select class="form-control" name="companyId" id="companyId">
			         		 <option value="" [#if !(member.companyId)??]selected=selected[/#if]>总部</option>
                          [#list companys as sta]
                             <option value="${sta.id}" [#if sta.id==member.companyId]selected=selected[/#if]>${sta.companyAbbr}</option>
                          [/#list]
					 </select>
			    </div>
			</div>
			[/@shiro.hasPermission]
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">登录名称</label>
			    <div class="col-xs-5">
			    	${(member.userName)!}
			        <input type="hidden" class="form-control" name="userName" id="userName" value="${(member.userName)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">密码</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="密码/不填不修改" name="password" id="password" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">姓名</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="姓名" name="realName" id="realName" value="${(member.realName)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">邮箱</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="邮箱" name="email" id="email" value="${(member.email)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">电话</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="电话" name="phone" id="phone" value="${(member.phone)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">性别</label>
			    <div class="col-xs-5">
			    	<select  class="form-control" name="sex" id="sex">
			    		<option value="0" [#if !(member.sex)]selected=selected[/#if]>男</option>
			    		<option value="1" [#if (member.sex)]selected=selected[/#if]>女</option>
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">岗位</label>
			    <div class="col-xs-5">
			    	<select  class="form-control" name="type" id="type">
			    		<option value="" [#if !(member.type)??]selected=selected[/#if]>无</option>
			    		[#list types as s]
			    			<option value="${s}" [#if (member.type)??&&s==member.type]selected=selected[/#if]>${s.description}</option>
			    		[/#list]
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">状态</label>
			    <div class="col-xs-5">
			    	<select  class="form-control" name="status" id="status">
			    		[#list status as s]
			    			<option value="${s}" [#if s==member.status]selected=selected[/#if]>${s.description}</option>
			    		[/#list]
			    	</select>
			    </div>
			</div>
			[@shiro.hasPermission name="canGiveRole"]
			<div class="form-group">
					<label class="col-xs-3 control-label">角色</label>
					<div class="col-xs-5">
			    		[#list roles as s]
			    			[#if s.id!=1]
			    			<input type="checkbox"   name="roleIds"  value="${s.id}" [#if memberRoles.contains(s)]checked=ckecked[/#if]>${s.name}
			    			[/#if]
			    		[/#list]
			    </div>
			</div>
			[/@shiro.hasPermission]
</form>
</div>