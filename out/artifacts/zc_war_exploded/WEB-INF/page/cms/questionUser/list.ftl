<script>
$(function(){
	$('#questionUserListMain #questionUserTable').bootstrapTable({
        url:'${base}/admin/questionUser/list.htm',
        queryParams:function(params){
        	$.each($("#questionUserListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'custName',
            title: '用户',
            align: 'center',
            sortable:"true"
        },{
            field: 'createTime',
            title: '参加时间',
            align: 'center'
        },{
            field: 'score',
            title: '分数',
            align: 'center'
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
       		width:80,
        	formatter:function(value,row){
        		var html="";
        		html=html+'<a class="btn btn-primary btn-xs" onclick="detail(\''+value+'\')">详情</a>&nbsp';
				return html;
            }
        }],
        sortName:"createTime",
        sortOrder:"DESC"
    });
 	$("#questionUserListSearch").click(function(){
		$('#questionUserListMain #questionUserTable').bootstrapTable("refresh")
	});
	$("#questionUserListForm #userSecondId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/userSecond/searchCustList.htm",
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
});
function detail(id){
	openWindows("测评结果","${base}/admin/question/his.htm",{quId: id},
		function(index,layero){
		 layer.closeAll();
	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="questionUserListMain">
	<div class="ibox">
        <div class="ibox-content">
    		<form class="form-horizontal" id="questionUserListForm" method="post" onsubmit="return false">
    		<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-4">
    			<button type="button" class="btn btn-primary fa fa-search" id="questionUserListSearch">查询</button>
    			</div>
    		</div>
			<div class="row" style="margin-bottom: 10px;">
	      		<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">客户姓名</span>
	                    <select class="form-control" name="userSecondId" id="userSecondId">
	                    </select>
	                </div>
	        	</div>
	 		</div>
			</form>
			<table class="table table-bordered" id="questionUserTable"> </table>
        </div>
	</div>
</div>
