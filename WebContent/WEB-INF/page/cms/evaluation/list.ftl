<script>
$(function(){
	$('#fundRiskEvaluationListMain #fundRiskEvaluationTable').bootstrapTable({
        url:'${base}/admin/risk/evaluation/list.htm',
        queryParams:function(params){
        	$.each($("#fundRiskEvaluationListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'riskLevel',
            title: '产品风险等级',
            align: 'center',
            formatter:function(value){
            	[#list risks as st]
            		if(value=='${st.id}'){
            			return '${st.name}';
            		}
            	[/#list]
            	return "";
            }
        },{
            field: 'riskNature',
            title: '产品风险性质',
            align: 'center'
        },{
            field: 'riskIntroduce',
            title: '产品风险描述',
            align: 'center'
        },{
            field: 'suitInvestor',
            title: '适合的投资者',
            align: 'center'
        },{
            field: 'createTime',
            title: '创建时间',
            align: 'center'
        },{
            field: 'updateTime',
            title: '修改时间',
            align: 'center'
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
        	formatter:function(value){
        		var html="";
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editFundRiskEvaluation(\''+value+'\')">修改</a>&nbsp';
				return html;
            }
        }],
        sortName:"create_time",
        sortOrder:"desc"
    });
 	$("#fundRiskEvaluationListSearch").click(function(){
		$('#fundRiskEvaluationListMain #fundRiskEvaluationTable').bootstrapTable("refresh")
	})
	$("#fundRiskEvaluationListMain #fundRiskEvaluationAdd").click(function(){
	 	openWindows("添加风险等级评估","${base}/admin/risk/evaluation/add.htm",null,
	 	function(index,layero){
	 		fundRiskEvaluationAddForm(index)
	 	});
	})
  	$("#fundRiskEvaluationListForm #userSecondId").select2({
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
function editFundRiskEvaluation(value){
		openWindows("修改风险等级评估","${base}/admin/risk/evaluation/edit.htm",{id:value},
	 	function(index,layero){
	 		fundRiskEvaluationEditForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="fundRiskEvaluationListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="fundRiskEvaluationAdd">添加</button>
        </div>
        <div class="ibox-content">
        	<form class="form-horizontal" id="fundRiskEvaluationListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<select name="companyId" id="companyId" style="width:300px;">
    				<option value="">全部</option>
    				[#list companys as co]
    				<option value="${co.id}">${(co.name)!}</option>
    				[/#list]
    			</select>
    			<button type="button" class="btn btn-primary fa fa-search" id="fundRiskEvaluationListSearch">查询</button>
    			</div>
    		</div>
			<div class="row" style="margin-bottom: 10px;">
				<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">名称</span>
	                    <select class="form-control" name="userSecondId" id="userSecondId"></select>
	                </div>
	        	</div>
	        </div>
			</form>
			<table class="table table-bordered" id="fundRiskEvaluationTable" > </table>
        </div>
	</div>
</div>
