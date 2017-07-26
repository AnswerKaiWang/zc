<script>
$(function(){
	$('#fundRiskBearListMain #fundRiskBearTable').bootstrapTable({
        url:'${base}/admin/risk/bear/list.htm',
        queryParams:function(params){
        	$.each($("#fundRiskBearListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'scoreMin',
            title: '风险偏好总得分',
            align: 'center',
            formatter: function(value,row){
            	return value+"分~"+row.scoreMax+"分"
            }
        },{
            field: 'riskBear',
            title: '风险承受能力类型',
            align: 'center'
        },{
            field: 'riskNotification',
            title: '您可以接受的情况',
             width: 600,
            align: 'center'
        },{
            field: 'riskLevel',
            title: '适合的产品风险等级',
            align: 'center'
        },{
            field: 'suitRiskArea',
            title: '适合的产品风险范围',
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
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editFundRiskBear(\''+value+'\')">修改</a>&nbsp';
				return html;
            }
        }],
        sortName:"create_time",
        sortOrder:"desc"
    });
 	$("#fundRiskBearListSearch").click(function(){
		$('#fundRiskBearListMain #fundRiskBearTable').bootstrapTable("refresh")
	})
	//添加合同
	$("#fundRiskBearListMain #fundRiskBearAdd").click(function(){
	 	openWindows("添加风险承受能力评估说明","${base}/admin/risk/bear/add.htm",null,
	 	function(index,layero){
	 		fundRiskBearAddForm(index)
	 	});
	})
  	$("#fundRiskBearListForm #userSecondId").select2({
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
//编辑合同
function editFundRiskBear(value){
		openWindows("修改风险承受能力评估说明","${base}/admin/risk/bear/edit.htm",{id:value},
	 	function(index,layero){
	 		fundRiskBearEditForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="fundRiskBearListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="fundRiskBearAdd">添加</button>
        </div>
        <div class="ibox-content">
        	<form class="form-horizontal" id="fundRiskBearListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<select name="companyId" id="companyId" style="width:300px;">
    				<option value="">全部</option>
    				[#list companys as co]
    				<option value="${co.id}">${(co.companyAbbr)!}</option>
    				[/#list]
    			</select>
    			<button type="button" class="btn btn-primary fa fa-search" id="fundRiskBearListSearch">查询</button>
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
			<table class="table table-bordered" id="fundRiskBearTable" > </table>
        </div>
	</div>
</div>
