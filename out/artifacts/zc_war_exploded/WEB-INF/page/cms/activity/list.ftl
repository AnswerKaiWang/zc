<script>
$(function(){
	$('#activityListMain #activityTable').bootstrapTable({
        url:'${base}/admin/activity/list.htm',
        queryParams:function(params){
        	$.each($("#activityListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'title',
            title: '标题',
            align: 'center'
        },{
            field: 'subhead',
            title: '副标题',
            align: 'center'
        },{
            field: 'startTime',
            title: '开始时间',
            align: 'center'
        },{
            field: 'endTime',
            title: '结束时间',
            align: 'center'
        },{
            field: 'createTime',
            title: '创建时间',
            align: 'center'
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
        	formatter:function(value){
        		var html="";
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editActivity(\''+value+'\')">编辑</a>&nbsp';
				return html;
            }
        }],
        sortName:"createTime",
        sortOrder:"desc"
    });
 	$("#activityListSearch").click(function(){
		$('#activityListMain #activityTable').bootstrapTable("refresh")
	});
	$("#activityListMain #activityAdd").click(function(){
	 	openWindows("添加活动","${base}/admin/activity/add.htm",null,
	 	function(index,layero){
	 		activityAddForm(index)
	 	});
	})
});
function editActivity(value){
		openWindows("修改活动","${base}/admin/activity/edit.htm",{id:value},
	 	function(index,layero){
	 		activityEditForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="activityListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="activityAdd">添加</button>
        </div>
        <div class="ibox-content">
        	<form class="form-horizontal" id="activityListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<button type="button" class="btn btn-primary fa fa-search" id="activityListSearch">查询</button>
    			</div>
    		</div>
	        <div class="row" style="margin-bottom: 10px;">
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">标题</span>
	                    <input type="text" class="form-control" name="title" id="title">
	                </div>
	        	</div>
	 		</div>
			</form>
			<table class="table table-bordered" id="activityTable"></table>
        </div>
	</div>
</div>
