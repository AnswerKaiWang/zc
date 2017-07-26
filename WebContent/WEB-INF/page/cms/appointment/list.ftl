<script>
$(function(){
	$('#appointmentListMain #appointmentTable').bootstrapTable({
        url:'${base}/admin/appointment/list.htm',
        queryParams:function(params){
        	$.each($("#appointmentListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'name',
            title: '姓名',
            align: 'center'
        },{
            field: 'phone',
            title: '电话',
            align: 'center'
        },{
            field: 'city',
            title: '城市',
            align: 'center'
        },{
            field: 'province',
            title: '省份',
            align: 'center'
        },{
            field: 'startTime',
            title: '预约时间',
            align: 'center'
        },{
            field: 'endTime',
            title: '回访时间',
            align: 'center'
        },{
            field: 'callbackStatus',
            title: '状态',
            align: 'center',
            sortable:"true",
            formatter: function(value){
            	if(1 == value){ 
	            	return "已回访";
            	}else{
            		return "未回访";
            	}
            	
            }
        },{
            field: 'remark',
            title: '备注',
            align: 'center'
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
        	formatter:function(value,row){
        		var html="";
        		if(row.callbackStatus ==0)
        			html=html+'<a class="btn btn-primary btn-xs" onclick="confirmCallback(\''+value+'\')">确认</a>&nbsp';
				return html;
            }
        }],
        sortName:"start_time",
        sortOrder:"desc"
    });
            
 	$("#appointmentListSearch").click(function(){
		$('#appointmentListMain #appointmentTable').bootstrapTable("refresh")
	})
	//添加合同
    laydateToId('startTime');
    laydateToId('endTime');
});
//编辑合同
function confirmCallback(value){
	layer.prompt(function(val){
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value,remark: val},
			url:"${base}/admin/appointment/confirm.htm",
			success:function(data){
				if(data.error=="00"){
					layer.closeAll();
					alertMsg('修改成功', 1);
					$('#appointmentListMain #appointmentTable').bootstrapTable("refresh")
				}else{
					alertMsg(data.error,0)
				}
			},error:function(){
				alertMsg("系统异常,请重试")
			}
		});
	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="appointmentListMain">
	<div class="ibox">
        <div class="ibox-content">
        	<form class="form-horizontal" id="appointmentListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<!-- 
    			<select name="companyId" id="companyId" style="width:300px;">
    				<option value="">全部</option>
    				[#list companys as co]
    				<option value="${co.id}">${(co.companyAbbr)!}</option>
    				[/#list]
    			</select>
    			-->
    			<button type="button" class="btn btn-primary fa fa-search" id="appointmentListSearch">查询</button>
    			</div>
    		</div>
	        <div class="row" style="margin-bottom: 10px;">
	        	<div class="col-md-3">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">姓名</span>
	                    <input type="text" class="form-control" name="name" id="name">
	                </div>
	        	</div>
	        	<div class="col-md-3">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">电话</span>
	                    <input type="text" class="form-control" name="phone" id="phone">
	                </div>
	        	</div>
	        	<div class="col-md-2">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">是否回访</span>
	                    <select class="form-control" name="callbackStatus" id="callbackStatus">
	                    	<option value="">全部</option>
	                    	<option value=0>未回访</option>
	                    	<option value=1>已回访</option>
	                    </select>
	                </div>
	        	</div>
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
                	<span class="input-group-addon">预约时间</span>
                	<input type="text" class="form-control laydate-icon" name="startTime" id="startTime" >
                	<span class="input-group-addon">到</span>
                	<input type="text" class="form-control laydate-icon" name="endTime" id="endTime">
            		</div>
	        	</div>
	 		</div>
			</form>
			<table class="table table-bordered" id="appointmentTable"></table>
        </div>
	</div>
</div>
