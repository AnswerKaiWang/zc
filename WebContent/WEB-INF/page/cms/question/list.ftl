<script>
$(function(){
	$('#questionListMain #questionTable').bootstrapTable({
        url:'${base}/admin/question/list.htm',
        queryParams:function(params){
        	$.each($("#questionListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'qtName',
            title: '名称',
            align: 'center',
            sortable:"true"
        },{
            field: 'sort',
            title: '序号',
            align: 'center',
            sortable:"true",
            width:100
        },
        {
        	field: 'type',
            title: '类型',
            align: 'center',
            formatter:function(value){
            	[#list questionTypes as st]
            		if(value=='${st.id}'){
            			return '${st.name}';
            		}
            	[/#list]
            	return "";
            }
        },{
            field: 'name',
            title: '题目',
            align: 'center'
        },{
        	field:'ffffff',
        	title: '操作',
       		align: 'center',
       		width:80,
        	formatter:function(value,row){
        		var html="";
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editQuestion(\''+row.id+'\')">修改</a>&nbsp';
				return html;
            }
        }],
        sortName:"sort",
        sortOrder:"asc"
    });
 	$("#questionListSearch").click(function(){
 		var qtId = $("#qtId").val();
		if(!qtId){
			alertMsg("请先选择名称");
			$("#qtId").focus();
			return false;
		}
		$('#questionListMain #questionTable').bootstrapTable("refresh")
	})
	$("#questionListMain #questionAdd").click(function(){
		var qtId = $("#qtId").val();
		if(!qtId){
			alertMsg("请先选择名称");
			$("#qtId").focus();
			return false;
		}
		 openWindows("添加测评","${base}/admin/question/add.htm?qtId="+qtId,null,
		 function(index,layero){
		 	questionSubmitForm(index)
		 });
	});
	$("#qtId").on("change",function(){
		var qtId = $("#qtId").val();
		if(!!qtId)
		$('#questionListMain #questionTable').bootstrapTable("refresh");
	});
	$("#questionListForm #qtId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/question/searchQuestionList.htm",
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
function editQuestion(value){
	var qtId = $("#qtId").val();
	if(!qtId){
		alertMsg("请先选择名称");
		$("#qtId").focus();
		return false;
	}
	openWindows("修改测评","${base}/admin/question/toEdit.htm",{id:value,qtId: qtId},
		function(index,layero){
		questionEditForm(index);
	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="questionListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="questionAdd">添加</button>
        </div>
        <div class="ibox-content">
    		<form class="form-horizontal" id="questionListForm" method="post" onsubmit="return false">
    		<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-4">
    			<button type="button" class="btn btn-primary fa fa-search" id="questionListSearch">查询</button>
    			</div>
    		</div>
			<div class="row" style="margin-bottom: 10px;">
	      		<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">名称</span>
	                    <select class="form-control" name="qtId" id="qtId"></select>
	                </div>
	        	</div>
	 		</div>
			</form>
			<table class="table table-bordered" id="questionTable"> </table>
        </div>
	</div>
</div>
