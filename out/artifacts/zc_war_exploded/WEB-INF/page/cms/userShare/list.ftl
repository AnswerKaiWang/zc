<script>
$(function(){
	var userShareTableParams;
	$('#userShareListMain #userShareTable').bootstrapTable({
                url:'${base}/admin/userShare/list.htm',
                queryParams:function(params){
                	$.each($("#userShareListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	userShareTableParams=params;
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'fundName',
                    title: '产品名称',
                    align: 'center'
                },{
                    field: 'name',
                    title: '客户姓名',
                    align: 'center'
                },{
                    field: 'cardNo',
                    title: '证件号码',
                    align: 'center'
                },{
                    field: 'userNo',
                    title: '基金账户',
                    align: 'center'
                },{
                    field: 'type',
                    title: '业务类型',
                    align: 'center',
                    clickToSelect: false,
                    formatter:function(value){
                    	[#list orderTypes as st]
                    	if("${st}"==value){
                    		return "${st.description}";
                    	}
                    	[/#list]
                    	return '';
                    }
                },{
                    field: 'okTime',
                    title: '确认日期',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'fundAccountMoney',
                    title: '单位净值',
                    align: 'right'
                },{
                    field: 'share',
                    title: '确认份额',
                    align: 'right'
                },{
                    field: 'money',
                    title: '认购金额',
                    align: 'right'
                },{
                	field:'id',
                	title: '操作',
               		align: 'center',
                	formatter:function(value){
                		var html="";
                		[@shiro.hasPermission name="editUserShareStatus"]
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editUserShareStatus(\''+value+'\')">修改</a>&nbsp';
                		[/@shiro.hasPermission]
                		[@shiro.hasPermission name="deleteUserShareStatus"]
                		html=html+'<a class="btn btn-primary btn-xs" onclick="deleteUserShareStatus(\''+value+'\')">删除</a>&nbsp';
                		[/@shiro.hasPermission]
						return html;
                    }
                }],
                sortName:"okTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#userShareListSearch").click(function(){
		$('#userShareListMain #userShareTable').bootstrapTable("refresh")
	})
	$("#userShareListMain #userShareAdd").click(function(){
	 openWindows("添加客户份额","${base}/admin/userShare/add.htm",null,
	 function(index,layero){
	 	userShareSubmitForm(index)
	 });
	})
   	var okStart = {
   		fixed:true,
   		elem: '#userShareOkStartTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         okEnd.min = data; 
         okEnd.start = data 
    	}
   	}
   	var okEnd={
   		fixed:true,
   		elem: '#userShareOkEndTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         okStart.max = data;
    	}
   	}    
    laydate(okStart);
    laydate(okEnd);
    
    $("#userShareListMain #userShareOpenExcelAdd").click(function(){
	 	openWindows("导入客户份额","${base}/admin/userShare/openUploadUserShare.htm",null,null,true);
	})
	$("#userShareListMain #exportUserShareExcel").click(function(){
		var o=loadMsg();
	 	$.ajax({
		type:"POST",
		url:"${base}/admin/userShare/exportUserShare.htm",
		data:userShareTableParams,
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
function userShareGetFundsByCompanyId(){
	$.ajax({
			type:"post",
			dataType:"html",
			data:{companyId:$("#userShareListMain #companyId").val()},
			url:"${base}/admin/fund/getFundsByCompanyId.htm",
			success:function(data){
			var html="<option value=''>全部</option>"
				$("#userShareListMain #fundId").html(html+data)
			}
		})
}
function editUserShareStatus(value){
		openWindows("修改客户份额","${base}/admin/userShare/edit.htm",{id:value},
	 	function(index,layero){
	 		userShareSubmitForm(index)
	 	});
}
function deleteUserShareStatus(value){
	layer.alert("确认要删除客户吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/userShare/delete.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					layer.msg('删除成功');
					$('#userShareListMain #userShareTable').bootstrapTable("refresh")
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
<div class="animated fadeInRight" style="width:100%;height:100%;" id="userShareListMain">
<style>

</style>
				<div class="ibox">
					<div class="ibox-title">
						[@shiro.hasPermission name="userShareAdd"]
						<button type="button" class="btn btn-primary fa fa-plus" id="userShareAdd">添加</button>
                		[/@shiro.hasPermission]
						[@shiro.hasPermission name="userShareOpenExcelAdd"]
						<button type="button" class="btn btn-primary fa fa-plus" id="userShareOpenExcelAdd">导入</button>
                		[/@shiro.hasPermission]
						[@shiro.hasPermission name="exportUserShareExcel"]
						<button type="button" class="btn btn-primary fa fa-download" id="exportUserShareExcel">导出</button>
                		[/@shiro.hasPermission]
                    </div>
                    <div class="ibox-content">
                        	<form class="form-horizontal" id="userShareListForm" method="post" onsubmit="return false">
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
                    			<button type="button" class="btn btn-primary fa fa-search" id="userShareListSearch">查询</button>
                    			</div>
                    		</div>
                			<div class="row" style="margin-bottom: 10px;">
                				<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">产品名称</span>
					            		<input type="text" class="form-control" name="fundName" id="fundName">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">客户姓名</span>
					                    <input type="text" class="form-control" name="name" id="name">
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
               		 			<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">基金账户</span>
					                    <input type="text" class="form-control" name="userNo" id="userNo">
					                </div>
					        	</div>
               		 			<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">业务类型</span>
					                    <select class="form-control" name="type" id="type">
					                    	<option value="">全部类型</option>
                                                [#list orderTypes as sta]
                                                        <option value="${sta}">${sta.description}</option>
                                                [/#list]
					                    </select>
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
                                	<span class="input-group-addon">确认日期</span>
                                	<input type="text" class="form-control laydate-icon" name="startTime" id="userShareOkStartTime" >
                                	<span class="input-group-addon">到</span>
                                	<input type="text" class="form-control laydate-icon" name="endTime" id="userShareOkEndTime">
                            		</div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="userShareTable" > </table>
                    </div>
				</div>
</div>
