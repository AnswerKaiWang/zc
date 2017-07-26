<script>
$(function(){
	
});
</script>
<div style="width:600px;height:400px;padding:15px;">
<form class="form-horizontal" id="questionTimePrintForm">
	<br>
	<div class="form-group">
	    <label class="col-xs-3 control-label">名称</label>
	    <div class="col-xs-9">
	        <textarea type="text" class="form-control" placeholder="名称" name="name" id="name"></textarea>
	    </div>
	</div>
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
</form>
</div>