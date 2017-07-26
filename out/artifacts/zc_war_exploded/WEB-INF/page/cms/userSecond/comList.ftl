<script>
$(function(){
	$("#userSecondComListMain #memberId").select2({
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
	var userSecondComTableParams;
	$('#userSecondComListMain #userSecondComTable').bootstrapTable({
                url:'${base}/admin/userSecond/com/list.htm',
                queryParams:function(params){
                	$.each($("#userSecondComListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	userSecondComTableParams=params
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'userNo',
                    title: '机构代码',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'name',
                    title: '机构名称',
                    align: 'center',
                    width:'150',
                    sortable:"true"
                },{
                    field: 'zhizhao',
                    title: '营业执照',
                    align: 'center'
                },{
                    field: 'faName',
                    title: '联系人',
                    align: 'center',
                    formatter:function(value,row){
                    	return value+"-("+row.faCardTypeName+")"+row.faCardNo;
                    }
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
               		width:200,
                	formatter:function(value){
                		var html="";
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editUserSecondCom(\''+value+'\')">修改</a>&nbsp';
                		//html=html+'<a class="btn btn-primary btn-xs" onclick="editStatusUserSecondCom(\''+value+'\')">修改状态</a>&nbsp';
                		html=html+'<a class="btn btn-primary btn-xs" onclick="updateUserSecondComPassword(\''+value+'\')">重置密码</a>&nbsp';
						return html;
                    }
                }
                ],
                sortName:"createTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#userSecondComListSearch").click(function(){
		$('#userSecondComListMain #userSecondComTable').bootstrapTable("refresh")
	})
	
	$("#userSecondComListMain #userSecondComAdd").click(function(){
	 openWindows("添加机构客户","${base}/admin/userSecond/com/add.htm",null,
	 function(index,layero){
	 	userSecondSubmitForm(index)
	 });
	})
	
	var start = {
   		fixed:true,
   		elem: '#userSecondComStartTime',
    	istime: true,
    	choose: function(data){
         end.min = data; 
         end.start = data 
    	}
   	}
   	var end={
   		fixed:true,
   		elem: '#userSecondComEndTime',
    	istime: true,
    	choose: function(data){
         start.max = data;
    	}
   	}   
    laydate(start);
    laydate(end);
})
function editUserSecondCom(value){
		openWindows("修改机构客户","${base}/admin/userSecond/com/edit.htm",{id:value},
	 	function(index,layero){
	 		userSecondSubmitForm(index)
	 	});
}

function editStatusUserSecondCom(value){
	layer.alert("确认要修改机构客户状态吗?",function(laiyerIndex){
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
					$('#userSecondComListMain #userSecondComTable').bootstrapTable("refresh")
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
function updateUserSecondComPassword(value){
	layer.alert("确认要重置机构客户密码吗?",function(laiyerIndex){
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
					alertMsg('修改成功,机构客户密码为:'+data.msg, 1);
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
function editCaifuguwenUserSecondCom(){
	var ids=[];
	var rows=$('#userSecondComListMain #userSecondComTable').bootstrapTable("getSelections");
	if(rows==null||rows.length==0){
		alertMsg("请至少选择一个机构客户",0)
		return false;
	}
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i]["id"]);
	}
	openWindows("调整机构客户财富顾问","${base}/admin/userSecond/editMember.htm",{ids:ids,type:"com"},
	 	function(index,layero){
	 		userSecondSubmitForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="userSecondComListMain">
				<div class="ibox">
					<div class="ibox-title">
                		<button type="button" class="btn btn-primary fa fa-plus" id="userSecondComAdd">添加</button>
                		<button type="button" class="btn btn-primary fa fa-plus" onclick="editCaifuguwenUserSecondCom()"> 财富顾问</button>
                    </div>
                    <div class="ibox-content">
                        	<form class="form-horizontal" id="userSecondComListForm" method="post" onsubmit="return false">
                			<div class="row" style="margin-bottom: 10px;">
                    			<div class="col-md-6">
                    			<button type="button" class="btn btn-primary fa fa-search" id="userSecondComListSearch">查询</button>
                    			</div>
                    		</div>
                			<div class="row" style="margin-bottom: 10px;">
					      		<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">机构代码</span>
					                    <input type="text" class="form-control" name="userNo" id="userNo">
					                </div>
					        	</div>
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">机构名称</span>
					                    <input type="text" class="form-control" name="name" id="name">
					                </div>
					        	</div>
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">营业执照</span>
					                    <input type="text" class="form-control" name="zhizhao" id="zhizhao">
					                </div>
					        	</div>
               		 		</div>
               		 		<div class="row" style="margin-bottom: 10px;">
               		 			<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">机构地址</span>
					                    <input type="text" class="form-control" name="comAddr" id="comAddr">
					                </div>
					        	</div>
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">财富顾问</span>
					                     <select class="form-control" name="memberId" id="memberId" >
					                    </select>
					                </div>
					        	</div>
               		 			<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">状态</span>
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
					            		<span class="input-group-addon">法人姓名</span>
					                    <input type="text" class="form-control" name="faName" id="faName">
					                </div>
					        	</div>
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">法人证件号</span>
					                    <input type="text" class="form-control" name="faCardNo" id="faCardNo">
					                </div>
					        	</div>
					        	<div class="col-md-4">
					            	<div class="input-group input-group-sm">
                                	<span class="input-group-addon">创建时间</span>
                                	<input type="text" class="form-control laydate-icon" name="startTime" id="userSecondComStartTime" >
                                	<span class="input-group-addon">到</span>
                                	<input type="text" class="form-control laydate-icon" name="endTime" id="userSecondComEndTime">
                            		</div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="userSecondComTable" > </table>
                    </div>
				</div>
</div>
