<script>
$(function(){
	$('#memberList_main #memberDefaultTable').bootstrapTable({
                url:'${base}/admin/member/list.htm',
                queryParams:function(params){
                	$.each($("#memberList_main").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'userName',
                    title: '登录名称',
                    align: 'center'
                },{
                    field: 'realName',
                    title: '姓名',
                    align: 'center'
                },{
                    field: 'createTime',
                    title: '创建时间',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'status',
                    title: '状态',
                    align: 'center',
                    clickToSelect: false,
                    formatter:function(value){
                    	[#list status as st]
                    	if("${st}"==value){
                    		return "${st.description}";
                    	}
                    	[/#list]
                    	return '';
                    }
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
                		[@shiro.hasPermission name="editMember"]
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editMember(\''+value+'\')">修改</a>&nbsp';
                		[/@shiro.hasPermission]
						return html;
                    }
                }],
                sortName:"createTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#memberSearchButton").click(function(){
		$('#memberDefaultTable').bootstrapTable("refresh")
	})
	
	$("#memberList_main #memberAdd").click(function(){
	 openWindows("添加人员","${base}/admin/member/add.htm",null,
	 function(index,layero){
	 	memberSubmitForm(index)
	 });
	})
})
function editMember(value){
		openWindows("修改人员","${base}/admin/member/edit.htm",{id:value},
	 	function(index,layero){
	 		lectureEditForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="memberList_main">
				<div class="ibox">
					<div class="ibox-title">
						[@shiro.hasPermission name="memberAdd"]
                    	<button type="button" class="btn btn-primary fa fa-plus" id="memberAdd">添加</button>
                    	[/@shiro.hasPermission]
                    </div>
                    <div class="ibox-content">
                        	<form class="form-horizontal" id="memberSearchForm" method="post" onsubmit="return false">
                			<div class="row" style="margin-bottom: 10px;">
                    			<div class="col-md-4">
                    			[@shiro.hasPermission name="canSeeCompany"]
                    			<select name="companyId" id="companyId">
                    				<option value="">全部</option>
                    				<option value="0">总部</option>
                    				[#list companys as co]
                    				<option value="${co.id}">${(co.companyAbbr)!}</option>
                    				[/#list]
                    			</select>
                    			[/@shiro.hasPermission]
                    			<button type="button" class="btn btn-primary fa fa-search" id="memberSearchButton">查询</button>
                    			</div>
                    		</div>
                			<div class="row" style="margin-bottom: 10px;">
					      		<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">登录名称</span>
					                    <input type="text" class="form-control" name="userName" id="userName">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">姓名</span>
					                    <input type="text" class="form-control" name="realName" id="realName">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">状态</span>
					                    <select class="form-control" name="status" id="status">
					                    	<option value="">全部状态</option>
					                    	[#if status??]
                                                [#list status as sta]
                                                        <option value="${sta}">${sta.description}</option>
                                                [/#list]
                                            [/#if]
					                    </select>
					                </div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="memberDefaultTable" > </table>
                    </div>
				</div>
</div>
