<script>
$(function(){
	$('#messageUsersListMain #messageUsersTable').bootstrapTable({
        url:'${base}/admin/message/users.htm',
        queryParams:function(params){
        	$.each($("#messageUsersListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'name',
            title: '姓名',
            align: 'center'
        },{
            field: 'userType',
            title: '用户类型',
            align: 'center',
            formatter:function(val){
            	if(val =='geren'){
            		return "个人";
            	}else{
            		return "企业";
            	}
            }
        },{
            field: 'memberName',
            title: '财富顾问',
            align: 'center'
        },{
            field: 'userLevelId',
            title: '用户等级',
            align: 'center',
                    formatter:function(value){
                    	[#list levels as st]
                    	if("${st.id}"==value){
                    		return "${st.name}";
                    	}
                    	[/#list]
                    	return '';
                    }
        },{
            field: 'cardType',
            title: '证件类型',
            align: 'center',
            sortable:"true",
                    formatter:function(value){
                    	[#list types as st]
                    	if("${st.id}"==value){
                    		return "${st.name}";
                    	}
                    	[/#list]
                    	return '';
                    }
        },{
            field: 'cardNo',
            title: '证件号',
            align: 'center'
        },{
            field: 'phone',
            title: '电话',
            align: 'center'
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
        	formatter:function(value){
        		var html="";
        		//html=html+'<a class="btn btn-primary btn-xs" onclick="editmessageUser(\''+value+'\')">确认</a>&nbsp';
				return html;
            }
        }],
        sortName:"create_time",
        sortOrder:"desc"
    });
            
 	$("#messageUsersListSearch").click(function(){
		$('#messageUsersListMain #messageUsersTable').bootstrapTable("refresh")
	});
    laydateToId('startTime');
    laydateToId('endTime');
    $("#messageUsersListMain #memberId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/member/searchMemberList.htm",
	    	dataType: 'json',
	    	delay: 250,
	    	cache: false,
	    	type: 'GET',
	    	data: function (params) {
	      		return {search: params.term}
	    	},
	    	processResults: function (data, page) { 
	    			return {results: data}
	    	}  
    	}
  	});
  	$("#messageUsersListMain #fundId").select2({
		language: "zh-CN",
		allowClear:true,
		placeholder:"请查询",
	  	ajax: {
	    	url: "${base}/admin/fund/searchFundList.htm",
	    	dataType: 'json',
	    	delay: 250,
	    	cache: false,
	    	type: 'GET',
	    	data: function (params) {
	      		return {search: params.term}
	    	},
	    	processResults: function (data, page) { 
	    			return {results: data}
	    	}  
    	}
  	});
});

function sendMsg(){
	var ids=[];
	var rows=$('#messageUsersListMain #messageUsersTable').bootstrapTable("getSelections");
	if(rows==null||rows.length==0){
		alertMsg("请至少选择一个客户",0)
		return false;
	}
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i]["id"]);
	}
	openWindows("消息内容","${base}/admin/message/toSendMsg.htm",{ids:ids},
	 	function(index,layero){
	 		sendMsgSubmit(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="messageUsersListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" onclick="sendMsg()">发送</button>
        </div>
        <div class="ibox-content">
        	<form class="form-horizontal" id="messageUsersListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<button type="button" class="btn btn-primary fa fa-search" id="messageUsersListSearch">查询</button>
    			</div>
    		</div>
	        <div class="row" style="margin-bottom: 10px;">
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">姓名</span>
	                    <input type="text" class="form-control" name="name" id="name">
	                </div>
	        	</div>
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">用户类型</span>
	                    <select class="form-control" name="userType" id="userType">
	                    	<option value=''>全部</option>
	                    	<option value='geren'>个人</option>
	                    	<option value='qiye'>企业</option>
	                    </select>
	                </div>
	        	</div>
	        	<div class="col-md-2">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">财富顾问</span>
	                    <select class="form-control" name="memberId" id="memberId"></select>
	                </div>
	        	</div>
	        	<div class="col-md-2">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">产品</span>
	                    <select class="form-control" name="fundId" id="fundId"></select>
	                </div>
	        	</div>
	 		</div>
	 		<div class="row" style="margin-bottom: 10px;">
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">用户等级</span>
	                    <select class="form-control" name="userLevel" id="userLevel">
	                    	<option value="">全部</option>
	                    	[@dict name="userLevel" ]
		                    	[#list dictList as st]
		                    		<option value="${st.id}">${st.name}</option>
		                    	[/#list]
	                    	[/@dict]
	                    </select>
	                </div>
	        	</div>
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">证件号</span>
	                    <input type="text" class="form-control" name="cardNo" id="cardNo">
	                </div>
	        	</div>
	        	<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">电话</span>
	                    <input type="text" class="form-control" name="phone" id="phone">
	                </div>
	        	</div>
	 		</div>
			</form>
			<table class="table table-bordered" id="messageUsersTable"></table>
        </div>
	</div>
</div>
