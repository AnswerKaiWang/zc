<script>
$(function(){
	$('#userApply2ListMain #userApply2Table').bootstrapTable({
                url:'${base}/admin/userApply/list2.htm',
                queryParams:function(params){
                	$.each($("#userApply2ListMain").find("form").serializeArray(),function(key,value){
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
                    field: 'phone',
                    title: '手机号',
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
                }],
                sortName:"createTime",
                sortOrder:"desc",
                onLoadSuccess:function(){
                	//refreshAmount();
                }
    });
 	$("#userApply2ListSearch").click(function(){
 		var fid =  $("#userApply2ListForm #fundId").val();
 		if(!!fid)
			$('#userApply2ListMain #userApply2Table').bootstrapTable("refresh");
		else 
			alertMsg("请先选择产品");	
		
	});
    laydateToId('startTime');
    laydateToId('endTime');
    $("#userApply2ListForm #fundId").select2({
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
  	 $("#userApply2ListForm #fundId").on("change",function(){
  	 	//更新
  	 	//refreshAmount();
  	 	$('#userApply2ListMain #userApply2Table').bootstrapTable("refresh");
  	 });
  	 
  	 $("#startTime").val(getNow());
});
function refreshAmount(){
	var fundId = $("#userApply2ListForm #fundId").val();
	if(!fundId){
		$("#totalAmount").html("");
 		$("#remainAmount").html("");
		return ;
	}
	$.ajax({
 		url : "${base}/admin/userApply/seachAmount.htm",
 		data: {fundId: $("#userApply2ListForm #fundId").val()},
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
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="userApply2ListMain">
	<div class="ibox">
        <div class="ibox-content">
        		<h4><button type="button" class="btn btn-primary fa fa-search" id="userApply2ListSearch">查询</button></h4>
            	<form class="form-horizontal" id="userApply2ListForm" method="post" onsubmit="return false">
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
                    	<input type="text" class="form-control laydate-icon" name="startTime" id="startTime">
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
				<table class="table table-bordered" id="userApply2Table" ></table>
        </div>
	</div>
</div>
