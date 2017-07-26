<script>
$(function(){
	$('#dictionaryListMain #dictionaryTable').bootstrapTable({
                url:'${base}/admin/dictionary/list.htm',
                queryParams:function(params){
                	$.each($("#dictionaryListMain").find("form").serializeArray(),function(key,value){
                		params[value.name]=value.value;
                	})
                	return params;
                },
                columns: [{
                    field: 'state',
                    checkbox: true
                },{
                    field: 'id',
                    title: '编号',
                    align: 'center',
                    sortable:"true",
                    width:100
                },{
                    field: 'type',
                    title: '类型',
                    align: 'center',
                    sortable:"true",
                	formatter:function(value){
                		[#list dictionaryTypes as st]
            			if(value=="${st}"){
            				return "${st.description}";
            			}
                		[/#list]
                		return "";
                    }
                },{
                    field: 'name',
                    title: '名称',
                    align: 'center'
                },{
                    field: 'note',
                    title: '备注',
                    align: 'center'
                },{
                	field:'ffffff',
                	title: '操作',
               		align: 'center',
               		width:80,
                	formatter:function(value,row){
                		var html="";
                		html=html+'<a class="btn btn-primary btn-xs" onclick="editDictionary(\''+row.id+'\')">修改</a>&nbsp';
						return html;
                    }
                }],
                sortName:"type",
                sortOrder:"desc"
            });
            
            
            
 	$("#dictionaryListSearch").click(function(){
		$('#dictionaryListMain #dictionaryTable').bootstrapTable("refresh")
	})
	
	$("#dictionaryListMain #dictionaryAdd").click(function(){
	 openWindows("添加字典","${base}/admin/dictionary/add.htm",null,
	 function(index,layero){
	 	dictionarySubmitForm(index)
	 });
	})
	
	
})
function editDictionary(value){
		openWindows("修改字典","${base}/admin/dictionary/edit.htm",{id:value},
	 	function(index,layero){
	 		dictionarySubmitForm(index)
	 	});
}
</script>
<div class="animated fadeInRight" style="width:100%;height:100%;" id="dictionaryListMain">
				<div class="ibox">
					<div class="ibox-title">
                    	<button type="button" class="btn btn-primary fa fa-plus" id="dictionaryAdd">添加</button>
                    </div>
                    <div class="ibox-content">
                    		<form class="form-horizontal" id="dictionaryListForm" method="post" onsubmit="return false">
                    		<div class="row" style="margin-bottom: 10px;">
                    			<div class="col-md-4">
                    			<button type="button" class="btn btn-primary fa fa-search" id="dictionaryListSearch">查询</button>
                    			</div>
                    		</div>
                			<div class="row" style="margin-bottom: 10px;">
                				<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">编号</span>
					                    <input type="text" class="form-control" name="id" id="id">
					                </div>
					        	</div>
					        	<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">类型</span>
					                    <select class="form-control" name="type" id="type">
					                    	<option value="">全部类型</option>
                                                [#list dictionaryTypes as sta]
                                                        <option value="${sta}">${sta.description}</option>
                                                [/#list]
					                    </select>
					                </div>
					        	</div>
					      		<div class="col-md-3">
					            	<div class="input-group input-group-sm">
					            		<span class="input-group-addon">名称</span>
					                    <input type="text" class="form-control" name="name" id="name">
					                </div>
					        	</div>
               		 		</div>
							</form>
							<table class="table table-bordered" id="dictionaryTable"> </table>
                    </div>
				</div>
</div>
