<script>
$(function(){
	formValidate("#questionTimeAddForm",{
		name:{
			required: true
		},
		startTime:{
			required: true
		},
		endTime:{
			required: true
		}
	});
	laydate({
   		fixed:true,
   		elem: '#startTime',
    	istime: true,
    	format: 'YYYY-MM-DD'
   	});
   	laydate({
   		fixed:true,
   		elem: '#endTime',
    	istime: true,
    	format: 'YYYY-MM-DD'
   	});
})	
function questionTimeAddSubmitForm(parentIndex){
	var s=$("#questionTimeAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#questionTimeAddForm").serializeArray(),
			url:"${base}/admin/question/tsave.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#questionTimeListMain #questionTimeTable').bootstrapTable("refresh");
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

<div style="width:600px;height:400px;padding:15px;">
<form class="form-horizontal" id="questionTimeAddForm">
	<br>
	<div class="form-group">
	    <label class="col-xs-3 control-label">名称</label>
	    <div class="col-xs-9">
	        <textarea type="text" class="form-control" placeholder="名称" name="name" id="name"></textarea>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">类型</label>
	    <div class="col-xs-9">
	        <select class="form-control" placeholder="适用对象" name="type" id="type">
	        	<option value='geren'>个人</option>
	        	<option value='qiye'>机构</option>
	        </select>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">开始时间</label>
	    <div class="col-xs-9">
	    	<input type="text" class="form-control laydate-icon" name="startTime" id="startTime" >
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-3 control-label">结束时间</label>
	    <div class="col-xs-9">
	    	<input type="text" class="form-control laydate-icon"  name="endTime" id="endTime" >
	    </div>
	</div>
</form>
</div>