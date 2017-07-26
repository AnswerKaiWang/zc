<script>
$(function(){
	formValidate("#lectureAddForm",{
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
	addFileClick('${base}','coverFileBtn','cover');
	laydateToId('lastestTime');
})	
var rowNum =0;
function addRow(){
	rowNum = rowNum+1;
	var row = '<div class="form-group" id="row_'+rowNum+'_1">'
				+'<label class="col-xs-2 control-label">名称</label><div class="col-xs-10"><input type="text" class="form-control" placeholder="名称" name="vedios['+rowNum+'].name"></div>'
			    +'</div>'
			    +'<div class="form-group" id="row_'+rowNum+'_2">'
			    +'<label class="col-xs-2 control-label">文件</label><div class="col-xs-7"><input type="text" class="form-control" id="iptBtn_'+rowNum+'" placeholder="请上传音频文件，只支持mp3" name="vedios['+rowNum+'].path"></div>'
				+'<div class="col-xs-2" id="fileBtn_'+rowNum+'">选择</div><div class="col-xs-1" id="record_'+rowNum+'" style="cursor:pointer;" onclick="javascript:delRecord('+rowNum+');">-</div>'
				+'</div><hr id="row_'+rowNum+'_4">';
	$("#lectureAnswerTarget").append(row);
	addFileClick('${base}','fileBtn_'+rowNum,'iptBtn_'+rowNum);
}
function delRecord(index){
	$("div[id^='row_"+index+"']").each(function(index,ele){
		$(ele).remove();
	});
	$("hr[id^='row_"+index+"']").each(function(index,ele){
		$(ele).remove();
	});
}
function lectureAddForm(parentIndex){
	var s=$("#lectureAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#lectureAddForm").serializeArray(),
			url:"${base}/admin/lecture/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#lectureListMain #lectureTable').bootstrapTable("refresh");
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

<div style="width:800px;height:600px;padding:15px;">
<form class="form-horizontal" id="lectureAddForm">
	<ul id="myTab" class="nav nav-tabs">
	   	 <li class="active"><a href="#lectureTarget" data-toggle="tab">基本信息</a></li>
	   	 <li><a href="#lectureAnswerTarget" data-toggle="tab">文件</a></li>
	</ul>
	<div class="tab-content">
		<div class="tab-pane fade in active" id="lectureTarget">
			<br>
			<div class="form-group">
			    <label class="col-xs-3 control-label">标题</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control" placeholder="标题" name="title" id="sort">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">简介</label>
			    <div class="col-xs-9">
			        <textarea type="text" class="form-control" placeholder="简介" name="brief" id="brief"></textarea>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">最后一次更新时间</label>
			    <div class="col-xs-9">
			    	<input type="text" class="form-control laydate-icon" name="lastestTime" id="lastestTime" >
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">封面</label>
			    <div class="col-xs-7">
			    	<input type="text" class="form-control" name="cover" id="cover">
			    </div>
			    <div class="col-xs-2" id="coverFileBtn">选择</div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">是否推荐</label>
			    <div class="col-xs-9">
			    	<select class="form-control" id="recStatus" name="recStatus" >
				       <option value=0>否</option>
				       <option value=1>是</option>
                	</select>
			    </div>
			</div>
		</div>
		<!-- 问题答案设定 -->
		<div class="tab-pane fade" id="lectureAnswerTarget">
			<br>
			<label class="col-xs-12 control-label" id="addRecord" style="cursor:pointer;">+</label>
		</div>
	</div>
</form>
</div>