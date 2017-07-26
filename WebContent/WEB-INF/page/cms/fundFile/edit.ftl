<script>

$(function(){
	formValidate("#fundAddForm",{
		name:{
			required: true
		},
		fundId:{
			required: true
		},type:{
			required: true
		},
		beginTime:{
			required: true
		},
		pageIndex:{
			required: true,
			digits:true
		}
            
	})
   	 laydate({
   		fixed:true,
   		elem: '#fundAddBeginTime',
    	istime: true
   	});
   	
   	var fundFileUploader = WebUploader.create({
    	// 文件接收服务端。
    	server: '${base}/admin/fileUpload.htm',
    	pick: '#fundFilePicker',
    	auto:true,
    	compress: false
	});
	
	fundFileUploader.on('uploadSuccess', function( file,res) {
		closeMsg(loadFileUpload)
		if(res.status!="00"){
			alertMsg("文件上传异常,请重试")
		}else{
			$("#fundFilePickerName").html("<a href='${base}"+res.url+"' target='_blank'>"+res.url+"</a>")
			$("#fundFileAddFormUrl").val(res.url)
		}
	});
	fundFileUploader.on( 'uploadError', function( file ) {
		closeMsg(loadFileUpload)
    	alertMsg("文件上传异常,请重试")
	});
	fundFileUploader.on( 'startUpload', function(  ) {
		loadFileUpload=loadMsg();
	});
})	

function fundSubmitForm(parentIndex){
	var s=$("#fundAddForm").validate().form();
	if($("#fundFileAddFormUrl").val()==""){
		alertMsg("请先上传文件",0);
		return;
	}
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#fundAddForm").serializeArray(),
			url:"${base}/admin/fundFile/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
					$('#fundFileListMain #fundFileTable').bootstrapTable("refresh")
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

<div style="width:500px;height:380px;padding:15px;">
<form class="form-horizontal" id="fundAddForm">
	
		<div class="tab-pane fade in active" id="fundAddBaseInfo">
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">基金</label>
			    <div class="col-xs-8">
			        <select class="form-control" name="fundId" id="fundId">
					      [#list funds as f]
					     <option value="${f.id}" [#if fundFile.fundId==f.id]selected=selected[/#if]>${f.name}</option>
					      [/#list]
					</select>
					<input name="url" type="hidden" value="${(fundFile.url)!}" id="fundFileAddFormUrl"/>
					<input name="id" type="hidden" value="${(fundFile.id)!}" />
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">文件名称</label>
			    <div class="col-xs-8">
			    	<input type="text" class="form-control" placeholder="文件名" name="name" id="name" value="${(fundFile.name)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">基本信息</label>
			    <div class="col-xs-8">
			    	<textarea class="form-control" placeholder="基本信息" name="contant" id="contant">${(fundFile.contant)!}</textarea>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">文件类型</label>
			    <div class="col-xs-8">
			    	 <select class="form-control" name="type" id="type">
					            			[#list types as f]
					            			<option value="${f}" [#if f=fundFile.type]selected=selected[/#if]>${f.description}</option>
					            			[/#list]
					</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">排序编号</label>
			    <div class="col-xs-8">
			    	<input type="text" class="form-control" placeholder="排序编号" name="pageIndex" id="pageIndex" value="${(fundFile.pageIndex)!}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">是否显示</label>
			    <div class="col-xs-8">
			    	<select name="showStatus" id="showStatus" class="form-control">
			    		<option value="0" [#if fundFile.showStatus==0]selected=selected[/#if]>显示</option>
			    		<option value="1" [#if fundFile.showStatus==1]selected=selected[/#if]>隐藏</option>
			    	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">发布时间</label>
			    <div class="col-xs-8">
			        <input type="text" class="form-control laydate-icon" placeholder="发布时间" name="beginTime" id="fundAddBeginTime" value="${(fundFile.beginTime)!?string("yyyy-MM-dd HH:mm:ss")}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">文件</label>
			    <div class="col-xs-8">
			    	<div id="fundFilePickerName"><a href="${base}${fundFile.url}" target="_blank">${fundFile.url}</a></div>
			    	<div id="fundFilePicker">修改文件</div>
			    </div>
			</div>
		</div>
</form>
</div>