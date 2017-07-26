<script>
$(function(){
	$('#agreementListMain #agreementTable').bootstrapTable({
        url:'${base}/admin/agreement/list.htm',
        queryParams:function(params){
        	$.each($("#agreementListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'managerName',
            title: '基金管理人',
            align: 'center'
        },{
            field: 'fundName',
            title: '产品名称',
            align: 'center'
        },{
            field: 'startTime',
            title: '产品成立日',
            align: 'center'
        },{
            field: 'endTime',
            title: '产品到期日',
            align: 'center'
        },{
            field: 'custName',
            title: '客户姓名',
            align: 'center'
        },{
            field: 'custNo',
            title: '客户证件号码',
            align: 'center'
        },{
            field: 'ano',
            title: '合同编号',
            align: 'center'
        },{
            field: 'astatus',
            title: '合同状态',
            align: 'center',
            sortable:"true",
            formatter: function(value){
            	if(1 == value){ return "正常";}
            	return "废弃";
            }
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
        	formatter:function(value){
        		var html="";
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editAgreement(\''+value+'\')">修改</a>&nbsp';
				html=html+'<a class="btn btn-primary btn-xs" onclick="deleteAgreement(\''+value+'\')">删除</a>&nbsp';
				return html;
            }
        }],
        sortName:"createTime",
        sortOrder:"desc"
    });
            
 	$("#agreementListSearch").click(function(){
		$('#agreementListMain #agreementTable').bootstrapTable("refresh")
	})
	//添加合同
	$("#agreementListMain #agreementAdd").click(function(){
	 	openWindows("添加合同","${base}/admin/agreement/add.htm",null,
	 	function(index,layero){
	 		agreementAddForm(index)
	 	});
	})
    laydateToId('startTime');
    laydateToId('endTime');
    $("#agreementListForm #fundId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/fund/searchFundList.htm",
	    	dataType: 'json',
	    	delay: 250,
	    	cache: false,
	    	type: 'POST',
	    	data: function (params) {
	      		return {search: params.term,memberType:'caifuguwen'}
	    	},
	    	processResults: function (data, page) { 
	    			return {results: data}
	    	}  
    	}
  	});
  	$("#agreementListForm #userSecondId").select2({
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
  	$("#agreementListForm #memberId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/member/searchMemberList.htm",
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
function editAgreement(value){
		openWindows("修改合同","${base}/admin/agreement/edit.htm",{id:value},
	 	function(index,layero){
	 		agreementEditForm(index)
	 	});
}
function deleteAgreement(value){
	layer.alert("确认要删除吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/agreement/delete.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					alertMsg('删除成功', 1);
					$('#agreementListMain #agreementTable').bootstrapTable("refresh")
				}else{
					alertMsg(data.error,0)
				}
			},error:function(){
				closeMsg(o);
				alertMsg("系统异常,请重试")
			}
		})
	})
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="agreementListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="agreementAdd">添加</button>
        </div>
        <div class="ibox-content">
        	<form class="form-horizontal" id="agreementListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<button type="button" class="btn btn-primary fa fa-search" id="agreementListSearch">查询</button>
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
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">客户证件号码</span>
	                    <input type="text" class="form-control" name="custNo" id="custNo">
	                </div>
	        	</div>
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">基金管理人</span>
	                    <select name="companyId" id="companyId" style="width:300px;">
    						<option value="">全部</option>
    						[#list companys as co]
    						<option value="${co.id}">${(co.companyAbbr)!}</option>
    						[/#list]
    						</select>
	                </div>
	        	</div>
	        </div>
	        <div class="row" style="margin-bottom: 10px;">
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">合同编号</span>
	                    <input type="text" class="form-control" name="ano" id="ano">
	                </div>
	        	</div>
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">产品名称</span>
	            		<select class="form-control" name="fundId" id="fundId">
	                    </select>
	                </div>
	        	</div>
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
                	<span class="input-group-addon">产品成立日期</span>
                	<input type="text" class="form-control laydate-icon" name="startTime" id="startTime" >
                	<span class="input-group-addon">到</span>
                	<input type="text" class="form-control laydate-icon" name="endTime" id="endTime">
            		</div>
	        	</div>
	 		</div>
			</form>
			<table class="table table-bordered" id="agreementTable" > </table>
        </div>
	</div>
</div>
