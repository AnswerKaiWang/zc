<script>
$(function(){
	$('#noticeListMain #noticeTable').bootstrapTable({
        url:'${base}/admin/notice/list.htm',
        queryParams:function(params){
        	$.each($("#noticeListMain").find("form").serializeArray(),function(key,value){
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
            field: 'url',
            title: '链接地址',
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
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editNotice(\''+value+'\')">编辑</a>&nbsp';
				return html;
            }
        }],
        sortName:"createTime",
        sortOrder:"desc"
    });
            
 	$("#noticeListSearch").click(function(){
		$('#noticeListMain #noticeTable').bootstrapTable("refresh")
	});
	$("#noticeListMain #noticeAdd").click(function(){
	 	openWindows("添加公告","${base}/admin/notice/add.htm",null,
	 	function(index,layero){
	 		noticeAddForm(index)
	 	});
	})
});
function editNotice(value){
		openWindows("修改公告","${base}/admin/notice/edit.htm",{id:value},
	 	function(index,layero){
	 		noticeEditForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="noticeListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="noticeAdd">添加</button>
        </div>
        <div class="ibox-content">
        	<form class="form-horizontal" id="noticeListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<button type="button" class="btn btn-primary fa fa-search" id="noticeListSearch">查询</button>
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
			<table class="table table-bordered" id="noticeTable"></table>
        </div>
	</div>
</div>
