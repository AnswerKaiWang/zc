<script>
$(function(){
	var userTableParams;
	$('#userListMain #userTable').bootstrapTable({
                url:'${base}/admin/user/list.htm',
                queryParams:function(params){
                	$.each($("#userListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	userTableParams=params
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'type',
                    title: '账户类型',
                    align: 'center',
                    formatter:function(value){
                    	[#list userTypes as st]
                    	if("${st}"==value){
                    		return "${st.description}";
                    	}
                    	[/#list]
                    	return '';
                    }
                },{
                    field: 'userNo',
                    title: '基金账户',
                    align: 'center'
                },{
                    field: 'name',
                    title: '姓名',
                    align: 'center',
                    width:'100'
                },{
                    field: 'companyName',
                    title: '所属公司',
                    align: 'center',
                    width:100
                },{
                    field: 'sex',
                    title: '性别',
                    align: 'center',
                	formatter:function(value){
                		if(value==null){
                		return "/";
                		}
                		if(value){
                		return "女"
                		}else{
                		return "男"
                		}
                    }
                },{
                    field: 'cardType',
                    title: '证件类型',
                    align: 'center',
                    formatter:function(value){
                    	[#list cardTypes as st]
                    	if("${st}"==value){
                    		return "${st.description}";
                    	}
                    	[/#list]
                    	return '';
                    }
                },{
                    field: 'cardNo',
                    title: '证件号码',
                    align: 'center'
                },{
                    field: 'phone',
                    title: '电话',
                    align: 'center'
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
                    field: 'createTime',
                    title: '创建时间',
                    align: 'center',
                    sortable:"true"
                }
                [@shiro.hasPermission name="editUser"]
                ,{
                	field:'id',
                	title: '操作',
               		align: 'center',
               		width:200,
                	formatter:function(value){
                		var html="";
                		
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editUser(\''+value+'\')">修改</a>&nbsp';
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editStatusUser(\''+value+'\')">修改状态</a>&nbsp';
                		html=html+'<a class="btn btn-primary btn-xs" onclick="updateUserPassword(\''+value+'\')">重置密码</a>&nbsp';
						return html;
                    }
                }
                [/@shiro.hasPermission]
                ],
                sortName:"createTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#userListSearch").click(function(){
		$('#userListMain #userTable').bootstrapTable("refresh")
	})
	
	$("#userListMain #userAdd").click(function(){
	 openWindows("添加管理人客户","${base}/admin/user/add.htm",null,
	 function(index,layero){
	 	fundSubmitForm(index)
	 });
	})
	 $("#userListMain #userOpenExcelAdd").click(function(){
	 	openWindows("导入管理人客户","${base}/admin/user/openUploadUser.htm",null,null,true);
	})
	var start = {
   		fixed:true,
   		elem: '#userStartTime',
    	istime: true,
    	choose: function(data){
         end.min = data; 
         end.start = data 
    	}
   	}
   	var end={
   		fixed:true,
   		elem: '#userEndTime',
    	istime: true,
    	choose: function(data){
         start.max = data;
    	}
   	}   
    laydate(start);
    laydate(end);
    
     $("#userListMain #exportUserExcel").click(function(){
		var o=loadMsg();
	 	$.ajax({
		type:"POST",
		url:"${base}/admin/user/exportUser.htm",
		data:userTableParams,
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
function editUser(value){
		openWindows("修改管理人客户","${base}/admin/user/edit.htm",{id:value},
	 	function(index,layero){
	 		fundSubmitForm(index)
	 	});
}

function editStatusUser(value){
	layer.alert("确认要修改管理人客户状态吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/user/updateStatus.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					alertMsg('修改成功', 1);
					$('#userListMain #userTable').bootstrapTable("refresh")
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
function updateUserPassword(value){
	layer.alert("确认要重置管理人客户密码吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/user/updatePassword.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					alertMsg('修改成功,客户密码为:'+data.msg, 1);
					$('#userListMain #userTable').bootstrapTable("refresh")
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
<div class="animated fadeInRight" style="width:100%;height:100%;" id="userListMain">
				<div class="ibox">
					<div class="ibox-title">
						[@shiro.hasPermission name="userAdd"]
                		<button type="button" class="btn btn-primary fa fa-plus" id="userAdd">添加</button>
                		[/@shiro.hasPermission]
						[@shiro.hasPermission name="userOpenExcelAdd"]
                    	<button type="button" class="btn btn-primary fa fa-plus" id="userOpenExcelAdd">导入</button>
                		[/@shiro.hasPermission]
						[@shiro.hasPermission name="exportUserExcel"]
                    	<button type="button" class="btn btn-primary fa fa-download" id="exportUserExcel">导出</button>
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
                    			<button type="button" class="btn btn-primary fa fa-search" id="userListSearch">查询</button>
                    			</div>
                    		</div>
                			<div class="row" style="margin-bottom: 10px;">
					      		<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">基金账户</span>
					                    <input type="text" class="form-control" name="userNo" id="userNo">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">证件类型</span>
					                    <select class="form-control" name="cardType" id="cardType">
					                    	<option value="">全部类型</option>
                                                [#list cardTypes as sta]
                                                        <option value="${sta}">${sta.description}</option>
                                                [/#list]
					                    </select>
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">证件号码</span>
					                    <input type="text" class="form-control" name="cardNo" id="cardNo">
					                </div>
					        	</div>
               		 		</div>
               		 		<div class="row" style="margin-bottom: 10px;">
               		 			<div class="col-md-4">
					            	<div class="input-group input-group-sm">
                                	<span class="input-group-addon">创建时间</span>
                                	<input type="text" class="form-control laydate-icon" name="startTime" id="userStartTime" >
                                	<span class="input-group-addon">到</span>
                                	<input type="text" class="form-control laydate-icon" name="endTime" id="userEndTime">
                            		</div>
					        	</div>
               		 			<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">状态</span>
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
					            		<span class="input-group-addon">账户类型</span>
					                     <select class="form-control" name="type" id="type">
					                    	<option value="">全部状态</option>
                                                [#list userTypes as sta]
                                                        <option value="${sta}">${sta.description}</option>
                                                [/#list]
					                    </select>
					                </div>
					        	</div>
               		 		</div>
               		 		<div class="row" style="margin-bottom: 10px;">
					      		<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">电话</span>
					                    <input type="text" class="form-control" name="phone" id="phone">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">姓名</span>
					                    <input type="text" class="form-control" name="name" id="name">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">性别</span>
					                    <select class="form-control" name="sex" id="sex">
					                    	<option value="">全部</option>
                                            <option value="true">女</option>
                                            <option value="false">男</option>
					                    </select>
					                </div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="userTable" > </table>
                    </div>
				</div>
</div>
