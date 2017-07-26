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
			url:"${base}/admin/dictionary/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
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

<div style="width:600px;height:200px;padding:15px;">
<form class="form-horizontal" id="dictionaryAddForm">
			<div class="form-group">
			    <label class="col-xs-3 control-label">类型</label>
			    <div class="col-xs-8">
			         <select class="form-control" name="type" id="type">
                          [#list dictionaryTypes as sta]
                             <option value="${sta}" [#if dictionary.type==sta]selected=selected[/#if]>${sta.description}</option>
                          [/#list]
					 </select>
					 <input type="hidden" value="${dictionary.id}" name="id">
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">名称</label>
			    <div class="col-xs-8">
			        <input type="text" class="form-control" placeholder="名称/类型下唯一" name="name" id="name" value="${dictionary.name}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">备注</label>
			    <div class="col-xs-8">
			    	<input type="text" class="form-control" placeholder="备注" name="note" id="note" value="${dictionary.note}">
			    </div>
			</div>
</form>
</div>