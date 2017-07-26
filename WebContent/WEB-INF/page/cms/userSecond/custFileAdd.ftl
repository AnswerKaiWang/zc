<script>
$(function(){
	formValidate("#custFileAddForm",{
		custId:{
			required: true
		},
		cardTypeId:{
			required: true
		}
	});
   	 laydate({
   		fixed:true,
   		elem: '#picYouxiaoqi',
    	istime: true,
    	format: 'YYYY-MM-DD'
   	});
   	var fileUploader = WebUploader.create({
    	// 文件接收服务端。
    	server: '${base}/admin/fileUpload.htm',
    	pick: '#custFilePicker',
    	auto:true,
    	compress: false
	});
	fileUploader.on('uploadSuccess', function( file,res) {
		closeMsg(loadFileUpload)
		if(res.status!="00"){
			alertMsg("文件上传异常,请重试")
			$("#custFilePickerName").html("")
			$("#picPath").val("")
		}else{
			var pn = $("#custFilePickerName").html();
			var pv = $("#picPath").val();
			if(!pn){
			    pv = res.url;
				pn ="<a href='${base}"+res.url+"' target='_blank'>"+res.url+"</a>";
			}else{
				pn = pn +"<br><a href='${base}"+res.url+"' target='_blank'>"+res.url+"</a>";
				 pv = pv+","+ res.url;
			}
			$("#custFilePickerName").html(pn);
			$("#picPath").val(pv)
		}
	});
	fileUploader.on( 'uploadError', function( file ) {
		closeMsg(fileUploader)
		$("#custFileAddFormUrl").val("")
    	alertMsg("文件上传异常,请重试")
	});
	fileUploader.on( 'startUpload', function(  ) {
		loadFileUpload=loadMsg();
	});
	$("#custFileAddBaseInfo #custId").select2({
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
});	
function custSubmitForm(parentIndex){
	var s=$("#custFileAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#custFileAddForm").serializeArray(),
			url:"${base}/admin/userSecond/per/file/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#custFileListMain #custFileTable').bootstrapTable("refresh")
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
<form class="form-horizontal" id="custFileAddForm">
		<div class="tab-pane fade in active" id="custFileAddBaseInfo">
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">客户名称</label>
			    <div class="col-xs-8">
			        <select class="form-control" name="custId" id="custId">
					</select>
					<input name="picPath" type="hidden" value="" id="picPath"/>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">证照类型</label>
			    <div class="col-xs-8">
			    	<select class="form-control" name="cardTypeId" id="cardTypeId">
			        	[@dict name="zhengzhaotype" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
					</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">名称</label>
			    <div class="col-xs-8">
			    	<input type="text" class="form-control" placeholder="文件名称" name="picName" id="picName">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">有效期</label>
			    <div class="col-xs-8">
					<input type="text" class="form-control" placeholder="有效期" name="picYouxiaoqi" id="picYouxiaoqi">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">备注</label>
			    <div class="col-xs-8">
			    	<textarea class="form-control" placeholder="备注" name="remark" id="remark"></textarea>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">文件</label>
			    <div class="col-xs-8">
			    	<div id="custFilePickerName"></div>
			    	<div id="custFilePicker">选择文件</div>
			    </div>
			</div>
		</div>
</form>
</div>