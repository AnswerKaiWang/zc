<script>
$(function(){
	
});
</script>

<div style="width:800px;height:600px;padding:15px;">
<form class="form-horizontal" id="detailForm">
		<div class="form-group">
		    <label class="col-xs-3 control-label">题目</label>
		    <div class="col-xs-9">
		        <textarea type="text" class="form-control" placeholder="题目" name="name" id="name">${(question.name)!}</textarea>
		    </div>
		</div>
		<div class="form-group">
		    <label class="col-xs-3 control-label">开始时间</label>
		    <div class="col-xs-9">
		    	<input type="text" class="form-control laydate-icon" name="startTime" id="startTime" value="${(question.startTime?string("yyyy-MM-dd"))!}" >
		    </div>
		</div>
		<div class="form-group">
		    <label class="col-xs-3 control-label">结束时间</label>
		    <div class="col-xs-9">
		    	<input type="text" class="form-control laydate-icon"  name="endTime" id="endTime"  value="${(question.endTime?string("yyyy-MM-dd"))!}">
		    </div>
		</div>
		<div class="form-group">
		    <label class="col-xs-3 control-label">排序</label>
		    <div class="col-xs-9">
		    	<input type="number" class="form-control" name="sort" id="sort" value="${(question.sort)!}">
		    </div>
		</div>
</form>
</div>