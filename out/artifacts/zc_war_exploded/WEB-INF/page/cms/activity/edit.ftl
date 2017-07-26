<script>
var lightspot;
var agenda;
var liveReport;
$(function(){
	formValidate("#activityEditForm",{
		title:{
			required: true
		},
		startTime:{
			required: true
		},
		endTime:{
			required: true
		}
	});
	addFileClick('${base}','coverBtn','cover');
	lightspot = addWedEditor('${base}','lightspot','${(activity.lightspot)!}');
	agenda = addWedEditor('${base}','agenda','${(activity.agenda)!}');
	liveReport = addWedEditor('${base}','liveReport','${(activity.liveReport)!}');
	
	$("#addManagerRecord").on("click",function(){
		addManagerRecord();
	});
	$("#addGuestRecord").on("click",function(){
		addGuestRecord();
	});
	$("#addFileRecord").on("click",function(){
		addFileRecord();
	});
	//基金管理人
	$("#actEditFundManager div[id^='fileBtn_']").each(function(index,ele){
		var ind = $(ele).attr("id").replace("fileBtn_","");
		$(ele).on("mouseover",function(){
			if(!$(ele).hasClass("webuploader-container")){
				addFileClick('${base}','fileBtn_'+ind,'iptBtn_'+ind);
			}
		});
	});
	//嘉宾
	$("#actEditGuest div[id^='fileBtn2_']").each(function(index,ele){
		var ind = $(ele).attr("id").replace("fileBtn2_","");
		$(ele).on("mouseover",function(){
			if(!$(ele).hasClass("webuploader-container")){
				addFileClick('${base}','fileBtn2_'+ind,'iptBtn2_'+ind);
			}
		});
	});
	//文件
	$("#actEditFile div[id^='act_file_select_']").each(function(index,ele){
		var ind = $(ele).attr("id").replace("act_file_select_","");
		$(ele).on("mouseover",function(){
			if(!$(ele).hasClass("webuploader-container")){
				addFileClick('${base}','act_file_select_'+ind,'act_file_'+ind);
			}
		});
	});
	laydateToId("startTime");
	laydateToId("endTime");
	laydateToId("agoDate");
	$("#agoCoverBtn").on("mouseover",function(){
			if(!$(this).hasClass("webuploader-container")){
				addFileClick('${base}','agoCoverBtn','agoCover');
			}
	});
	$("#actEditFile input[id^='fileActTime_']").each(function(index,ele){
		var ind = $(ele).attr("id");
		$(ele).on("click",function(){
			laydateToId(""+ind);
		});
	});
});
//基金管理人
var rowNum1 =${activity.managers?size};
function addManagerRecord(){
	rowNum1 = rowNum1+1;
	var row = '<div class="form-group" id="row1_'+rowNum1+'_1">'
				+'<label class="col-xs-2 control-label">姓名</label><div class="col-xs-4"><input type="text" class="form-control" name="managers['+rowNum1+'].name"></div>'
			    +'<label class="col-xs-2 control-label">头像</label><div class="col-xs-2"><input type="text" readOnly id="iptBtn_'+rowNum1+'" class="form-control" name="managers['+rowNum1+'].avatar"></div><div class="col-xs-2" id="fileBtn_'+rowNum1+'">选择</div>'
			 +'</div>'
			    +'<div class="form-group" id="row1_'+rowNum1+'_2">'
			    +'<label class="col-xs-2 control-label">性别</label><div class="col-xs-4"><input type="text" class="form-control" name="managers['+rowNum1+'].gender"></div>'
			    +'<label class="col-xs-2 control-label">职务</label><div class="col-xs-4"><input type="text" class="form-control" name="managers['+rowNum1+'].duty"></div>'
			  +'</div>'
			    +'<div class="form-group" id="row1_'+rowNum1+'_3">'
			    +'<label class="col-xs-2 control-label">简介</label><div class="col-xs-9"><input type="text" class="form-control" name="managers['+rowNum1+'].brief"></div>'
			  +'<div class="col-xs-1" style="cursor:pointer;" onclick="javascript:delManagerRecord('+rowNum1+');">-</div>'
			+'</div><hr id="row1_'+rowNum1+'_4">';
	$("#actEditFundManager").append(row);
	addFileClick('${base}','fileBtn_'+rowNum1,'iptBtn_'+rowNum1);
}
function delManagerRecord(index){
	$("div[id^='row1_"+index+"']").each(function(index,ele){
		$(ele).remove();
	});
	$("hr[id^='row1_"+index+"']").each(function(index,ele){
		$(ele).remove();
	});
}
//活动嘉宾
var rowNum2 =${activity.guests?size};
function addGuestRecord(){
	rowNum2 = rowNum2+1;
	var row = '<div class="form-group" id="row2_'+rowNum2+'_1">'
				+'<label class="col-xs-2 control-label">姓名</label><div class="col-xs-4"><input type="text" class="form-control" name="guests['+rowNum2+'].name"></div>'
			    +'<label class="col-xs-2 control-label">头像</label><div class="col-xs-2"><input type="text" readOnly class="form-control" id="iptBtn2_'+rowNum2+'" name="guests['+rowNum2+'].avatar"></div><div class="col-xs-2" id="fileBtn2_'+rowNum2+'">选择</div></div>'
			 +'</div>'
			    +'<div class="form-group" id="row2_'+rowNum2+'_2">'
			    +'<label class="col-xs-2 control-label">学历</label><div class="col-xs-4"><input type="text" class="form-control" name="guests['+rowNum2+'].education"></div>'
			    +'<label class="col-xs-2 control-label">头衔</label><div class="col-xs-4"><input type="text" class="form-control" name="guests['+rowNum2+'].actor"></div>'
			  +'</div>'
			    +'<div class="form-group" id="row2_'+rowNum2+'_3">'
			    +'<label class="col-xs-2 control-label">简介</label><div class="col-xs-9"><input type="text" class="form-control" name="guests['+rowNum2+'].brief"></div>'
			  +'<div class="col-xs-1" style="cursor:pointer;" onclick="javascript:delGuestRecord('+rowNum2+');">-</div>'
			+'</div><hr id="row2_'+rowNum2+'_4">';
	$("#actEditGuest").append(row);
	addFileClick('${base}','fileBtn2_'+rowNum2,'iptBtn2_'+rowNum2);
}
function delGuestRecord(index){
	$("div[id^='row2_"+index+"']").each(function(index,ele){
		$(ele).remove();
	});
	$("hr[id^='row2_"+index+"']").each(function(index,ele){
		$(ele).remove();
	});
}

var rowNum3 =${activity.files?size};
function addFileRecord(){
	rowNum3 = rowNum3+1;
	var did = "fileActTime_"+rowNum3;
	var row = '<div class="form-group" id="row3_'+rowNum3+'_1">'
				+'<label class="col-xs-2 control-label">名称</label><div class="col-xs-4"><input type="text" class="form-control" name="files['+rowNum3+'].name"></div>'
			    +'<label class="col-xs-2 control-label">文件</label><div class="col-xs-2"><input type="text" readOnly class="form-control" id="act_file_'+rowNum3+'" name="files['+rowNum3+'].path"></div><div id="act_file_select_'+rowNum3+'" class="col-xs-2">选择</div>'
			 +'</div>'
			    +'<div class="form-group" id="row3_'+rowNum3+'_2">'
			    +'<label class="col-xs-2 control-label">类型</label><div class="col-xs-4"><select class="form-control" name="files['+rowNum3+'].actFileType"><option value=1>图片</option><option value=2>视频</option><option value=3>附件</option></select></div>'
			    +'<label class="col-xs-2 control-label">日期</label><div class="col-xs-3"><input type="text" class="form-control" name="files['+rowNum3+'].actTime" id="fileActTime_'+rowNum3+'" onclick="javascript:laydateToId(\''+did+'\');"></div>'
			  	+'<div class="col-xs-1" style="cursor:pointer;" onclick="javascript:delFileRecord('+rowNum3+');">-</div>'
			+'</div><hr id="row3_'+rowNum3+'_4">';
	$("#actEditFile").append(row);
	addFileClick('${base}','act_file_select_'+rowNum3,'act_file_'+rowNum3);
}


function delFileRecord(index){
	$("div[id^='row3_"+index+"']").each(function(index,ele){
		$(ele).remove();
	});
	$("hr[id^='row3_"+index+"']").each(function(index,ele){
		$(ele).remove();
	});
}

function activityEditForm(parentIndex){
	var s=$("#activityEditForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#activityEditForm").serializeArray(),
			url:"${base}/admin/activity/update.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
					$('#activityListMain #activityTable').bootstrapTable("refresh");
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
<form class="form-horizontal" id="activityEditForm">
	<input type="hidden" name="id" value="${(activity.id)!}">
	<ul id="myTab" class="nav nav-tabs">
	   	 <li class="active"><a href="#actEditBaseInfo" data-toggle="tab">基本信息</a></li>
	   	 <li><a href="#actEditFundManager" data-toggle="tab">基金管理人</a></li>
	     <li><a href="#actEditLightspot" data-toggle="tab">活动亮点</a></li>
	     <li><a href="#actEditAgenda" data-toggle="tab">活动议程</a></li>
	     <li><a href="#actEditGuest" data-toggle="tab">活动嘉宾</a></li>
	     <li><a href="#actEditLiveReport" data-toggle="tab">现场报道</a></li>
	     <li><a href="#actEditFile" data-toggle="tab">活动附件</a></li>
	</ul>
	<div class="tab-content">
		<!-- 基本信息 -->
		<div class="tab-pane fade in active" id="actEditBaseInfo">
			<br>
			<div class="form-group">
				<label class="col-xs-2 control-label">标题</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="标题" name="title" value="${(activity.title)!}">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">副标题</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="副标题" name="subhead" value="${(activity.subhead)!}">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">内容</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="内容" name="content" value="${(activity.content)!}">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">开始时间</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="开始时间" id="startTime" name="startTime" value="${(activity.startTime)!}">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">结束时间</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="结束时间" id="endTime" name="endTime" value="${(activity.endTime)!}">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">地址</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="地址" name="address" value="${(activity.address)!}">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">封面</label>
			    <div class="col-xs-8">
			    	<input type="text" class="form-control" placeholder="封面" name="cover" id="cover" value="${(activity.cover)!}">
			    </div>
			    <div class="col-xs-2" id="coverBtn">
			    	选择
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">最大人数</label>
			    <div class="col-xs-4">
			    	<input type="text" class="form-control" placeholder="封面" name="maxNum" value="${(activity.maxNum)!}">
			    </div>
			    <label class="col-xs-2 control-label">限制人数</label>
			    <div class="col-xs-4">
			    	<input type="text" class="form-control" placeholder="" name="limitNum" value="${(activity.limitNum)!}">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">活动类型</label>
			    <div class="col-xs-4">
			    	<select class="form-control" name="type" id="type">
                        [@dict name="activityType" ]
                    	[#list dictList as st]
                    		<option value="${st.id}">${st.name}</option>
                    	[/#list]
                    	[/@dict]
					 </select>
			    </div>
			    <label class="col-xs-2 control-label">活动状态</label>
			    <div class="col-xs-4">
			    	<select class="form-control" name="actStatus" id="actStatus">
                       <option value=1 [#if 1==activity.actStatus]selected=selected[/#if]>进行</option>
                       <option value=2 [#if 2==activity.actStatus]selected=selected[/#if]>结束</option>
					 </select>
			    </div>
			</div>
		</div>
		<!-- 基金管理人 -->
		<div class="tab-pane fade" id="actEditFundManager">
			<br>
			<label class="col-xs-12 control-label" id="addManagerRecord" style="cursor:pointer;">+</label>
			[#list activity.managers as f]
			<div class="form-group" id="row1_${f_index}_1">
				<label class="col-xs-2 control-label">姓名</label><div class="col-xs-4"><input type="text" class="form-control" name="managers[${f_index}].name" value="${(f.name)!}"></div>
			    <label class="col-xs-2 control-label">头像</label>
			    <div class="col-xs-2"><input type="text" class="form-control" id="iptBtn_${f_index}" readOnly name="managers[${f_index}].avatar" value="${(f.avatar)!}"></div>
			    <div class="col-xs-2" id="fileBtn_${f_index}">选择</div>
			 </div>
			    <div class="form-group" id="row1_${f_index}_2">
			    <label class="col-xs-2 control-label">性别</label><div class="col-xs-4"><input type="text" class="form-control" name="managers[${f_index}].gender" value="${(f.gender)!}"></div>
			    <label class="col-xs-2 control-label">职务</label><div class="col-xs-4"><input type="text" class="form-control" name="managers[${f_index}].duty" value="${(f.duty)!}"></div>
			  </div>
			    <div class="form-group" id="row1_${f_index}_3">
			    <label class="col-xs-2 control-label">简介</label><div class="col-xs-9"><input type="text" class="form-control" name="managers[${f_index}].brief" value="${(f.brief)!}"></div>
			  <div class="col-xs-1" style="cursor:pointer;" onclick="javascript:delManagerRecord(${f_index});">-</div>
			</div><hr id="row1_${f_index}_4">
			[/#list]
		</div>
		<!-- 活动亮点 -->
		<div class="tab-pane fade" id="actEditLightspot">
			<br>
			<div class="form-group">
				<div class="col-xs-12">
				<textarea style="height:400px;" id="lightspot" name="lightspot"></textarea>
				</div>
			</div> 
		</div>
		<!-- 活动议程 -->
		<div class="tab-pane fade" id="actEditAgenda">
			<br>
			<div class="form-group">
				<div class="col-xs-12">
				<textarea style="height:400px;" id="agenda" name="agenda"></textarea>
				</div>
			</div>
		</div>
		<!-- 活动嘉宾 -->
		<div class="tab-pane fade" id="actEditGuest">
			<br>
			<label class="col-xs-12 control-label" id="addGuestRecord" style="cursor:pointer;">+</label>
			[#list activity.guests as f]
			<div class="form-group" id="row2_${f_index}_1">
				<label class="col-xs-2 control-label">姓名</label><div class="col-xs-4"><input type="text" class="form-control" name="guests[${f_index}].name" value="${(f.name)!}"></div>
			    <label class="col-xs-2 control-label">头像</label>
			    <div class="col-xs-2"><input type="text" class="form-control"id="iptBtn2_${f_index}" readOnly name="guests[${f_index}].avatar" value="${(f.avatar)!}"></div>
			    <div class="col-xs-2" id="fileBtn2_${f_index}">选择</div>
			 </div>
			    <div class="form-group" id="row2_${f_index}_2">
			    <label class="col-xs-2 control-label">学历</label><div class="col-xs-4"><input type="text" class="form-control" name="guests[${f_index}].education" value="${(f.education)!}"></div>
			    <label class="col-xs-2 control-label">头衔</label><div class="col-xs-4"><input type="text" class="form-control" name="guests[${f_index}].actor" value="${(f.actor)!}"></div>
			  </div>
			    <div class="form-group" id="row2_${f_index}_3">
			    <label class="col-xs-2 control-label">简介</label><div class="col-xs-9"><input type="text" class="form-control" name="guests[${f_index}].brief" value="${(f.brief)!}"></div>
			  <div class="col-xs-1" style="cursor:pointer;" onclick="javascript:delGuestRecord(${f_index});">-</div>
			</div><hr id="row2_${f_index}_4">
			[/#list]
		</div>
		<!-- 现场报道 -->
		<div class="tab-pane fade" id="actEditLiveReport">
			<br>
			<div class="form-group">
				<label class="col-xs-2 control-label">标题</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="标题" name="agoTitle" value="${(activity.agoTitle)!}">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">日期</label>
			    <div class="col-xs-4">
			    	<input type="text" class="form-control" placeholder="日期" name="agoDate" id="agoDate" value="${(activity.agoDate)!}">
			    </div>
			    <label class="col-xs-2 control-label">封面</label>
			    <div class="col-xs-2">
			    	<input type="text" class="form-control" placeholder="468*168" name="agoCover" id="agoCover" value="${(activity.agoCover)!}">
			    </div>
			    <div class="col-xs-2" id="agoCoverBtn">
			    	选择
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">内容</label>
				<div class="col-xs-10">
				<textarea style="height:260px;" id="liveReport" name="liveReport"></textarea>
				</div>
			</div>
		</div>
		<!-- 活动附件 -->
		<div class="tab-pane fade" id="actEditFile">
			<br/>
			<label class="col-xs-12 control-label" id="addFileRecord" style="cursor:pointer;">+</label>
			[#list activity.files as f]
			<div class="form-group" id="row3_${f_index}_1">
				<label class="col-xs-2 control-label">名称</label><div class="col-xs-4"><input type="text" class="form-control" name="files[${f_index}].name" value="${(f.name)!}"></div>
			    <label class="col-xs-2 control-label">文件</label>
			    <div class="col-xs-2"><input type="text" class="form-control" id="act_file_${f_index}" readOnly name="files[${f_index}].path" value="${(f.path)!}"></div>
			    <div id="act_file_select_${f_index}" class="col-xs-2">选择</div>
			 </div>
			 <div class="form-group" id="row3_${f_index}_2">
			    <label class="col-xs-2 control-label">类型</label><div class="col-xs-4">
			    <select class="form-control" name="files[${f_index}].actFileType" value="${(f.actFileType)!}">
			    	<option value=1 [#if 1==f.actFileType]selected[/#if]>图片</option>
			    	<option value=2 [#if 2==f.actFileType]selected[/#if]>视频</option>
			    	<option value=3 [#if 3==f.actFileType]selected[/#if]>附件</option>
			    </select>
			    </div>
			    <label class="col-xs-2 control-label">日期</label>
			    <div class="col-xs-3"><input type="text" class="form-control" name="files[${f_index}].actTime" id="fileActTime_${f_index}" value="${(f.actTime)!}"></div>
			  	<div class="col-xs-1" style="cursor:pointer;" onclick="javascript:delFileRecord(${f_index});">-</div>
			</div>
			<hr id="row3_${f_index}_4">
			[/#list]
		</div>
	</div>
</form>
</div>