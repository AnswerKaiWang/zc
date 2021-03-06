<script>
$(function(){
	formValidate("#appointmentEditForm",{
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
	$("#appointmentEditForm #fundId").select2({
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
  	$("#appointmentEditForm #userSecondId").select2({
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
  	$("#appointmentEditForm #fundId").append("<option value='${appointment.fundId}' selected>${appointment.fundName}</option>");
  	$("#appointmentEditForm #select2-fundId-container").html('${appointment.fundName}');
  	$("#appointmentEditForm #userSecondId").append("<option value='${appointment.userSecondId}' selected>${appointment.custName}</option>");
  	$("#appointmentEditForm #select2-userSecondId-container").html('${appointment.custName}');
  	
  	bindFileSelect();
});
var rowNum = ${appointment.files?size};;
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

function bindFileSelect(){
	$("#appointmentEditForm div[id^='fileSelect_']").each(function(index,ele){
		var ids = $(ele).attr("id");
		if(!!ids){
			//获得序号
			var ind = ids.substring(11,ids.length);
			addFileClik('${base}/admin/fileUpload.htm','fileSelect_'+ind,'fileSpan_'+ind,'input_'+ind);
		}
	});
}

function delRecord(index){
	var row = $("#record_"+index).parent();
	if(!!row){
		row.remove();
	}
}
function appointmentEditForm(parentIndex){
	var s=$("#appointmentEditForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#appointmentEditForm").serializeArray(),
			url:"${base}/admin/appointment/update.htm",
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
<form class="form-horizontal" id="appointmentEditForm">
	<input type="hidden" name="id" value="${(appointment.id)!}">
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
			    	<input type="text" class="form-control" name="ano" id="ano" value="${(appointment.ano)!}" >
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">合同状态</label>
			    <div class="col-xs-9">
			    	<select class="form-control"  name="astatus" id="astatus">
				    		<option value=1 [#if 1==appointment.astatus]selected=selected[/#if]>正常</option>
				    		<option value=0 [#if 0==appointment.astatus]selected=selected[/#if]>作废</option>
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">备注</label>
			    <div class="col-xs-9">
			    	<textarea class="form-control" name="remark" id="remark">${(appointment.remark)!}</textarea>
			    </div>
			</div>
		</div>
		<div class="tab-pane fade" id="appointmentFileTarget">
			<br>
			<div class="form-group">
			    <label class="col-xs-3 control-label">文件名称</label>
			    <label class="col-xs-8 control-label"></label>
			    <label class="col-xs-1 control-label" id="addRecord" style="cursor:pointer;">+</label>
			</div> 
			[#list appointment.files as f]
			<div class="form-group">
			    <div class="col-xs-3"><input type="text" class="form-control" placeholder="文件名称" name="files[${f_index}].name" value="${(f.name)!}"></div>
			    <div class="col-xs-6">
			    	<input type="hidden" name="files[${f_index}].filePath" id="input_${f_index}" value="${(f.filePath)!}">
			    	<div id="fileSpan_${f_index}">
			    		<a href='${base}${(f.filePath)!}' target='_blank'>${(f.filePath)!}</a>
			    	</div>
			    </div>
			     <label class="col-xs-2 control-label">
			    	<div id="fileSelect_${f_index}">选择</div>
			    </label>
			    <div class="col-xs-1" style="cursor:pointer;" id="record_${f_index}" onclick="javascript:delRecord(${f_index});">-</div>
			</div>
			[/#list]
		</div>
	</div>
</form>
</div>