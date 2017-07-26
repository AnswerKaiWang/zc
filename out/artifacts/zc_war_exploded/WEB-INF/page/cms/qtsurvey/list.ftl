<script>
$(function(){
	$('#qtSurveyListMain #qtSurveyTable').bootstrapTable({
        url:'${base}/admin/qtSurvey/list.htm',
        queryParams:function(params){
        	$.each($("#qtSurveyListMain").find("form").serializeArray(),function(key,value){
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
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editQtSurvey(\''+row.id+'\')">修改</a>&nbsp';
				return html;
            }
        }],
        sortName:"start_time",
        sortOrder:"desc"
    });
 	$("#qtSurveyListSearch").click(function(){
		$('#qtSurveyListMain #qtSurveyTable').bootstrapTable("refresh")
	})
	$("#qtSurveyListMain #qtSurveyAdd").click(function(){
		 openWindows("添加调查问卷","${base}/admin/qtSurvey/add.htm",null,
		 function(index,layero){
		 	qtSurveyAddSubmitForm(index)
		 });
	});
})
function editQtSurvey(value){
	openWindows("修改调查问卷","${base}/admin/qtSurvey/edit.htm",{id:value},
		function(index,layero){
			qtSurveyEditSubmitForm(index);
	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="qtSurveyListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="qtSurveyAdd">添加</button>
        </div>
        <div class="ibox-content">
    		<form class="form-horizontal" id="qtSurveyListForm" method="post" onsubmit="return false">
    		<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-4">
    			<button type="button" class="btn btn-primary fa fa-search" id="qtSurveyListSearch">查询</button>
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
			<table class="table table-bordered" id="qtSurveyTable"> </table>
        </div>
	</div>
</div>
