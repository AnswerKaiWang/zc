<script>
$(function(){
	$('#permission_list_main_table').bootstrapTable({
                url:'${base}/admin/permission/list.htm',
                queryParams:function(params){
                	$.each($("#permission_list_main").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'permissionId',
                    title: '编号',
                    align: 'center'
                },{
                    field: 'name',
                    title: '名称',
                    align: 'center'
                },{
                    field: 'value',
                    title: '值',
                    align: 'center'
                },{
                    field: 'parentId',
                    title: '父值编号',
                    align: 'center'
                },{
                    field: 'groups',
                    title: '类型',
                    align: 'center',
                    formatter:function(value){
                    	if(value=="nav"){
                    		return "左边树控制";
                    	}else{
                    		return "链接控制";
                    	}
                    }
                },{
                    field: 'createTime',
                    title: '创建时间',
                    align: 'center',
                    sortable:"true"
                }],
                sortName:"createTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#permission_list_sb").click(function(){
		$('#permission_list_main_table').bootstrapTable("refresh")
	})
	
	$("#permission_list_main #permissionAdd").click(function(){
	 openWindows("添加权限","${base}/permission/toAdd.html",null,
	 function(index,layero){
	 	memberSubmitForm(index)
	 });
	})
})
function editPermission(value){
		openWindows("修改人员","${base}/permission/edit.html",{id:value},
	 	function(index,layero){
	 		memberSubmitForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="permission_list_main">
				<div class="ibox">
					<div class="ibox-title">
                    </div>
                    <div class="ibox-content">
                    		<h4><button type="button" class="btn btn-primary fa fa-search" id="permission_list_sb">查询</button></h4>
                        	<form class="form-horizontal" id="memberSearchForm" method="post" onsubmit="return false">
                			<div class="row" style="margin-bottom: 10px;">
                				<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">编号</span>
					                    <input type="text" class="form-control" name="permissionId" id="permissionId">
					                </div>
					        	</div>
					      		<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">名称</span>
					                    <input type="text" class="form-control" name="name" id="name">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">值</span>
					                    <input type="text" class="form-control" name="value" id="value">
					                </div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="permission_list_main_table" > </table>
                    </div>
				</div>
</div>
