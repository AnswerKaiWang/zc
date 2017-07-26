<script>
$(function(){
	formValidate("#questionAddForm",{
		name:{
			required: true
		},
		sort:{
			required: true
		}
	});
   	$("#addRecord").on("click",function(){
		//添加一行
		addRow();
	});
})	
var rowNum =0;
function addRow(){
	rowNum = rowNum+1;
	var row = '<div class="form-group">'
				+'<div class="col-xs-2"><input type="text" class="form-control" placeholder="序号" name="answers['+rowNum+'].prefix"></div>'
			    +'<div class="col-xs-7"><input type="text" class="form-control" placeholder="答案" name="answers['+rowNum+'].answer"></div>'
			    +'<div class="col-xs-2"><input type="text" class="form-control" placeholder="分数" name="answers['+rowNum+'].score"></div>'
			    +'<div class="col-xs-1" id="record_'+rowNum+'" style="cursor:pointer;" onclick="javascript:delRecord('+rowNum+');">-</div>'
			+'</div>';
	$("#questionAnswerTarget").append(row);
}
function delRecord(index){
	var row = $("#record_"+index).parent();
	if(!!row){
		row.remove();
	}
}
function questionSubmitForm(parentIndex){
	var s=$("#questionAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#questionAddForm").serializeArray(),
			url:"${base}/admin/question/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#questionListMain #questionTable').bootstrapTable("refresh");
				}else{
					alertMsg(data.error,0)
				}
			},error:function(){
				closeMsg(o);
				alertMsg("系统异常,请重试")
			}
		})
	}
}
</script>

<div style="width:600px;height:400px;padding:15px;">
<form class="form-horizontal" id="questionAddForm">
	<input type="hidden" name="qtId" value="${(qtId)!}">
	<ul id="myTab" class="nav nav-tabs">
	   	 <li class="active"><a href="#questionTarget" data-toggle="tab">风险评测题</a></li>
	   	 <li><a href="#questionAnswerTarget" data-toggle="tab">风险评测题答案</a></li>
	</ul>
	<div class="tab-content">
		<div class="tab-pane fade in active" id="questionTarget">
			<br>
			<div class="form-group">
			    <label class="col-xs-3 control-label">题目</label>
			    <div class="col-xs-9">
			        <textarea type="text" class="form-control" placeholder="题目" name="name" id="name"></textarea>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">类型</label>
			    <div class="col-xs-9">
			    	<select class="form-control" id="type" name="type" >
				       [@dict name="questionType" ]
	                	[#list dictList as st]
	                		<option value="${st.id}">${st.name}</option>
	                	[/#list]
	                	[/@dict]
                	</select>
			    </div>
			</div>
			<!--
			<div class="form-group">
			    <label class="col-xs-3 control-label">开始时间</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control laydate-icon" name="startTime" id="startTime" >
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">结束时间</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control laydate-icon"  name="endTime" id="endTime" >
			    </div>
			</div>
			-->
			<div class="form-group">
			    <label class="col-xs-3 control-label">排序</label>
			    <div class="col-xs-9">
			    	<input type="number" class="form-control" name="sort" id="sort" value="0" >
			    </div>
			</div>
		</div>
		<!-- 问题答案设定 -->
		<div class="tab-pane fade" id="questionAnswerTarget">
			<br>
			<div class="form-group">
			    <label class="col-xs-2 control-label">序号</label>
			    <label class="col-xs-7 control-label">答案</label>
			    <label class="col-xs-2 control-label">分数</label>
			    <label class="col-xs-1 control-label" id="addRecord" style="cursor:pointer;">+</label>
			</div> 
			<div class="form-group">
			    <div class="col-xs-2"><input type="text" class="form-control" placeholder="序号" name="answers[0].prefix"></div>
			    <div class="col-xs-7"><input type="text" class="form-control" placeholder="答案" name="answers[0].answer"></div>
			    <div class="col-xs-2"><input type="text" class="form-control" placeholder="分数" name="answers[0].score"></div>
			    <div class="col-xs-1" style="cursor:pointer;" id="record_0" onclick="javascript:delRecord(0);">-</div>
			</div>
		</div>
	</div>
</form>
</div>