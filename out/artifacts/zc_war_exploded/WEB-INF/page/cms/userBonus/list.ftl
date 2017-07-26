<script>
$(function(){
	var userBonusTableParams;
	$('#userBonusListMain #userBonusTable').bootstrapTable({
                url:'${base}/admin/userBonus/list.htm',
                queryParams:function(params){
                	$.each($("#userBonusListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	userBonusTableParams=params;
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'okTime',
                    title: '分红日期',
                    align: 'center',
                    sortable:"true"
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
                    title: '分红方式',
                    align: 'center'
                },{
                    field: 'share',
                    title: '分红基数份额',
                    align: 'right'
                },{
                    field: 'oneMoney',
                    title: '每单位分红额',
                    align: 'right'
                },{
                    field: 'totalMoney',
                    title: '应发红利',
                    align: 'right'
                },{
                    field: 'realMoney',
                    title: '实发红利',
                    align: 'right'
                },{
                    field: 'dengjiTime',
                    title: '登记日期',
                    align: 'center',
                    sortable:"true"
                },{
                    field: 'sendTime',
                    title: '发放日期',
                    align: 'center',
                    sortable:"true"
                },{
                	field:'id',
                	title: '操作',
               		align: 'center',
                	formatter:function(value){
                		var html="";
                		[@shiro.hasPermission name="editUserBonusStatus"]
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editUserBonusStatus(\''+value+'\')">修改</a>&nbsp';
                		[/@shiro.hasPermission]
                		[@shiro.hasPermission name="deleteUserBonusStatus"]
                		html=html+'<a class="btn btn-primary btn-xs" onclick="deleteUserBonusStatus(\''+value+'\')">删除</a>&nbsp';
                		[/@shiro.hasPermission]
						return html;
                    }
                }],
                sortName:"okTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#userBonusListSearch").click(function(){
		$('#userBonusListMain #userBonusTable').bootstrapTable("refresh")
	})
	$("#userBonusListMain #userBonusAdd").click(function(){
	 openWindows("添加客户分红","${base}/admin/userBonus/add.htm",null,
	 function(index,layero){
	 	userBonusSubmitForm(index)
	 });
	})
   	var okStart = {
   		fixed:true,
   		elem: '#userBonusOkStartTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         okEnd.min = data; 
         okEnd.start = data 
    	}
   	}
   	var okEnd={
   		fixed:true,
   		elem: '#userBonusOkEndTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         okStart.max = data;
    	}
   	}    
   	var dengjiStart = {
   		fixed:true,
   		elem: '#userBonusDengjiStartTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         dengjiEnd.min = data; 
         dengjiEnd.start = data 
    	}
   	}
   	var dengjiEnd={
   		fixed:true,
   		elem: '#userBonusDengjiEndTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         dengjiStart.max = data;
    	}
   	}  
   	var sendStart = {
   		fixed:true,
   		elem: '#userBonusSendStartTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         sendEnd.min = data; 
         sendEnd.start = data 
    	}
   	}
   	var sendEnd={
   		fixed:true,
   		elem: '#userBonusSendEndTime',
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         sendStart.max = data;
    	}
   	} 
    laydate(okStart);
    laydate(okEnd);
    laydate(dengjiStart);
    laydate(dengjiEnd);
    laydate(sendStart);
    laydate(sendEnd);
    
     $("#userBonusListMain #userBonusOpenExcelAdd").click(function(){
	 	openWindows("导入客户分红","${base}/admin/userBonus/openUploadUserBonus.htm",null,null,true);
	})
	
	$("#userBonusListMain #exportUserBonusExcel").click(function(){
		var o=loadMsg();
	 	$.ajax({
		type:"POST",
		url:"${base}/admin/userBonus/exportUserBonus.htm",
		data:userBonusTableParams,
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
function userBonusGetFundsByCompanyId(){
	$.ajax({
			type:"post",
			dataType:"html",
			data:{companyId:$("#userBonusListMain #companyId").val()},
			url:"${base}/admin/fund/getFundsByCompanyId.htm",
			success:function(data){
			var html="<option value=''>全部</option>"
				$("#userBonusListMain #fundId").html(html+data)
			}
		})
}
function editUserBonusStatus(value){
		openWindows("修改客户分红","${base}/admin/userBonus/edit.htm",{id:value},
	 	function(index,layero){
	 		userBonusSubmitForm(index)
	 	});
}
function deleteUserBonusStatus(value){
	layer.alert("确认要删除吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/userBonus/delete.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					layer.msg('删除成功');
					$('#userBonusListMain #userBonusTable').bootstrapTable("refresh")
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
<div class="animated fadeInRight" style="width:100%;height:100%;" id="userBonusListMain">
				<div class="ibox">
					<div class="ibox-title">
						[@shiro.hasPermission name="userBonusAdd"]
						<button type="button" class="btn btn-primary fa fa-plus" id="userBonusAdd">添加</button>
                		[/@shiro.hasPermission]
                		[@shiro.hasPermission name="userBonusOpenExcelAdd"]
						<button type="button" class="btn btn-primary fa fa-plus" id="userBonusOpenExcelAdd">导入</button>
                		[/@shiro.hasPermission]
                		[@shiro.hasPermission name="exportUserBonusExcel"]
						<button type="button" class="btn btn-primary fa fa-download" id="exportUserBonusExcel">导出</button>
                		[/@shiro.hasPermission]
                    </div>
                    <div class="ibox-content">
                        	<form class="form-horizontal" id="userBonusListForm" method="post" onsubmit="return false">
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
                    			<button type="button" class="btn btn-primary fa fa-search" id="userBonusListSearch">查询</button>
                    			</div>
                    		</div>
                        	<br>
                			<div class="row" style="margin-bottom: 10px;">
                				<div class="col-md-3">
					            	<div class="input-group input-group-sm">
                                	<span class="input-group-addon">分红日期</span>
                                	<input type="text" class="form-control laydate-icon" name="startTime" id="userBonusOkStartTime" >
                                	<span class="input-group-addon">到</span>
                                	<input type="text" class="form-control laydate-icon" name="endTime" id="userBonusOkEndTime">
                            		</div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
                                	<span class="input-group-addon">登记日期</span>
                                	<input type="text" class="form-control laydate-icon" name="dengjiSatrtTime" id="userBonusDengjiStartTime" >
                                	<span class="input-group-addon">到</span>
                                	<input type="text" class="form-control laydate-icon" name="dengjiEndTime" id="userBonusDengjiEndTime">
                            		</div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
                                	<span class="input-group-addon">发放日期</span>
                                	<input type="text" class="form-control laydate-icon" name="sendSatrtTime" id="userBonusSendStartTime" >
                                	<span class="input-group-addon">到</span>
                                	<input type="text" class="form-control laydate-icon" name="sendEndTime" id="userBonusSendEndTime">
                            		</div>
					        	</div>
               		 		</div>
               		 		<div class="row" style="margin-bottom: 10px;">
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
					        	<div class="col-md-3">
					            	<div class="input-group">
					            		<span class="input-group-addon">基金账户</span>
					                    <input type="text" class="form-control" name="userNo" id="userNo">
					                </div>
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
					            		<span class="input-group-addon">分红方式</span>
					                    <input type="text" class="form-control" name="type" id="type">
					                </div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="userBonusTable" > </table>
                    </div>
				</div>
</div>
