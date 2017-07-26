<script>
$(function(){
	$('#messageListMain #messageTable').bootstrapTable({
        url:'${base}/admin/message/list.htm',
        queryParams:function(params){
        	$.each($("#messageListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'fromUid',
            title: '发送人',
            align: 'center'
        },{
            field: 'toUid',
            title: '接收人',
            align: 'center'
        },{
            field: 'content',
            title: '内容',
            align: 'center'
        },{
            field: 'createTime',
            title: '发送时间',
            align: 'center'
        },{
            field: 'readed',
            title: '状态',
            align: 'center',
            sortable:"true",
            formatter: function(value){
            	if(1 == value){ return "已读";}
            	return "未读";
            }
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
        	formatter:function(value){
        		var html="";
        		//html=html+'<a class="btn btn-primary btn-xs" onclick="editmessage(\''+value+'\')">确认</a>&nbsp';
				return html;
            }
        }],
        sortName:"createTime",
        sortOrder:"desc"
    });
            
 	$("#messageListSearch").click(function(){
		$('#messageListMain #messageTable').bootstrapTable("refresh")
	})
    laydateToId('startTime');
    laydateToId('endTime');
});
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="messageListMain">
	<div class="ibox">
        <div class="ibox-content">
        	<form class="form-horizontal" id="messageListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<select name="companyId" id="companyId" style="width:300px;">
    				<option value="">全部</option>
    				[#list companys as co]
    				<option value="${co.id}">${(co.companyAbbr)!}</option>
    				[/#list]
    			</select>
    			<button type="button" class="btn btn-primary fa fa-search" id="messageListSearch">查询</button>
    			</div>
    		</div>
	        <div class="row" style="margin-bottom: 10px;">
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">姓名</span>
	                    <input type="text" class="form-control" name="name" id="name">
	                </div>
	        	</div>
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">电话</span>
	                    <input type="text" class="form-control" name="phone" id="phone">
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
			<table class="table table-bordered" id="messageTable"></table>
        </div>
	</div>
</div>
