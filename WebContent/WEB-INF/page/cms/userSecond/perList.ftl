<script>
$(function(){
		$("#userSecondPerListMain #memberId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/member/searchMemberList.htm",
	    	dataType: 'json',
	    	delay: 250,
	    	cache: false,
	    	type: 'POST',
	    	data: function (params) {
	      		return {search: params.term,memberType:'caifuguwen'}
	    	},
	    	processResults: function (data, page) { 
	    			return {results: data}
	    	}  
    	}
  	});
  	
	var userSecondPerTableParams;
	$('#userSecondPerListMain #userSecondPerTable').bootstrapTable({
                url:'${base}/admin/userSecond/per/list.htm',
                queryParams:function(params){
                	$.each($("#userSecondPerListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	userSecondPerTableParams=params
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'userNo',
                    title: '客户代码',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'name',
                    title: '客户姓名',
                    align: 'center',
                    width:'100',
                    sortable:"true"
                },{
                    field: 'perSex',
                    title: '性别',
                    align: 'center',
                    sortable:"true",
                	formatter:function(value){
                		if(value==null){
                			return "/";
                		}
                		if(value ==0){
                			return "女"
                		}else{
                			return "男"
                		}
                    }
                },{
                    field: 'userLevelId',
                    title: '客户等级',
                    align: 'center',
                    formatter:function(value){
                    	[@dict name="userLevel" ]
                    	[#list dictList as st]
                    		if("${st.id}"==value){
                    		return "${st.name}";
                    		}
                    	[/#list]
                    	[/@dict]
                    	return '';
                    }
                },{
                    field: 'perCardTypeId',
                    title: '证件类型',
                    align: 'center',
                    formatter:function(value){
                    	[@dict name="perCardType" ]
                    	[#list dictList as st]
                    		if("${st.id}"==value){
                    		return "${st.name}";
                    		}
                    	[/#list]
                    	[/@dict]
                    	return '';
                    }
                },{
                    field: 'perCardNo',
                    title: '证件号码',
                    align: 'center'
                },{
                    field: 'perMemberName',
                    title: '财富顾问',
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
                },{
                	field:'id',
                	title: '操作',
               		align: 'center',
               		width:230,
                	formatter:function(value){
                		var html="";
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editUserSecondPer(\''+value+'\')">修改</a>&nbsp';
                		//html=html+'<a class="btn btn-primary btn-xs" onclick="editUserSecondPerCard(\''+value+'\')">证照</a>&nbsp';
                		//html=html+'<a class="btn btn-primary btn-xs" onclick="editStatusUserSecondPer(\''+value+'\')">修改状态</a>&nbsp';
                		html=html+'<a class="btn btn-primary btn-xs" onclick="updateUserSecondPerPassword(\''+value+'\')">重置密码</a>&nbsp';
						return html;
                    }
                }
                ],
                sortName:"createTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#userSecondPerListSearch").click(function(){
		$('#userSecondPerListMain #userSecondPerTable').bootstrapTable("refresh")
	});
	
	$("#userSecondPerListMain #userSecondPerAdd").click(function(){
	 openWindows("添加个人客户","${base}/admin/userSecond/per/add.htm",null,
	 function(index,layero){
	 	userSecondSubmitForm(index)
	 });
	});
	$("#userSecondPerListMain #userSecondPerImp").click(function(){
	 	openWindows("导入基金","${base}/admin/userSecond/per/openUploadPer.htm",null,null,true);
	 });
	var start = {
   		fixed:true,
   		elem: '#userSecondStartTime',
    	istime: true,
    	choose: function(data){
         end.min = data; 
         end.start = data 
    	}
   	}
   	var end={
   		fixed:true,
   		elem: '#userSecondEndTime',
    	istime: true,
    	choose: function(data){
         start.max = data;
    	}
   	}   
    laydate(start);
    laydate(end);
})
function editUserSecondPer(value){
		openWindows("修改个人客户","${base}/admin/userSecond/per/edit.htm",{id:value},
	 	function(index,layero){
	 		userSecondSubmitForm(index)
	 	});
}
function editUserSecondPerCard(value){
		openWindows("修改个人客户","${base}/admin/userSecond/per/card.htm",{id:value},
	 	function(index,layero){
	 		userSecondSubmitForm(index)
	 	});
}

function editStatusUserSecondPer(value){
	layer.alert("确认要修改个人客户状态吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/userSecond/updateStatus.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					alertMsg('修改成功', 1);
					$('#userSecondPerListMain #userSecondPerTable').bootstrapTable("refresh")
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
function updateUserSecondPerPassword(value){
	layer.alert("确认要重置个人客户密码吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/userSecond/updatePassword.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					alertMsg('修改成功,个人客户密码为:'+data.msg, 1);
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
function editCaifuguwenUserSecondPer(){
	var ids=[];
	var rows=$('#userSecondPerListMain #userSecondPerTable').bootstrapTable("getSelections");
	if(rows==null||rows.length==0){
		alertMsg("请至少选择一个客户",0)
		return false;
	}
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i]["id"]);
	}
	openWindows("调整个人客户财富顾问","${base}/admin/userSecond/editMember.htm",{ids:ids,type:"per"},
	 	function(index,layero){
	 		userSecondSubmitForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="userSecondPerListMain">
				<div class="ibox">
					<div class="ibox-title">
                		<button type="button" class="btn btn-primary fa fa-plus" id="userSecondPerAdd"> 添加</button>
                		<button type="button" class="btn btn-primary fa fa-plus" id="userSecondPerImp">导入</button>
                		<button type="button" class="btn btn-primary fa fa-plus" onclick="editCaifuguwenUserSecondPer()"> 财富顾问</button>
                    </div>
                    <div class="ibox-content">
                        	<form class="form-horizontal" id="userSecondPerListForm" method="post" onsubmit="return false">
                			<div class="row" style="margin-bottom: 10px;">
                    			<div class="col-md-6">
                    			<button type="button" class="btn btn-primary fa fa-search" id="userSecondPerListSearch">查询</button>
                    			</div>
                    		</div>
                			<div class="row" style="margin-bottom: 10px;">
					      		<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">客户代码</span>
					                    <input type="text" class="form-control" name="userNo" id="userNo">
					                </div>
					        	</div>
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">客户姓名</span>
					                    <input type="text" class="form-control" name="name" id="name">
					                </div>
					        	</div>
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">证件号码</span>
					                    <input type="text" class="form-control" name="perCardNo" id="perCardNo">
					                </div>
					        	</div>
               		 		</div>
               		 		<div class="row" style="margin-bottom: 10px;">
               		 			<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 话</span>
					                    <input type="text" class="form-control" name="perPhone" id="perPhone">
					                </div>
					        	</div>
					        	<div class="col-md-4">
						        	<div class="input-group input-group-sm">
						            		<span class="input-group-addon">财富顾问</span>
						                     <select class="form-control" name="memberId" id="memberId">
						                    </select>
						            </div>
					            </div>
					            <div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 态</span>
					                    <select class="form-control" name="status" id="status">
					                    	<option value="">全部状态</option>
					                    	<option value="use">启用</option>
                                            <option value="finish">禁用</option>
					                    </select>
					                </div>
					        	</div>
               		 		</div>
               		 		<div class="row" style="margin-bottom: 10px;">
					      		<div class="col-md-4">
					      			<div class="input-group input-group-sm">
					            	<span class="input-group-addon">客户等级</span>
					                    <select class="form-control" name="userLevelId" id="userLevelId">
					                    	<option value="">全部</option>
					                    	[@dict name="userLevel" ]
					                    	[#list dictList as st]
					                    		<option value="${st.id}">${st.name}</option>
					                    	[/#list]
					                    	[/@dict]
					                    </select>
					                   </div>
					        	</div>
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">信息来源</span>
					                    <select class="form-control" name="infoSourceId" id="infoSourceId">
					                    	<option value="">全部</option>
					                    	[@dict name="infoSource" ]
					                    	[#list dictList as st]
					                    		<option value="${st.id}">${st.name}</option>
					                    	[/#list]
					                    	[/@dict]
					                    </select>
					                </div>
					        	</div>
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
                                	<span class="input-group-addon">创建时间</span>
                                	<input type="text" class="form-control laydate-icon" name="startTime" id="userSecondStartTime" >
                                	<span class="input-group-addon">到</span>
                                	<input type="text" class="form-control laydate-icon" name="endTime" id="userSecondEndTime">
                            		</div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="userSecondPerTable" > </table>
                    </div>
				</div>
</div>
