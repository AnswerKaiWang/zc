<script>
$(function(){
	$('#userApplyListMain #userApplyTable').bootstrapTable({
                url:'${base}/admin/userApply/list.htm',
                queryParams:function(params){
                	$.each($("#userApplyListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
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
                    field: 'custName',
                    title: '客户姓名',
                    align: 'center'
                },{
                    field: 'custNo',
                    title: '证件号码',
                    align: 'center'
                },{
                    field: 'applyWay',
                    title: '预约方式',
                    align: 'center',
                    formatter:function(value){
                    	[#list applyTypes as st]
                    		if('${st.id}' == value){
                    			return '${st.name}';
                    		}
                    	[/#list]
                    	return value;
                    }
                },{
                    field: 'applyMoney',
                    title: '预约金额(元)',
                    align: 'center',
                    formatter:function(value){
                    	return fmtCurrency(value);
                    }
                },{
                    field: 'applyStatus',
                    title: '预约状态',
                    align: 'center',
                    clickToSelect: false,
                    formatter:function(value){
                    	[#list applyStatus as st]
                    		if('${st.id}' == value){
                    			return '${st.name}';
                    		}
                    	[/#list]
                    	return value;
                    }
                },{
                    field: 'confirMoney',
                    title: '确认金额(元)',
                    align: 'center',
                    formatter:function(value){
                    	return fmtCurrency(value);
                    }
                },{
                    field: 'confirUserName',
                    title: '确认人名称',
                    align: 'center'
                },{
                    field: 'confirDate',
                    title: '确认日期',
                    align: 'center'
                },{
                	field:'id',
                	title: '操作',
               		align: 'center',
               		width:200,
                	formatter:function(value,row){
                		var html="";
                		var confir = false;
                		[#list applyStatus as st]
                    		if('${st.id}' == row.applyStatus && '${st.name}' =='已确认'){
                    			confir = true;
                    		}
                    	[/#list]
                    	if(!confir){
                    		html=html+'<a class="btn btn-primary btn-xs" onclick="editUserApplyStatus(\''+value+'\')">确认</a>&nbsp';
                    	}else{
                    		html=html+'<a class="btn btn-primary btn-xs" onclick="cancel(\''+value+'\')">取消</a>&nbsp';
                    	}
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editUserApply(\''+value+'\')">编辑</a>&nbsp';
						return html;
                    }
                }],
                sortName:"createTime",
                sortOrder:"desc",
                onLoadSuccess:function(){
                	refreshAmount();
                }
    });
 	$("#userApplyListSearch").click(function(){
 		var fid =  $("#userApplyListForm #fundId").val();
 		if(!!fid)
			$('#userApplyListMain #userApplyTable').bootstrapTable("refresh");
		else 
			alertMsg("请先选择产品");	
		
	});
	$("#userApplyListMain #userApplyAdd").click(function(){
	 	openWindows("添加预约","${base}/admin/userApply/add.htm",null,
	 	function(index,layero){
	 		userApplyAddForm(index)
		});
	});
    laydateInit('startTime');
    laydateInit('endTime');
    
    $("#userApplyListForm #fundId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/fund/searchFundList.htm",
	    	dataType: 'json',
	    	delay: 250,
	    	cache: false,
	    	type: 'POST',
	    	data: function (params) {
	      		return {search: params.term}
	    	},
	    	processResults: function (data, page) { 
	    			return {results: data}
	    	}  
    	}
  	});
  	
  	 $("#userApplyListForm #fundId").on("change",function(){
  	 	//更新
  	 	refreshAmount();
  	 	$('#userApplyListMain #userApplyTable').bootstrapTable("refresh");
  	 });
  	 
  	 $("#startTime").val(getNow());
})

function refreshAmount(){
	var fundId = $("#userApplyListForm #fundId").val();
	if(!fundId){
		$("#totalAmount").html("");
 		$("#remainAmount").html("");
		return ;
	}
	$.ajax({
 		url : "${base}/admin/userApply/seachAmount.htm",
 		data: {fundId: $("#userApplyListForm #fundId").val()},
 		dataType:'json',
 		success:function(resp){
 			if(!!resp){
 				$("#totalAmount").html(fmtCurrency(resp.total));
 				$("#remainAmount").html(fmtCurrency(resp.remain));
 			}else{
 				$("#totalAmount").html("");
 				$("#remainAmount").html("");
 			}
 		}
 	});
}

function laydateInit(id){
	laydate({
   		fixed:true,
   		elem: '#'+id,
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         	start.max = data;
    	}
   	});
}
function cancel(value){
	var fundId = $("#userApplyListForm #fundId").val();
	if(!fundId){
		alertMsg("请先选择产品");
		return false;
	}
	layer.alert("确认要取消预约吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/userApply/cancel.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					alertMsg('取消成功', 1);
					$('#userApplyListMain #userApplyTable').bootstrapTable("refresh");
				}else{
					alertMsg(data.error,0)
				}
			},error:function(){
				closeMsg(o);
				alertMsg("系统异常,请重试")
			}
		})
	});
}
function editUserApplyStatus(value){
	var fundId = $("#userApplyListForm #fundId").val();
	if(!fundId){
		alertMsg("请先选择产品");
		return false;
	}
		openWindows("预约确认","${base}/admin/userApply/confirm.htm",{id:value},
	 	function(index,layero){
	 		userApplyConfirmForm(index);
	 	});
}
function editUserApply(value){
	openWindows("修改预约","${base}/admin/userApply/edit.htm",{id:value},
	function(index,layero){
		userApplyEditForm(index);
});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="userApplyListMain">
	<div class="ibox">
		<div class="ibox-title">
    		<button type="button" class="btn btn-primary fa fa-plus" id="userApplyAdd"> 添加</button>
        </div>
        <div class="ibox-content">
        		<h4><button type="button" class="btn btn-primary fa fa-search" id="userApplyListSearch">查询</button></h4>
            	<form class="form-horizontal" id="userApplyListForm" method="post" onsubmit="return false">
    			<div class="row">
    				<div class="col-md-4">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">产品名称</span>
		                    <select class="form-control" name="fundId" id="fundId">
		                    
		                    </select>
		                </div>
		        	</div>
		        	<div class="col-md-4">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">预约状态</span>
		                    <select class="form-control" name="status" id="status">
		                    	<option value="">全部状态</option>
                                [@dict name="yuYueStatus" ]
		                    	[#list dictList as st]
		                    		<option value="${st.id}">${st.name}</option>
		                    	[/#list]
		                    	[/@dict]
		                    </select>
		                </div>
		        	</div>
		        	<div class="col-md-4">
		            	<div class="input-group input-group-sm">
                    	<span class="input-group-addon">预约日期</span>
                    	<input type="text" class="form-control laydate-icon" name="startTime" id="startTime" >
                    	<span class="input-group-addon">到</span>
                    	<input type="text" class="form-control laydate-icon" name="endTime" id="endTime">
                		</div>
		        	</div>
   		 		</div>
   		 		<br />
   		 		<div class="row">
   		 			<div class="col-md-4">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">客户姓名</span>
		                    <input type="text" class="form-control" name="custName" id="custName">
		                </div>
		        	</div>
		        	<div class="col-md-4">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">证件号码</span>
		                    <input type="text" class="form-control" name="custNo" id="custNo">
		                </div>
		        	</div>
   		 			<div class="col-md-4">
		            	<div class="input-group input-group-sm">
		            		<span class="input-group-addon">客户手机电话</span>
		                    <input type="text" class="form-control" name="phone" id="phone">
		                </div>
		        	</div>
   		 		</div>
				</form>
				<br>
				<center>预约总额度：<span id="totalAmount"></span> &nbsp;可预约额度：<span id="remainAmount"></span></center>
				<table class="table table-bordered" id="userApplyTable" ></table>
        </div>
	</div>
</div>
