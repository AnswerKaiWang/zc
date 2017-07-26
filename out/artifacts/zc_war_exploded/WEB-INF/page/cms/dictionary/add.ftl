<script>
$(function(){
	formValidate("#dictionaryAddForm",{
		name:{
			required: true
			}
	})
})	

function dictionarySubmitForm(parentIndex){
	var s=$("#dictionaryAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#dictionaryAddForm").serializeArray(),
			url:"${base}/admin/dictionary/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#dictionaryListMain #dictionaryTable').bootstrapTable("refresh");
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

<div style="width:400px;height:200px;padding:15px;">
<form class="form-horizontal" id="dictionaryAddForm">
			<div class="form-group">
			    <label class="col-xs-3 control-label">类型</label>
			    <div class="col-xs-8">
			         <select class="form-control" name="type" id="type">
                          [#list dictionaryTypes as sta]
                             <option value="${sta}">${sta.description}</option>
                          [/#list]
					 </select>
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">名称</label>
			    <div class="col-xs-8">
			        <input type="text" class="form-control" placeholder="名称/类型下唯一" name="name" id="name" value="">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">备注</label>
			    <div class="col-xs-8">
			    	<input type="text" class="form-control" placeholder="备注" name="note" id="note" >
			    </div>
			</div>
</form>
</div>