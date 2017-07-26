<script>
$(function(){
	formValidate("#appointmentAddForm",{
		fundId:{
			required: true
		},
		userSecondId:{
			required: true
		}
	});
   	$("#addRecord").on("click",function(){
		//添加一行
		addRow();
	});
  	$("#appointmentAddForm #fundId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/fund/searchFundList.htm",
	    	dataType: 'json',
	    	delay: 250,
	    	cache: false,
	    	type: 'POST',
	    	data: function (params) {
	      		return {search: params.term,memberType:'caifuguwen'}
	    	},
	    	processResults: function (data, page) { 
	    			return {results: data}
	    	}  
    	}
  	});
  	$("#appointmentAddForm #userSecondId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/userSecond/searchCustList.htm",
	    	dataType: 'json',
	    	delay: 250,
	    	cache: false,
	    	type: 'POST',
	    	data: function (params) {
	      		return {search: params.term}
	    	},
	    	processResults: function (data, page) { 
	    			return {results: data}
	    	}  
    	}
  	});
})	
var rowNum = 0;
function addRow(){
	rowNum = rowNum+1;
	var row = '<div class="form-group">'
			    +'<div class="col-xs-3"><input type="text" class="form-control" placeholder="文件名称" name="files['+rowNum+'].name"></div>'
			    +'<div class="col-xs-6">'
			    	+'<input type="hidden" name="files['+rowNum+'].filePath" id="input_'+rowNum+'">'
			    	+'<div id="fileSpan_'+rowNum+'">'
			    	+'</div>'
			    +'</div>'
			    +'<label class="col-xs-2 control-label"><div id="fileSelect_'+rowNum+'">选择</div></label>'
			    +'<div class="col-xs-1" style="cursor:pointer;" id="record_'+rowNum+'" onclick="javascript:delRecord('+rowNum+');">-</div>'
			+'</div>';
	$("#appointmentFileTarget").append(row);
	//重新绑定点击事件
	addFileClik('${base}/admin/fileUpload.htm','fileSelect_'+rowNum,'fileSpan_'+rowNum,'input_'+rowNum);
}
function delRecord(index){
	var row = $("#record_"+index).parent();
	if(!!row){
		row.remove();
	}
}
function appointmentAddForm(parentIndex){
	var s=$("#appointmentAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#appointmentAddForm").serializeArray(),
			url:"${base}/admin/appointment/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#appointmentListMain #appointmentTable').bootstrapTable("refresh");
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
<form class="form-horizontal" id="appointmentAddForm">
	<ul id="myTab" class="nav nav-tabs">
	   	 <li class="active"><a href="#appointmentTarget" data-toggle="tab">合同信息</a></li>
	   	 <li><a href="#appointmentFileTarget" data-toggle="tab">合同附件</a></li>
	</ul>
	<div class="tab-content">
		<div class="tab-pane fade in active" id="appointmentTarget">
			<br>
			<div class="form-group">
			    <label class="col-xs-3 control-label">产品</label>
			    <div class="col-xs-9">
			        <select type="text" class="form-control" name="fundId" id="fundId">
			        	
			        </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">客户</label>
			    <div class="col-xs-9">
			    	<select class="form-control" id="userSecondId" name="userSecondId" >
                	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">合同编号</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" name="ano" id="ano" >
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">合同状态</label>
			    <div class="col-xs-9">
			    	<select class="form-control"  name="astatus" id="astatus">
			    		<option value=1>正常</option>
			    		<option value=0>作废</option>
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">备注</label>
			    <div class="col-xs-9">
			    	<textarea class="form-control" name="remark" id="remark"></textarea>
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="appointmentFileTarget">
			<br>
			<div class="form-group">
			    <label class="col-xs-3 control-label">文件名称</label>
			    <label class="col-xs-6 control-label">文件路径</label>
			    <label class="col-xs-2 control-label">选择</label>
			    <label class="col-xs-1 control-label" id="addRecord" style="cursor:pointer;">+</label>
			</div> 
		</div>
	</div>
</form>
</div>