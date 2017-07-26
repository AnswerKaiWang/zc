<script>
var contentEditor;
$(function(){
	formValidate("#newsEditForm",{
		fundId:{
			required: true
		},
		userSecondId:{
			required: true
		}
	});
	contentEditor = addWedEditor('${base}','content','${news.content}');
    laydateToId('publishTime');
    addFileClick('${base}','coverPicker','cover');
});
function newsEditForm(parentIndex){
	var s=$("#newsEditForm").validate().form();
	if(s){
		$("#content").html(contentEditor.$txt.text());
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#newsEditForm").serializeArray(),
			url:"${base}/admin/news/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
					$('#newsListMain #newsTable').bootstrapTable("refresh");
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
<div style="width:900px;height:650px;padding:15px;">
<form class="form-horizontal" id="newsEditForm">
	<input type="hidden" name="id" id="id"  value="${(news.id)!}">
	<br>
	<div class="form-group">
	    <label class="col-xs-2 control-label">标题</label>
	    <div class="col-xs-10">
	        <input type="text" class="form-control" name="title" id="title" value="${(news.title)!}" >
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">封面</label>
	    <div class="col-xs-8">
	    	<input type="text" class="form-control" id="cover" name="cover" readOnly value="${(news.cover)!}" >
	    </div>
	    <div class="col-xs-2">
	    	<div id="coverPicker">选择</div>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">简介</label>
	    <div class="col-xs-10">
	    	<input type="text" class="form-control" name="brief" id="brief" value="${(news.brief)!}">
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">来源</label>
	    <div class="col-xs-10">
	    	<input type="text" class="form-control" name="source" id="source" value="${(news.source)!}">
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">相关推荐</label>
	    <div class="col-xs-10">
	    	<select class="form-control" name="reference" id="reference">
	    		<option value=0 [#if 0 == news.reference]selected[/#if]>否</option>
	    		<option value=1 [#if 1 == news.reference]selected[/#if]>是</option>
	    	</select>
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">发布日期</label>
	    <div class="col-xs-10">
	    	<input type="text" class="form-control laydate-icon" name="publishTime" id="publishTime"  value="${(news.publishTime?string("yyyy-MM-dd"))!}">
	    </div>
	</div>
	<div class="form-group">
	    <label class="col-xs-2 control-label">内容</label>
	    <div class="col-xs-10">
	    	<textarea  style="height:300px;" class="form-control" name="content" id="content"></textarea>
	    </div>
	</div>
</form>
</div>