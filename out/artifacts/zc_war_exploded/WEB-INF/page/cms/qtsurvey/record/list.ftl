<script>
$(function(){
	$('#qtSurveyRecordListMain #qtSurveyRecordTable').bootstrapTable({
        url:'${base}/admin/qtSurvey/record/list.htm',
        queryParams:function(params){
        	$.each($("#qtSurveyRecordListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'name',
            title: '客户姓名',
            align: 'center'
        },{
            field: 'createTime',
            title: '测评时间',
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
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editQuestion(\''+row.id+'\')">详情</a>&nbsp';
				return html;
            }
        }],
        sortName:"create_time",
        sortOrder:"desc"
    });
 	$("#qtSurveyRecordListSearch").click(function(){
		$('#qtSurveyRecordListMain #qtSurveyRecordTable').bootstrapTable("refresh")
	})
});
function show(id){
	openWindows("测评结果","${base}/admin/qtSurvey/his.htm",{quId: id},
		function(index,layero){
		 layer.closeAll();
	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="qtSurveyRecordListMain">
	<div class="ibox">
        <div class="ibox-content">
    		<form class="form-horizontal" id="questionListForm" method="post" onsubmit="return false">
    		<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-4">
    			<button type="button" class="btn btn-primary fa fa-search" id="qtSurveyRecordListSearch">查询</button>
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
			<table class="table table-bordered" id="qtSurveyRecordTable"> </table>
        </div>
	</div>
</div>
