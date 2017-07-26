<script>
$(function(){
	$('#lectureListMain #lectureTable').bootstrapTable({
        url:'${base}/admin/lecture/list.htm',
        queryParams:function(params){
        	$.each($("#lectureListMain").find("form").serializeArray(),function(key,value){
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
            field: 'brief',
            title: '简介',
            align: 'center'
        },{
            field: 'lastestTime',
            title: '最后一次更新时间',
            align: 'center'
        },{
            field: 'recStatus',
            title: '是否推荐',
            align: 'center',
            formatter:function(value){
            	if(0 == value){return "否";}
            	if(1 == value){return "是";}
            	return "";
            }
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
        	formatter:function(value){
        		var html="";
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editLecture('+value+')">编辑</a>&nbsp';
				return html;
            }
        }],
        sortName:"createTime",
        sortOrder:"desc"
    });
            
 	$("#lectureListSearch").click(function(){
		$('#lectureListMain #lectureTable').bootstrapTable("refresh")
	});
	$("#lectureListMain #lectureAdd").click(function(){
	 	openWindows("添加微讲堂","${base}/admin/lecture/add.htm",null,
	 	function(index,layero){
	 		lectureAddForm(index)
	 	});
	});
});
function editLecture(id){
	openWindows("修改微讲堂","${base}/admin/lecture/edit.htm",{id: id},
	 	function(index,layero){
	 		lectureEditForm(index);
	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="lectureListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="lectureAdd">添加</button>
        </div>
        <div class="ibox-content">
        	<form class="form-horizontal" id="lectureListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<button type="button" class="btn btn-primary fa fa-search" id="lectureListSearch">查询</button>
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
			<table class="table table-bordered" id="lectureTable"></table>
        </div>
	</div>
</div>
