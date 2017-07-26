<script>
$(function(){
	$('#fundFileListMain #fundFileTable').bootstrapTable({
                url:'${base}/admin/fundFile/list.htm',
                queryParams:function(params){
                	$.each($("#fundFileListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'fundName',
                    title: '产品名称',
                    align: 'center'
                },{
                    field: 'name',
                    title: '文件名称',
                    align: 'center',
                	formatter:function(value,row){
                		var html="";
                		html=html+'<a class="" href="'+row.url+'" target="_blank">'+row.name+'</a>&nbsp';
						return html;
                    }
                },{
                    field: 'type',
                    title: '文件类型',
                    align: 'center',
                    formatter:function(value){
                    	[#list types as st]
                    		if(value=='${st}'){
                    			return '${st.description}';
                    		}
                    	[/#list]
                    	return "";
                    }
                },{
                    field: 'pageIndex',
                    title: '排序编号',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'showStatus',
                    title: '是否显示',
                    align: 'center',
                	formatter:function(value){
                		if(value==0){
                			return "显示"
                		}
                		return "隐藏"
                    }
                },{
                    field: 'beginTime',
                    title: '发布时间',
                    align: 'center',
                    sortable:"true"
                },{
                	field:'id',
                	title: '操作',
               		align: 'center',
                	formatter:function(value){
                		var html="";
                		[@shiro.hasPermission name="editFundFile"]
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editFundFile(\''+value+'\')">修改</a>&nbsp';
                		[/@shiro.hasPermission]
                		[@shiro.hasPermission name="deleteFundFile"]
						html=html+'<a class="btn btn-primary btn-xs" onclick="deleteFundFile(\''+value+'\')">删除</a>&nbsp';
						[/@shiro.hasPermission]
						return html;
                    }
                }],
                sortName:"beginTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#fundFileListSearch").click(function(){
		$('#fundFileListMain #fundFileTable').bootstrapTable("refresh")
	})
	
	$("#fundFileListMain #fundFileAdd").click(function(){
	 openWindows("添加基金文件","${base}/admin/fundFile/add.htm",null,
	 function(index,layero){
	 	fundSubmitForm(index)
	 });
	})
	
	var start = {
   		fixed:true,
   		elem: '#fundFileStartTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         end.min = data; 
         end.start = data 
    	}
   	}
   	var end={
   		fixed:true,
   		elem: '#fundFileEndTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         start.max = data;
    	}
   	}         
    laydate(start);
    laydate(end);
   
    
})
function fundFileGetFundsByCompanyId(){
	$.ajax({
			type:"post",
			dataType:"html",
			data:{companyId:$("#fundFileListMain #companyId").val()},
			url:"${base}/admin/fund/getFundsByCompanyId.htm",
			success:function(data){
			var html="<option value=''>全部</option>"
				$("#fundFileListMain #fundId").html(html+data)
			}
		})
}
function editFundFile(value){
		openWindows("修改基金","${base}/admin/fundFile/edit.htm",{id:value},
	 	function(index,layero){
	 		fundSubmitForm(index)
	 	});
}
function deleteFundFile(value){
	layer.alert("确认要删除吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/fundFile/delete.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					alertMsg('删除成功', 1);
					$('#fundFileListMain #fundFileTable').bootstrapTable("refresh")
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
<div class="animated fadeInRight" style="width:100%;height:100%;" id="fundFileListMain">
				<div class="ibox">
					<div class="ibox-title">
						[@shiro.hasPermission name="fundFileAdd"]
                    	<button type="button" class="btn btn-primary fa fa-plus" id="fundFileAdd">添加</button>
                    	[/@shiro.hasPermission]
                    </div>
                    <div class="ibox-content">
                        	<form class="form-horizontal" id="fundFileListForm" method="post" onsubmit="return false">
                			<div class="row" style="margin-bottom: 10px;">
                    			<div class="col-md-6">
                    			[@shiro.hasPermission name="canSeeCompany"]
                    			<select name="companyId" id="companyId" style="width:300px;">
                    				<option value="">全部</option>
                    				[#list companys as co]
                    				<option value="${co.id}">${(co.name)!}</option>
                    				[/#list]
                    			</select>
                    			[/@shiro.hasPermission]
                    			<button type="button" class="btn btn-primary fa fa-search" id="fundFileListSearch">查询</button>
                    			</div>
                    		</div>
                			<div class="row" style="margin-bottom: 10px;">
                				<div class="col-md-4">
					            	<div class="input-group input-group-sm">
                                	<span class="input-group-addon">发布日期</span>
                                	<input type="text" class="form-control laydate-icon" name="startTime" id="fundFileStartTime" >
                                	<span class="input-group-addon">到</span>
                                	<input type="text" class="form-control laydate-icon" name="endTime" id="fundFileEndTime">
                            		</div>
					        	</div>
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">产品名称</span>
					            		<input type="text" class="form-control" name="fundName" id="fundName">
					                </div>
					        	</div>
					        </div>
					        <div class="row" style="margin-bottom: 10px;">
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">文件名称</span>
					                    <input type="text" class="form-control" name="name" id="name">
					                </div>
					        	</div>
					      		<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">文件类型</span>
					                   <select class="form-control" name="type" id="type">
					            			<option value="">全部</option>
					            			[#list types as f]
					            			<option value="${f}">${f.description}</option>
					            			[/#list]
					            		</select>
					                </div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="fundFileTable" > </table>
                    </div>
				</div>
</div>
