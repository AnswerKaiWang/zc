<script>
var lightspot;
var agenda;
var liveReport;
$(function(){
	formValidate("#activityAddForm",{
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
	lightspot = addWedEditor('${base}','lightspot');
	agenda = addWedEditor('${base}','agenda');
	liveReport = addWedEditor('${base}','liveReport');
	
	$("#addManagerRecord").on("click",function(){
		addManagerRecord();
	});
	$("#addGuestRecord").on("click",function(){
		addGuestRecord();
	});
	$("#addFileRecord").on("click",function(){
		addFileRecord();
	});
	laydateToId("startTime");
	laydateToId("endTime");
	laydateToId("agoDate");
	$("#agoCoverBtn").on("mouseover",function(){
			if(!$(this).hasClass("webuploader-container")){
				addFileClick('${base}','agoCoverBtn','agoCover');
			}
	});
});
//基金管理人
var rowNum1 =0;
function addManagerRecord(){
	rowNum1 = rowNum1+1;
	var row = '<div class="form-group" id="row1_'+rowNum1+'_1">'
				+'<label class="col-xs-2 control-label">姓名</label><div class="col-xs-4"><input type="text" class="form-control" name="managers['+rowNum1+'].name"></div>'
			    +'<label class="col-xs-2 control-label">头像</label><div class="col-xs-2"><input type="text" class="form-control" id="iptBtn_'+rowNum1+'" name="managers['+rowNum1+'].avatar"></div><div class="col-xs-2" id="fileBtn_'+rowNum1+'">选择</div>'
			 +'</div>'
			    +'<div class="form-group" id="row1_'+rowNum1+'_2">'
			    +'<label class="col-xs-2 control-label">性别</label><div class="col-xs-4"><input type="text" class="form-control" name="managers['+rowNum1+'].gender"></div>'
			    +'<label class="col-xs-2 control-label">职务</label><div class="col-xs-4"><input type="text" class="form-control" name="managers['+rowNum1+'].duty"></div>'
			  +'</div>'
			    +'<div class="form-group" id="row1_'+rowNum1+'_3">'
			    +'<label class="col-xs-2 control-label">简介</label><div class="col-xs-9"><input type="text" class="form-control" name="managers['+rowNum1+'].brief"></div>'
			  +'<div class="col-xs-1" style="cursor:pointer;" onclick="javascript:delManagerRecord('+rowNum1+');">-</div>'
			+'</div><hr id="row1_'+rowNum1+'_4">';
	$("#actAddFundManager").append(row);
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
var rowNum2 =0;
function addGuestRecord(){
	rowNum2 = rowNum2+1;
	var row = '<div class="form-group" id="row2_'+rowNum2+'_1">'
				+'<label class="col-xs-2 control-label">姓名</label><div class="col-xs-4"><input type="text" class="form-control" name="guests['+rowNum2+'].name"></div>'
			    +'<label class="col-xs-2 control-label">头像</label><div class="col-xs-2"><input type="text" class="form-control" id="iptBtn2_'+rowNum2+'" name="guests['+rowNum2+'].avatar"></div><div class="col-xs-2" id="fileBtn2_'+rowNum2+'">选择</div>'
			 +'</div>'
			    +'<div class="form-group" id="row2_'+rowNum2+'_2">'
			    +'<label class="col-xs-2 control-label">学历</label><div class="col-xs-4"><input type="text" class="form-control" name="guests['+rowNum2+'].education"></div>'
			    +'<label class="col-xs-2 control-label">头衔</label><div class="col-xs-4"><input type="text" class="form-control" name="guests['+rowNum2+'].actor"></div>'
			  +'</div>'
			    +'<div class="form-group" id="row2_'+rowNum2+'_3">'
			    +'<label class="col-xs-2 control-label">简介</label><div class="col-xs-9"><input type="text" class="form-control" name="guests['+rowNum2+'].brief"></div>'
			  +'<div class="col-xs-1" style="cursor:pointer;" onclick="javascript:delGuestRecord('+rowNum2+');">-</div>'
			+'</div><hr id="row2_'+rowNum2+'_4">';
	$("#actAddGuest").append(row);
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

var rowNum3 =0;
function addFileRecord(){
	rowNum3 = rowNum3+1;
	var did = "fileActTime_"+rowNum3;
	var row = '<div class="form-group" id="row3_'+rowNum3+'_1">'
				+'<label class="col-xs-2 control-label">名称</label><div class="col-xs-4"><input type="text" class="form-control" name="files['+rowNum3+'].name"></div>'
			    +'<label class="col-xs-2 control-label">文件</label><div class="col-xs-2"><input type="text" class="form-control" id="act_file_'+rowNum3+'" name="files['+rowNum3+'].path"></div><div id="act_file_select_'+rowNum3+'" class="col-xs-2">选择</div>'
			 +'</div>'
			    +'<div class="form-group" id="row3_'+rowNum3+'_2">'
			    +'<label class="col-xs-2 control-label">类型</label><div class="col-xs-4"><select class="form-control" name="files['+rowNum3+'].actFileType"><option value=1>图片</option><option value=2>视频</option><option value=3>附件</option></select></div>'
			    +'<label class="col-xs-2 control-label">日期</label><div class="col-xs-3"><input type="text" class="form-control" name="files['+rowNum3+'].actTime" id="fileActTime_'+rowNum3+'" onclick="javascript:laydateToId(\''+did+'\');"></div>'
			  	+'<div class="col-xs-1" style="cursor:pointer;" onclick="javascript:delFileRecord('+rowNum3+');">-</div>'
			+'</div><hr id="row3_'+rowNum3+'_4">';
	$("#actAddFile").append(row);
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

function activityAddForm(parentIndex){
	var s=$("#activityAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#activityAddForm").serializeArray(),
			url:"${base}/admin/activity/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('添加成功');
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
<form class="form-horizontal" id="activityAddForm">
	<ul id="myTab" class="nav nav-tabs">
	   	 <li class="active"><a href="#actAddBaseInfo" data-toggle="tab">基本信息</a></li>
	   	 <li><a href="#actAddFundManager" data-toggle="tab">基金管理人</a></li>
	     <li><a href="#actAddLightspot" data-toggle="tab">活动亮点</a></li>
	     <li><a href="#actAddAgenda" data-toggle="tab">活动议程</a></li>
	     <li><a href="#actAddGuest" data-toggle="tab">活动嘉宾</a></li>
	     <li><a href="#actAddLiveReport" data-toggle="tab">现场报道</a></li>
	     <li><a href="#actAddFile" data-toggle="tab">活动附件</a></li>
	</ul>
	<div class="tab-content">
		<!-- 基本信息 -->
		<div class="tab-pane fade in active" id="actAddBaseInfo">
			<br>
			<div class="form-group">
				<label class="col-xs-2 control-label">标题</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="标题" name="title">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">副标题</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="副标题" name="subhead">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">内容</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="内容" name="content">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">开始时间</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="开始时间" name="startTime" id="startTime">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">结束时间</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="结束时间" name="endTime" id="endTime">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">地址</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="地址" name="address">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">封面</label>
			    <div class="col-xs-8">
			    	<input type="text" class="form-control" placeholder="封面" name="cover" id="cover">
			    </div>
			    <div class="col-xs-2" id="coverBtn">
			    	选择
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">最大人数</label>
			    <div class="col-xs-4">
			    	<input type="text" class="form-control" placeholder="封面" name="maxNum">
			    </div>
			    <label class="col-xs-2 control-label">限制人数</label>
			    <div class="col-xs-4">
			    	<input type="text" class="form-control" placeholder="" name="limitNum">
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
                       <option value=1>进行</option>
                       <option value=2>结束</option>
					 </select>
			    </div>
			</div>
		</div>
		<!-- 基金管理人 -->
		<div class="tab-pane fade" id="actAddFundManager">
			<br>
			<label class="col-xs-12 control-label" id="addManagerRecord" style="cursor:pointer;">+</label>
		</div>
		<!-- 活动亮点 -->
		<div class="tab-pane fade" id="actAddLightspot">
			<br>
			<div class="form-group">
				<div class="col-xs-12">
				<textarea style="height:400px;" id="lightspot" name="lightspot"></textarea>
				</div>
			</div> 
		</div>
		<!-- 活动议程 -->
		<div class="tab-pane fade" id="actAddAgenda">
			<br>
			<div class="form-group">
				<div class="col-xs-12">
				<textarea style="height:400px;" id="agenda" name="agenda"></textarea>
				</div>
			</div>
		</div>
		<!-- 活动嘉宾 -->
		<div class="tab-pane fade" id="actAddGuest">
			<br>
			<label class="col-xs-12 control-label" id="addGuestRecord" style="cursor:pointer;">+</label>
			
		</div>
		<!-- 现场报道 -->
		<div class="tab-pane fade" id="actAddLiveReport">
			<br>
			<div class="form-group">
				<label class="col-xs-2 control-label">标题</label>
			    <div class="col-xs-10">
			    	<input type="text" class="form-control" placeholder="标题" name="agoTile">
			    </div>
			</div>
			<div class="form-group">
				<label class="col-xs-2 control-label">日期</label>
			    <div class="col-xs-4">
			    	<input type="text" class="form-control" placeholder="日期" name="agoDate" id="agoDate">
			    </div>
			    <label class="col-xs-2 control-label">封面</label>
			    <div class="col-xs-2">
			    	<input type="text" class="form-control" placeholder="468*168" name="agoCover" id="agoCover">
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
		<div class="tab-pane fade" id="actAddFile">
			<br/>
			<label class="col-xs-12 control-label" id="addFileRecord" style="cursor:pointer;">+</label>
		</div>
	</div>
</form>
</div>