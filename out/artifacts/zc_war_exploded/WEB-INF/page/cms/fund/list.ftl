<script>
$(function(){
	var fundTableParams;
	$('#fundListMain #fundTable').bootstrapTable({
                url:'${base}/admin/fund/list.htm',
                queryParams:function(params){
                	$.each($("#fundListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	fundTableParams=params;
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'no',
                    title: '产品代码',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'seriesName',
                    title: '系列名称',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'name',
                    title: '产品名称',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'type',
                    title: '产品类别',
                    align: 'center',
                    sortable:"true",
                    formatter:function(value){
                    	[#list types as st]
                    	if("${st.id}"==value){
                    		return "${st.name}";
                    	}
                    	[/#list]
                    	return '';
                    }
                },{
                    field: 'setupTime',
                    title: '基金成立日',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'deadline',
                    title: '基金期限',
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
                    field: 'frontStatus',
                    title: '是否推荐',
                    align: 'center',
                    sortable:"true",
                	formatter:function(value){
                		if(value==0){
                			return "否"
                		}
                		return "是"
                    }
                },{
                	field:'id',
                	title: '操作',
               		align: 'center',
               		width:140,
                	formatter:function(value){
                		var html="";
                		[@shiro.hasPermission name="editFund"]
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editFund(\''+value+'\')">修改</a>&nbsp';
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editFundApply(\''+value+'\')">修改预约</a>&nbsp';
                    	[/@shiro.hasPermission]
						return html;
                    }
                }],
                sortName:"page_index",
                sortOrder:"desc"
            });
 	$("#fundListSearch").click(function(){
		$('#fundListMain #fundTable').bootstrapTable("refresh")
	});
	$("#fundListMain #fundAdd").click(function(){
	 openWindows("添加基金","${base}/admin/fund/add.htm",null,
	 function(index,layero){
	 	fundAddSubmitForm(index)
	 });
	})
	$("#fundListMain #fundOpenExcelAdd").click(function(){
	 	openWindows("导入基金","${base}/admin/fund/openUploadFund.htm",null,null,true);
	});
	var start = {
   		fixed:true,
   		elem: '#fundStartTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         end.min = data; 
         end.start = data 
    	}
   	};
   	var end={
   		fixed:true,
   		elem: '#fundEndTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         start.max = data;
    	}
   	};         
    laydate(start);
    laydate(end);
   
   $("#fundListMain #exportFundExcel").click(function(){
		var o=loadMsg();
	 	$.ajax({
		type:"POST",
		url:"${base}/admin/fund/exportFund.htm",
		data:fundTableParams,
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
function editFund(value){
		openWindows("修改基金","${base}/admin/fund/edit.htm",{id:value},
	 	function(index,layero){
	 		fundEditSubmitForm(index)
	 	});
}
function editFundApply(value){
		openWindows("修改基金预约","${base}/admin/fund/editFundApply.htm",{id:value},
	 	function(index,layero){
	 		fundSubmitForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="fundListMain">
	<div class="ibox">
		<div class="ibox-title">
			[@shiro.hasPermission name="fundAdd"]
        	<button type="button" class="btn btn-primary fa fa-plus" id="fundAdd">添加</button>
        	[/@shiro.hasPermission]
        	[@shiro.hasPermission name="fundOpenExcelAdd"]
        	<button type="button" class="btn btn-primary fa fa-plus" id="fundOpenExcelAdd">导入</button>
        	[/@shiro.hasPermission]
        	[@shiro.hasPermission name="exportFundExcel"]
        	<button type="button" class="btn btn-primary fa fa-download" id="exportFundExcel">导出</button>
        	[/@shiro.hasPermission]
        </div>
        <div class="ibox-content">
        		<form class="form-horizontal" id="fundListForm" method="post" onsubmit="return false">
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
        			<button type="button" class="btn btn-primary fa fa-search" id="fundListSearch">查询</button>
        			</div>
        		</div>
    			<div class="row" style="margin-bottom: 10px;">
    				<div class="col-md-4">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">产品代码</span>
		                    <input type="text" class="form-control" name="no" id="no">
		                </div>
		        	</div>
		      		<div class="col-md-3">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">产品名称</span>
		                    <input type="text" class="form-control" name="name" id="name">
		                </div>
		        	</div>
		        	<div class="col-md-3">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">备案号</span>
		                    <input type="text" class="form-control" name="bei" id="bei">
		                </div>
		        	</div>
   		 		</div>
   		 		<div class="row" style="margin-bottom: 10px;">
   		 			<div class="col-md-4">
		            	<div class="input-group input-group-sm">
                    	<span class="input-group-addon">成立日期</span>
                    	<input type="text" class="form-control laydate-icon" name="startTime" id="fundStartTime" >
                    	<span class="input-group-addon">到</span>
                    	<input type="text" class="form-control laydate-icon" name="endTime" id="fundEndTime">
                		</div>
		        	</div>
   		 			<div class="col-md-3">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">产品状态</span>
		                    <select class="form-control" name="status" id="status">
		                    	<option value="">全部状态</option>
                                    [#list status as sta]
                                            <option value="${sta}">${sta.description}</option>
                                    [/#list]
		                    </select>
		                </div>
		        	</div>
		        	<div class="col-md-3">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">基金类型</span>
		                    <select class="form-control" name="type" id="type">
		                    	<option value="">全部类型</option>
                                    [#list types as sta]
                                            <option value="${sta}">${sta.description}</option>
                                    [/#list]
		                    </select>
		                </div>
		        	</div>
   		 		</div>
				</form>
				<table class="table table-bordered" id="fundTable"></table>
        </div>
	</div>
</div>
