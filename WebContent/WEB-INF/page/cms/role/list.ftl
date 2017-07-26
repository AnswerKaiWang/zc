<script>
$(function(){
	$('#role_list_main_table').bootstrapTable({
                url:'${base}/admin/role/list.htm',
                queryParams:function(params){
                	$.each($("#role_list_main").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'id',
                    title: '编号',
                    align: 'center'
                },{
                    field: 'name',
                    title: '名称',
                    align: 'center'
                },{
                    field: 'status',
                    title: '类型',
                    align: 'center',
                    formatter:function(value){
                    	[#list status as st]
                    	if("${st}"==value){
                    		return "${st.description}";
                    	}
                    	[/#list]
                    	return '';
                    }
                },{
                    field: 'createTime',
                    title: '创建时间',
                    align: 'center',
                    sortable:"true"
                },{
                	field:'id',
                	title: '操作',
               		align: 'center',
               		width:80,
                	formatter:function(value){
                		if(value==1){
                		return "";
                		}
                		var html="";
                		[@shiro.hasPermission name="editRole"]
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editRole(\''+value+'\')">修改</a>&nbsp';
                		[/@shiro.hasPermission]
						return html;
                    }
                }],
                sortName:"createTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#role_list_sb").click(function(){
		$('#role_list_main_table').bootstrapTable("refresh")
	})
	
	$("#role_list_main #roleAdd").click(function(){
	 openWindows("添加角色","${base}/admin/role/add.htm",null,
	 function(index,layero){
	 	memberSubmitForm(index)
	 });
	})
})
function editRole(value){
		openWindows("修改角色","${base}/admin/role/edit.htm",{roleId:value},
	 	function(index,layero){
	 		memberSubmitForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="role_list_main">
				<div class="ibox">
					<div class="ibox-title">
						[@shiro.hasPermission name="roleAdd"]
						<button type="button" class="btn btn-primary fa fa-plus" id="roleAdd">添加</button>
                		[/@shiro.hasPermission]
                    </div>
                    <div class="ibox-content">
                    		<h4><button type="button" class="btn btn-primary fa fa-search" id="role_list_sb">查询</button></h4>
                        	<form class="form-horizontal" id="memberSearchForm" method="post" onsubmit="return false">
                			<div class="row" style="margin-bottom: 10px;">
                				
					      		<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">名称</span>
					                    <input type="text" class="form-control" name="name" id="name">
					                </div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="role_list_main_table" > </table>
                    </div>
				</div>
</div>
