<script>
$(function(){
	$('#qtSurveyTopicListMain #qtSurveyTopicTable').bootstrapTable({
        url:'${base}/admin/qtSurvey/topic/list.htm',
        queryParams:function(params){
        	$.each($("#qtSurveyTopicListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'sort',
            title: '序号',
            align: 'center',
            sortable:"true",
            width:100
        },{
            field: 'title',
            title: '题目',
            align: 'center'
        },{
        	field: 'qsType',
            title: '题目类别',
            align: 'center',
            formatter:function(value){
            	if(1 == value){return "贵宾信息";}
            	if(2 == value){return "投资偏好调查";}
            	if(3 == value){return "风险偏好调查";}
            	if(4 == value){return "服务偏好调查";}
            	return value;
            }
        },
        {
        	field: 'type',
            title: '题目类型',
            align: 'center',
            formatter:function(value){
            	if(1==value){return "单选";}
            	if(2==value){return "多选";}
            	if(3==value){return "文本";}
            	return value;
            }
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
       		width:80,
        	formatter:function(value,row){
        		var html="";
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editQsTopic(\''+value+'\')">修改</a>&nbsp';
				return html;
            }
        }],
        sortName:"id",
        sortOrder:"asc"
    });
 	$("#qtSurveyTopicListSearch").click(function(){
 		var qsId = $("#qsId").val();
		if(!qsId){
			alertMsg("请先问卷调查");
			$("#qsId").focus();
			return false;
		}
		$('#qtSurveyTopicListMain #qtSurveyTopicTable').bootstrapTable("refresh")
	})
	$("#qtSurveyTopicListMain #qtSurveyTopicAdd").click(function(){
		var qsId = $("#qsId").val();
		if(!qsId){
			alertMsg("请先问卷调查");
			$("#qsId").focus();
			return false;
		}
		 openWindows("添加问卷调查题目","${base}/admin/qtSurvey/topic/add.htm?qsId="+qsId,null,
		 function(index,layero){
		 	qtSurveySubmitForm(index)
		 });
	});
	$("#qsId").on("change",function(){
		var qsId = $("#qsId").val();
		if(!!qsId)
		$('#qtSurveyTopicListMain #qtSurveyTopicTable').bootstrapTable("refresh");
	});
	//问卷调查
	$("#qtSurveyTopicListForm #qsId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/qtSurvey/searchQsList.htm",
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
})
function editQsTopic(value){
	openWindows("修改问卷调查题目","${base}/admin/qtSurvey/topic/edit.htm",{id:value},
		function(index,layero){
			qtSurveyEditForm(index);
	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="qtSurveyTopicListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="qtSurveyTopicAdd">添加</button>
        </div>
        <div class="ibox-content">
    		<form class="form-horizontal" id="qtSurveyTopicListForm" method="post" onsubmit="return false">
    		<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-4">
    			<button type="button" class="btn btn-primary fa fa-search" id="qtSurveyTopicListSearch">查询</button>
    			</div>
    		</div>
			<div class="row" style="margin-bottom: 10px;">
	      		<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">问卷调查</span>
	                    <select class="form-control" name="qsId" id="qsId"></select>
	                </div>
	        	</div>
	 		</div>
			</form>
			<table class="table table-bordered" id="qtSurveyTopicTable"> </table>
        </div>
	</div>
</div>
