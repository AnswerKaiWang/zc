<script>
$(function(){
	$('#companyListMain #companyTable').bootstrapTable({
                url:'${base}/admin/company/list.htm',
                queryParams:function(params){
                	$.each($("#companyListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'name',
                    title: '公司名称',
                    align: 'center',
                    align: 'left'
                },{
                    field: 'companyAbbr',
                    title: '简称',
                    align: 'center',
                    align: 'left'
                },{
                    field: 'createTime',
                    title: '创建时间',
                    align: 'center'
                },{
                    field: 'companyNo',
                    title: '公司编号',
                    align: 'center',
                    sortable:"true"
                },{
                	field:'id',
                	title: '操作',
               		align: 'center',
                	formatter:function(value){
                		var html="";
                		[@shiro.hasPermission name="editcompany"]
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editCompanyEmail(\''+value+'\')">邮箱</a>&nbsp';
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editSecurity(\''+value+'\')">安全保障</a>&nbsp';
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editcompany(\''+value+'\')">修改</a>&nbsp';
                		[/@shiro.hasPermission]
						return html;
                    }
                }],
                sortName:"companyNo",
                sortOrder:"desc"
            });
            
            
            
 	$("#companyListSearch").click(function(){
		$('#companyListMain #companyTable').bootstrapTable("refresh")
	})
	
	$("#companyListMain #companyAdd").click(function(){
	 openWindows("添加公司","${base}/admin/company/add.htm",null,
	 function(index,layero){
	 	companySubmitForm(index)
	 });
	})
	
})
function editcompany(value){
		openWindows("修改公司","${base}/admin/company/edit.htm",{id:value},
	 	function(index,layero){
	 		companySubmitForm(index)
	 	});
}
function editSecurity(value){
		openWindows("修改安全保障","${base}/admin/company/editSecurity.htm",{id:value},
	 	function(index,layero){
	 		companySubmitForm(index)
	 	});
}
function editCompanyEmail(value){
		openWindows("修改发件邮箱","${base}/admin/company/editCompanyEmail.htm",{id:value},
	 	function(index,layero){
	 		companySubmitForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="companyListMain">
				<div class="ibox">
					<div class="ibox-title">
						[@shiro.hasPermission name="companyAdd"]
                    	<button type="button" class="btn btn-primary fa fa-plus" id="companyAdd">添加</button>
                    	[/@shiro.hasPermission]
                    </div>
                    <div class="ibox-content">
                    		<h4><button type="button" class="btn btn-primary fa fa-search" id="companyListSearch">查询</button></h4>
                        	<form class="form-horizontal" id="companyListForm" method="post" onsubmit="return false">
                			<div class="row" style="margin-bottom: 10px;">
					      		<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">公司名称</span>
					                    <input type="text" class="form-control" name="name" id="name">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">公司编号</span>
					                    <input type="text" class="form-control" name="companyNo" id="companyNo">
					                </div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="companyTable" > </table>
                    </div>
				</div>
</div>
