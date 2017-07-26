<script>
$(function(){
	$('#newsListMain #newsTable').bootstrapTable({
        url:'${base}/admin/news/list.htm',
        queryParams:function(params){
        	$.each($("#newsListMain").find("form").serializeArray(),function(key,value){
        		params[value.name]=value.value;
        	})
        	return params;
        },
        columns: [{
            field: 'state',
            checkbox: true
        },{
            field: 'title',
            title: '标题',
            align: 'center'
        },{
            field: 'brief',
            title: '简介',
            align: 'center'
        },{
            field: 'publishTime',
            title: '发布日期',
            align: 'center'
        },{
        	field:'id',
        	title: '操作',
       		align: 'center',
        	formatter:function(value){
        		var html="";
        		html=html+'<a class="btn btn-primary btn-xs" onclick="editNews(\''+value+'\')">修改</a>&nbsp';
				//html=html+'<a class="btn btn-primary btn-xs" onclick="deleteNews(\''+value+'\')">删除</a>&nbsp';
				return html;
            }
        }],
        sortName:"createTime",
        sortOrder:"desc"
    });
 	$("#newsListSearch").click(function(){
		$('#newsListMain #newsTable').bootstrapTable("refresh")
	})
	//添加合同
	$("#newsListMain #newsAdd").click(function(){
	 	openWindows("添加快讯","${base}/admin/news/add.htm",null,
	 	function(index,layero){
	 		newsAddForm(index)
	 	});
	})
});
//编辑合同
function editNews(value){
		openWindows("修改合同","${base}/admin/news/edit.htm",{id:value},
	 	function(index,layero){
	 		newsEditForm(index)
	 	});
}
function deleteNews(value){
	layer.alert("确认要删除吗?",function(laiyerIndex){
		closeMsg(laiyerIndex);
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{id:value},
			url:"${base}/admin/news/delete.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(o);
					alertMsg('删除成功', 1);
					$('#newsListMain #newsTable').bootstrapTable("refresh")
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
<div class="animated fadeInRight" style="width:100%;height:100%;" id="newsListMain">
	<div class="ibox">
		<div class="ibox-title">
        	<button type="button" class="btn btn-primary fa fa-plus" id="newsAdd">添加</button>
        </div>
        <div class="ibox-content">
        	<form class="form-horizontal" id="newsListForm" method="post" onsubmit="return false">
			<div class="row" style="margin-bottom: 10px;">
    			<div class="col-md-6">
    			<select name="companyId" id="companyId" style="width:300px;">
    				<option value="">全部</option>
    				[#list companys as co]
    				<option value="${co.id}">${(co.companyAbbr)!}</option>
    				[/#list]
    			</select>
    			<button type="button" class="btn btn-primary fa fa-search" id="newsListSearch">查询</button>
    			</div>
    		</div>
			<div class="row" style="margin-bottom: 10px;">
				<div class="col-md-4">
	            	<div class="input-group input-group-sm">
	            		<span class="input-group-addon">标题</span>
	                    <input type="text" name="title" id="title" />
	                </div>
	        	</div>
	        </div>
			</form>
			<table class="table table-bordered" id="newsTable" > </table>
        </div>
	</div>
</div>
