<script>
$(function(){
	$('#custFileListMain #custFileTable').bootstrapTable({
        url:'${base}/admin/userSecond/per/file/list.htm',
        queryParams:function(params){
        	$.each($("#custFileListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [
        {field: 'state', checkbox: true},
        {field: 'custName', title: '客户名称', align: 'center'},
        {field: 'custNo', title: '身份证/营业执照', align: 'center'},
        {field: 'cardTypeName', title: '证照类型', align: 'center', sortable:"true"},
        {field: 'picName', title: '文件名称', align: 'center'},
        {field: 'validateTime', title: '有效期', align: 'center'},
        {field: 'createTime',title: '发布时间', align: 'center', sortable:"true"},
        {   
            field:'id',
        	title: '操作',
       		align: 'center',
        	formatter:function(value,row){
        		var html="";
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editFile(\''+value+'\')">修改</a>&nbsp';
				html=html+'<a class="btn btn-primary btn-xs" onclick="deleteFile(\''+value+'\')">删除</a>&nbsp';
				return html;
            }
        }],
        sortName:"createTime",
        sortOrder:"desc"
    });
    laydateToId('startTime');
    laydateToId('endTime');         
 	$("#fundFileListSearch").click(function(){
		$('#custFileListMain #custFileTable').bootstrapTable("refresh")
	})
	
	$("#custFileListMain #custFileAdd").click(function(){
		 openWindows("添加客户文件","${base}/admin/userSecond/per/file/add.htm",null,
		 function(index,layero){
		 	custSubmitForm(index)
		 });
	});
	$("#custFileListForm #userSecondId").select2({
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
function editFile(value){
		openWindows("修改证照","${base}/admin/userSecond/per/file/edit.htm",{id:value},
	 	function(index,layero){
	 		custSubmitForm(index)
	 	});
}
function deleteFile(value){
	layer.alert("确认要删除吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/userSecond/per/file/delete.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					alertMsg('删除成功', 1);
					$('#custFileListMain #custFileTable').bootstrapTable("refresh")
				}else{
					alertMsg(data.error,0)
				}
			},error:function(){
				closeMsg(o);
				alertMsg("系统异常,请重试")
			}
		})
	})
}
function deletePicSingle(value){
	layer.alert("确认要删除吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/userSecond/per/file/delete.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					alertMsg('删除成功', 1);
					//删除
					
				}else{
					alertMsg(data.error,0)
				}
			},error:function(){
				closeMsg(o);
				alertMsg("系统异常,请重试")
			}
		})
	})
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="custFileListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="custFileAdd">添加</button>
        	<button type="button" class="btn btn-primary fa fa-plus" id="custFileImp">导入</button>
        </div>
        <div class="ibox-content">
            	<form class="form-horizontal" id="custFileListForm" method="post" onsubmit="return false">
    			<div class="row" style="margin-bottom: 10px;">
        			<div class="col-md-6">
        			<button type="button" class="btn btn-primary fa fa-search" id="fundFileListSearch">查询</button>
        			</div>
        		</div>
    			<div class="row" style="margin-bottom: 10px;">
    				<div class="col-md-4">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">客户姓名</span>
		            		<select class="form-control" name="userSecondId" id="userSecondId"></select>
		                </div>
		        	</div>
    				<div class="col-md-4">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">证件号</span>
		                    <input type="text" class="form-control" name="cardNo" id="cardNo">
		                </div>
		        	</div>
		        	<div class="col-md-4">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">证照类型</span>
		                   <select class="form-control" name="cardType" id="cardType">
		            			<option value="">全部</option>
		            			[@dict name="zhengzhaotype" ]
		                    	[#list dictList as st]
		                    		<option value="${st.id}">${st.name}</option>
		                    	[/#list]
		                    	[/@dict]
		            		</select>
		                </div>
		        	</div>
		        </div>
		        <div class="row" style="margin-bottom: 10px;">
		        	<div class="col-md-4">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">文件名称</span>
		                    <input type="text" class="form-control" name="fileName" id="fileName">
		                </div>
		        	</div>
		        	<div class="col-md-8">
		            	<div class="input-group input-group-sm">
                    	<span class="input-group-addon">到期日期</span>
                    	<input type="text" class="form-control laydate-icon" name="startTime" id="startTime" >
                    	<span class="input-group-addon">到</span>
                    	<input type="text" class="form-control laydate-icon" name="endTime" id="endTime">
                		</div>
		        	</div>
   		 		</div>
				</form>
				<table class="table table-bordered" id="custFileTable" ></table>
        </div>
	</div>
</div>
