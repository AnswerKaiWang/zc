<script>
$(function(){
	$('#helpListMain #helpTable').bootstrapTable({
                url:'${base}/admin/help/list.htm',
                queryParams:function(params){
                	$.each($("#helpListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'name',
                    title: '名称',
                    align: 'center'
                },{
                    field: 'type',
                    title: '类型',
                    align: 'center'
                },{
                    field: 'pageIndex',
                    title: '排序',
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
                	field:'id',
                	title: '操作',
               		align: 'center',
               		width:80,
                	formatter:function(value){
                		var html="";
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editHelp(\''+value+'\')">修改</a>&nbsp';
						return html;
                    }
                }],
                sortName:"createTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#helpListSearch").click(function(){
		$('#helpListMain #helpTable').bootstrapTable("refresh")
	})
	
	$("#helpListMain #helpAdd").click(function(){
	 openWindows("添加帮助","${base}/admin/help/add.htm",null,
	 function(index,layero){
	 	helpSubmitForm(index)
	 });
	})
	
	
})
function editHelp(value){
		openWindows("修改帮助","${base}/admin/help/edit.htm",{id:value},
	 	function(index,layero){
	 		helpSubmitForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="helpListMain">
				<div class="ibox">
					<div class="ibox-title">
                    	<button type="button" class="btn btn-primary fa fa-plus" id="helpAdd">添加</button>
                    </div>
                    <div class="ibox-content">
                    		<form class="form-horizontal" id="helpListForm" method="post" onsubmit="return false">
                    		<div class="row" style="margin-bottom: 10px;">
                    			<div class="col-md-4">
                    			<select name="companyId" id="companyId">
                    				<option value="">全部</option>
                    				[#list companys as co]
                    				<option value="${co.id}">${(co.companyAbbr)!}</option>
                    				[/#list]
                    			</select>
                    			<button type="button" class="btn btn-primary fa fa-search" id="helpListSearch">查询</button>
                    			</div>
                    		</div>
                			<div class="row" style="margin-bottom: 10px;">
					      		<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">名称</span>
					                    <input type="text" class="form-control" name="name" id="name">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">类型</span>
					                    <select class="form-control" name="status" id="status">
					                    	<option value="">全部类型</option>
                                                [#list types as sta]
                                                        <option value="${sta}">${sta}</option>
                                                [/#list]
					                    </select>
					                </div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="helpTable" > </table>
                    </div>
				</div>
</div>
