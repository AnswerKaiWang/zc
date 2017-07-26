<script>
$(function(){
	$('#activityApplyListMain #activityApplyTable').bootstrapTable({
        url:'${base}/admin/activity/apply/list.htm',
        queryParams:function(params){
        	$.each($("#activityApplyListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'actName',
            title: '活动',
            align: 'center'
        },{
            field: 'name',
            title: '姓名',
            align: 'center'
        },{
            field: 'phone',
            title: '电话',
            align: 'center'
        },{
            field: 'memberNum',
            title: '报名人数',
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
        		//html=html+'<a class="btn btn-primary btn-xs" onclick="editActivity(\''+value+'\')">编辑</a>&nbsp';
				return html;
            }
        }],
        sortName:"createTime",
        sortOrder:"desc"
    });
 	$("#activityApplyListSearch").click(function(){
		$('#activityApplyListMain #activityApplyTable').bootstrapTable("refresh")
	});
});
function editActivity(value){
		openWindows("修改活动","${base}/admin/activity/edit.htm",{id:value},
	 	function(index,layero){
	 		activityEditForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="activityApplyListMain">
	<div class="ibox">
        <div class="ibox-content">
        	<form class="form-horizontal" id="activityApplyListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<button type="button" class="btn btn-primary fa fa-search" id="activityApplyListSearch">查询</button>
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
			<table class="table table-bordered" id="activityApplyTable"></table>
        </div>
	</div>
</div>
