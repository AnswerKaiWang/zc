<script>
$(function(){
	$('#sysConfigListMain #sysConfigTable').bootstrapTable({
        url:'${base}/admin/sysConfig/list.htm',
        queryParams:function(params){
        	$.each($("#sysConfigListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'name',
            title: '名称',
            align: 'center'
        },{
            field: 'sysKey',
            title: '键',
            align: 'center'
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
        	formatter:function(value){
        		var html="";
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editSysConfig(\''+value+'\')">编辑</a>&nbsp';
				return html;
            }
        }],
        sortName:"createTime",
        sortOrder:"desc"
    });
 	$("#sysConfigListSearch").click(function(){
		$('#sysConfigListMain #sysConfigTable').bootstrapTable("refresh")
	});
	$("#sysConfigListMain #sysConfigAdd").click(function(){
	 	openWindows("添加属性","${base}/admin/sysConfig/add.htm",null,
	 	function(index,layero){
	 		sysConfigAddForm(index)
	 	});
	});
});
function editSysConfig(value){
		openWindows("修改属性","${base}/admin/sysConfig/edit.htm",{id:value},
	 	function(index,layero){
	 		sysConfigEditForm(index)
	 	});
}
</script>

<div class="animated fadeInRight" style="width:100%;height:100%;" id="sysConfigListMain">
	<div class="ibox-title">
		<button type="button" class="btn btn-primary fa fa-plus" id="sysConfigAdd">添加</button>
	</div>
	<div class="ibox">
        <div class="ibox-content">
        	<form class="form-horizontal" id="sysConfigListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<select name="companyId" id="companyId" style="width:300px;">
    				<option value="">全部</option>
    				[#list companys as co]
    				<option value="${co.id}">${(co.companyAbbr)!}</option>
    				[/#list]
    			</select>
    			<button type="button" class="btn btn-primary fa fa-search" id="sysConfigListSearch">查询</button>
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
	            		<span class="input-group-addon">电话</span>
	                    <input type="text" class="form-control" name="phone" id="phone">
	                </div>
	        	</div>
	 		</div>
			</form>
			<table class="table table-bordered" id="sysConfigTable"></table>
        </div>
	</div>
</div>
