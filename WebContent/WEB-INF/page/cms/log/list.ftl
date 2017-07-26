<script>
$(function(){
	var start = {
        fixed: true,
        elem : "#logTimeStart",
        istime : true,
        istoday : false,
        choose : function(date) {
            end.min = date; 
            end.start = date; 
        }
    };
    var end = {
        fixed: true,
        elem : "#logTimeEnd",
        istime : true,
        istoday : true,
        choose : function(date) {
            start.max = date;
        }
    };
    laydate(start);
    laydate(end);
	$('#sysLog_List_main #sysLogListTable').bootstrapTable({
                url:'${base}/admin/sysLog/list.htm',
                queryParams:function(params){
		            $.each($("#sysLogListSearchForm").serializeArray(),function(key,value){
		        			params[value.name]=value.value;
		        	})
		        	return params;
                },
                columns: [{
                    field: 'name',
                    title: '名称',
                    align: 'center'
                },{
                    field: 'contant',
                    title: '内容',
                    align: 'center'
                },{
                    field: 'createTime',
                    title: '创建时间',
                    align: 'center'
                },{
                    field: 'memberName',
                    title: '用户',
                    align: 'center'
                },{
                    field: 'ip',
                    title: 'ip',
                    align: 'center'
                }],
                sortName:"createTime",
                sortOrder:"desc"
            });
            
            
            
 	$("#sysLogListSearchButton").click(function(){
		$('#sysLog_List_main #sysLogListTable').bootstrapTable("refresh")
	})
	
	
})

</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="sysLog_List_main">
				<div class="ibox">
					<div class="ibox-title">
                    </div>
                    <div class="ibox-content">
                        	<form class="form-horizontal" id="sysLogListSearchForm" method="post" onsubmit="return false">
                			<div class="row" style="margin-bottom: 10px;">
                    			<div class="col-md-4">
                    			[@shiro.hasPermission name="canSeeCompany"]
                    			<select name="companyId" id="companyId">
                    				<option value="">全部</option>
                    				[#list companys as co]
                    				<option value="${co.id}">${(co.companyAbbr)!}</option>
                    				[/#list]
                    			</select>
                    			[/@shiro.hasPermission]
                    			<button type="button" class="btn btn-primary fa fa-search" id="sysLogListSearchButton">查询</button>
                    			</div>
                    		</div>
                			<div class="row" style="margin-bottom: 10px;">
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">名称</span>
					                    <input type="text" class="form-control" name="name" id="name">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">内容</span>
					                    <input type="text" class="form-control" name="contant" id="contant">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">用户</span>
					                    <input type="text" class="form-control" name="userName" id="userName">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">时间</span>
					                    <input type="text" class="form-control laydate-icon" name="startTime" id="logTimeStart" value="${.now?string("yyyy-MM-dd")} 00:00:00">
                               	 		<span class="input-group-addon">到</span>
                                		<input type="text" class="form-control laydate-icon" name="endTime" id="logTimeEnd" value="${.now?string("yyyy-MM-dd")} 23:59:59">
					                </div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="sysLogListTable" > </table>
                    </div>
				</div>
</div>
