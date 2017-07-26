<script>
$(function(){
	formValidate("#roleAddForm",{
		name:{
			required: true
			},
		status:{
			required: true
		}
            
	})
	$('#roleAddForm #frmt').jstree({
		'core': {'data' : ${jsTree}},
		"checkbox" : {
      		"keep_selected_style" : false
    	},
    	"plugins" : [ "checkbox" ]
	});
})	

function memberSubmitForm(parentIndex){
	var t=$('#roleAddForm #frmt').jstree().get_checked();
	if(t.length==0){
		alertMsg("必须填写权限",0);
		return;
	}
	var s=$("#roleAddForm").validate().form();
	if(s){
		var o=loadMsg();
		var datas=$("#roleAddForm").serializeArray();
		var permissionIds={name:"permissionIds",value:t};
		datas.push(permissionIds);
		$.ajax({
			type:"post",
			dataType:"json",
			data:datas,
			url:"${base}/admin/role/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('添加成功', 1);
					$('#role_list_main_table').bootstrapTable("refresh");
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

<div style="width:600px;height:450px;padding:15px;overflow:auto;">
<form class="form-horizontal" id="roleAddForm">
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">角色名</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="用户名" name="name" id="name" value="">
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
			<div class="form-group">
			    <label class="col-xs-3 control-label">权限</label>
			    <div class="col-xs-5">
			        <div id="frmt"></div>
			    </div>
			</div>
</form>
</div>