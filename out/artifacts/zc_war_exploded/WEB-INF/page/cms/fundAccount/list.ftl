<script>
$(function(){
	var fundAccountTableParams;
	$('#fundAccountListMain #fundAccountTable').bootstrapTable({
                url:'${base}/admin/fundAccount/list.htm',
                queryParams:function(params){
                	$.each($("#fundAccountListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	fundAccountTableParams=params;
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'beginTime',
                    title: '发布日期',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'fundName',
                    title: '产品名称',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'money',
                    title: '单位净值',
                    align: 'right'
                },{
                	field:'id',
                	title: '操作',
               		align: 'center',
                	formatter:function(value){
                		var html="";
                		[@shiro.hasPermission name="editFundAccount"]
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editFundAccount(\''+value+'\')">修改</a>&nbsp';
                		[/@shiro.hasPermission]
                		[@shiro.hasPermission name="deleteFundAccount"]
                		html=html+'<a class="btn btn-primary btn-xs" onclick="deleteFundAccount(\''+value+'\')">删除</a>&nbsp';
                		[/@shiro.hasPermission]
						return html;
                    }
                }],
                sortName:"beginTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#fundAccountListSearch").click(function(){
		$('#fundAccountListMain #fundAccountTable').bootstrapTable("refresh")
	})
	
	$("#fundAccountListMain #fundAccountAdd").click(function(){
	 openWindows("添加净值","${base}/admin/fundAccount/add.htm",null,
	 function(index,layero){
	 	fundSubmitForm(index)
	 });
	})
	
	var start = {
   		fixed:true,
   		elem: '#fundAccountStartTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         end.min = data; 
         end.start = data 
    	}
   	}
   	var end={
   		fixed:true,
   		elem: '#fundAccountEndTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         start.max = data;
    	}
   	}         
    laydate(start);
    laydate(end);
    
    
    $("#fundAccountListMain #fundAccountOpenExcelAdd").click(function(){
	 	openWindows("导入基金净值","${base}/admin/fundAccount/openUploadFundAccount.htm",null,null,true);
	})
	
	$("#fundAccountListMain #fundAccountExport").click(function(){
		var o=loadMsg();
	 	$.ajax({
		type:"POST",
		url:"${base}/admin/fundAccount/exportFundAccount.htm",
		data:fundAccountTableParams,
		dataType:'json',
		success:function(data){
			closeMsg(o);
			if(data.status=="00"){
				window.location.href="${base}/admin/main/export.htm?name="+data.error;
			}else{
				alertMsg(data.error)
			}
		},error:function(){
			closeMsg(o);
			alertMsg("系统异常,请重试")
		}
		})
	})	
})
function fundAccountGetFundsByCompanyId(){
	$.ajax({
			type:"post",
			dataType:"html",
			data:{companyId:$("#fundAccountListMain #companyId").val()},
			url:"${base}/admin/fund/getFundsByCompanyId.htm",
			success:function(data){
			var html="<option value=''>全部</option>"
				$("#fundAccountListMain #fundId").html(html+data)
			}
		})
}
function editFundAccount(value){
		openWindows("修改净值","${base}/admin/fundAccount/edit.htm",{id:value},
	 	function(index,layero){
	 		fundSubmitForm(index)
	 	});
}
function deleteFundAccount(value){
	layer.alert("确认要删除吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/fundAccount/delete.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					alertMsg('删除成功', 1);
					$('#fundAccountListMain #fundAccountTable').bootstrapTable("refresh");
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
<div class="animated fadeInRight" style="width:100%;height:100%;" id="fundAccountListMain">
				<div class="ibox">
					<div class="ibox-title">
						[@shiro.hasPermission name="fundAccountAdd"]
                    	<button type="button" class="btn btn-primary fa fa-plus" id="fundAccountAdd">添加</button>
                		[/@shiro.hasPermission]
						[@shiro.hasPermission name="fundAccountOpenExcelAdd"]
                    	<button type="button" class="btn btn-primary fa fa-plus" id="fundAccountOpenExcelAdd">导入</button>
                		[/@shiro.hasPermission]
						[@shiro.hasPermission name="fundAccountExport"]
                    	<button type="button" class="btn btn-primary fa fa-download" id="fundAccountExport">导出</button>
                		[/@shiro.hasPermission]
                    </div>
                    <div class="ibox-content">
                        	<form class="form-horizontal" id="fundAccountListForm" method="post" onsubmit="return false">
                			<div class="row" style="margin-bottom: 10px;">
                    			<div class="col-md-6">
                    			[@shiro.hasPermission name="canSeeCompany"]
                    			<select name="companyId" id="companyId" style="width:300px;">
                    				<option value="">全部</option>
                    				[#list companys as co]
                    				<option value="${co.id}">${(co.companyAbbr)!}</option>
                    				[/#list]
                    			</select>
                    			[/@shiro.hasPermission]
                    			<button type="button" class="btn btn-primary fa fa-search" id="fundAccountListSearch">查询</button>
                    			</div>
                    		</div>
                			<div class="row" style="margin-bottom: 10px;">
                				<div class="col-md-4">
					            	<div class="input-group input-group-sm">
                                	<span class="input-group-addon">发布日期</span>
                                	<input type="text" class="form-control laydate-icon" name="startTime" id="fundAccountStartTime" >
                                	<span class="input-group-addon">到</span>
                                	<input type="text" class="form-control laydate-icon" name="endTime" id="fundAccountEndTime">
                            		</div>
					        	</div>
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">产品名称</span>
					            		<input type="text" class="form-control" name="fundName" id="fundName">
					                </div>
					        	</div>
					        </div>
							</form>
							<table class="table table-bordered" id="fundAccountTable" > </table>
                    </div>
				</div>
</div>
