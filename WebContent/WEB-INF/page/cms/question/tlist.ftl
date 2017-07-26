<script>
$(function(){
	$('#questionTimeListMain #questionTimeTable').bootstrapTable({
        url:'${base}/admin/question/tlist.htm',
        queryParams:function(params){
        	$.each($("#questionTimeListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },
        {
            field: 'name',
            title: '名称',
            align: 'center'
        },{
            field: 'type',
            title: '适用对象',
            align: 'center',
            formatter:function(value){
            	if('geren' == value){
            		return '个人';
            	}
            	return '机构';
            }
        },
        {
            field: 'startTime',
            title: '开始时间',
            align: 'center',
            formatter:function(value){
            	if(!!value){
            		return value.substring(0,10);
            	}
            	return value;
            }
        },
        {
            field: 'endTime',
            title: '结束时间',
            align: 'center',
            formatter:function(value){
            	if(!!value){
            		return value.substring(0,10);
            	}
            	return value;
            }
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
       		width:80,
        	formatter:function(value,row){
        		var html="";
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editQuestion(\''+row.id+'\')">修改</a>&nbsp';
				return html;
            }
        }],
        sortName:"create_time",
        sortOrder:"desc"
    });
 	$("#questionTimeListSearch").click(function(){
		$('#questionTimeListMain #questionTimeTable').bootstrapTable("refresh")
	})
	$("#questionTimeListMain #questionTimeAdd").click(function(){
		 openWindows("添加测评","${base}/admin/question/tadd.htm",null,
		 function(index,layero){
		 	questionTimeAddSubmitForm(index)
		 });
	});
})
function editQuestion(value){
	openWindows("修改测评","${base}/admin/question/toTEdit.htm",{id:value},
		function(index,layero){
			questionTimeEditSubmitForm(index);
	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="questionTimeListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="questionTimeAdd">添加</button>
        </div>
        <div class="ibox-content">
    		<form class="form-horizontal" id="questionListForm" method="post" onsubmit="return false">
    		<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-4">
    			<button type="button" class="btn btn-primary fa fa-search" id="questionTimeListSearch">查询</button>
    			</div>
    		</div>
			<div class="row" style="margin-bottom: 10px;">
	      		<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">名称</span>
	                    <input class="form-control" name="name" id="name">
	                </div>
	        	</div>
	 		</div>
			</form>
			<table class="table table-bordered" id="questionTimeTable"> </table>
        </div>
	</div>
</div>
