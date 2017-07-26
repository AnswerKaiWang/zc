<script>
$(function(){
	formValidate("#qtSurveyEditForm",{
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
var rowNum = ${((topic.answers)?size)!};
function addRow(){
	rowNum = rowNum+1;
	var row = '<div class="form-group">'
				+'<div class="col-xs-2"><input type="text" class="form-control" placeholder="序号" name="answers['+rowNum+'].prefix"></div>'
			    +'<div class="col-xs-7"><input type="text" class="form-control" placeholder="答案" name="answers['+rowNum+'].answer"></div>'
			    +'<div class="col-xs-2"><input type="text" class="form-control" placeholder="分数" name="answers['+rowNum+'].score"></div>'
			    +'<div class="col-xs-1" id="record_'+rowNum+'" style="cursor:pointer;" onclick="javascript:delRecord('+rowNum+');">-</div>'
			+'</div>';
	$("#qtSurveyAnswerTarget").append(row);
}
function delRecord(index){
	var row = $("#record_"+index).parent();
	if(!!row){
		row.remove();
	}
}
function qtSurveyEditForm(parentIndex){
	var s=$("#qtSurveyEditForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#qtSurveyEditForm").serializeArray(),
			url:"${base}/admin/qtSurvey/topic/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#qtSurveyListMain #qtSurveyTable').bootstrapTable("refresh");
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
<form class="form-horizontal" id="qtSurveyEditForm">
	<input type="hidden" name="id" value="${(topic.id)!}">
	<input type="hidden" name="qsId" value="${(topic.qsId)!}">
	<ul id="myTab" class="nav nav-tabs">
	   	 <li class="active"><a href="#qtSurveyTarget" data-toggle="tab">题目</a></li>
	   	 <li><a href="#qtSurveyAnswerTarget" data-toggle="tab">答案</a></li>
	</ul>
	<div class="tab-content">
		<div class="tab-pane fade in active" id="qtSurveyTarget">
			<br>
			<div class="form-group">
			    <label class="col-xs-3 control-label">排序</label>
			    <div class="col-xs-9">
			    	<input type="number" class="form-control" name="sort" id="sort" value="${(topic.sort)!}" >
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">题目</label>
			    <div class="col-xs-9">
			        <textarea type="text" class="form-control" placeholder="题目" name="title" id="title">${(topic.title)!}</textarea>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">题目类别</label>
			    <div class="col-xs-9">
			    	<select class="form-control" id="qsType" name="qsType" >
				       <option value=1 [#if 1==topic.qsType]selected=selected[/#if]>贵宾信息</option>
				       <option value=2 [#if 2==topic.qsType]selected=selected[/#if]>投资偏好调查</option>
				       <option value=3 [#if 3==topic.qsType]selected=selected[/#if]>风险偏好调查</option>
				       <option value=4 [#if 4==topic.qsType]selected=selected[/#if]>服务偏好调查</option>
                	</select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">题目类型</label>
			    <div class="col-xs-9">
			    	<select class="form-control" id="type" name="type" >
				       <option value=1 [#if 1==topic.type]selected=selected[/#if]>单选</option>
				       <option value=2 [#if 2==topic.type]selected=selected[/#if]>多选</option>
				       <option value=3 [#if 3==topic.type]selected=selected[/#if]>文本</option>
                	</select>
			    </div>
			</div>
		</div>
		<!-- 问题答案设定 -->
		<div class="tab-pane fade" id="qtSurveyAnswerTarget">
			<br>
			<div class="form-group">
			    <label class="col-xs-2 control-label">序号</label>
			    <label class="col-xs-7 control-label">答案</label>
			    <label class="col-xs-2 control-label">分数</label>
			    <label class="col-xs-1 control-label" id="addRecord" style="cursor:pointer;">+</label>
			</div> 
			[#list topic.answers as f]
			<div class="form-group">
			    <div class="col-xs-2"><input type="text" class="form-control" placeholder="序号" name="answers[${f_index}].prefix" value="${(f.prefix)!}"></div>
			    <div class="col-xs-7"><input type="text" class="form-control" placeholder="答案" name="answers[${f_index}].answer" value="${(f.answer)!}"></div>
			    <div class="col-xs-2"><input type="text" class="form-control" placeholder="分数" name="answers[${f_index}].score" value="${(f.score)!}"></div>
			    <div class="col-xs-1" style="cursor:pointer;" id="record_${f_index}" onclick="javascript:delRecord(${f_index});">-</div>
			</div>
			[/#list]
		</div>
	</div>
</form>
</div>