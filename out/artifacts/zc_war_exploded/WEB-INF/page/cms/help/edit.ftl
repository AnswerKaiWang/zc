<script>
$(function(){
	formValidate("#helpAddForm",{
		name:{
			required: true
			},
		value:{
			required: true
		},
		pageIndex:{
			required: true,
			digits:true
		}
            
	})
})	

function helpSubmitForm(parentIndex){
	var s=$("#helpAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#helpAddForm").serializeArray(),
			url:"${base}/admin/help/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
					$('#helpListMain #helpTable').bootstrapTable("refresh");
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
<form class="form-horizontal" id="helpAddForm">
			<div class="form-group">
			    <label class="col-xs-3 control-label">公司</label>
			    <div class="col-xs-5">
			         <select class="form-control" name="companyId" id="companyId">
                          [#list companys as sta]
                             <option value="${sta.id}" [#if sta.id==help.companyId]selected=selected[/#if]>${sta.companyAbbr}</option>
                          [/#list]
					 </select>
			    </div>
			</div>
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">帮助名称</label>
			    <div class="col-xs-5">
			        <input type="text" class="form-control" placeholder="帮助名称" name="name" id="name" value="${(help.name)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">帮助内容</label>
			    <div class="col-xs-5">
			    	<textarea class="form-control" placeholder="帮助内容" name="value" id="value" style="height:200px;">${(help.value)!}</textarea>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">帮助类型</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="帮助类型" name="type" id="type" value="${(help.type)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">排序编号</label>
			    <div class="col-xs-5">
			    	<input type="text" class="form-control" placeholder="排序编号" name="pageIndex" id="pageIndex" value="${(help.pageIndex)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">是否显示</label>
			    <div class="col-xs-5">
			    	<select name="showStatus" id="showStatus" class="form-control">
			    		<option value="0" [#if help.showStatus==0]selected=selected[/#if]>显示</option>
			    		<option value="1" [#if help.showStatus==1]selected=selected[/#if]>隐藏</option>
			    	</select>
			    </div>
			</div>
</form>
</div>