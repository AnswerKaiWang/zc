<script>
$(function(){
});
function sendMsgSubmit(parentIndex){
		var content=$("#messageSendForm #content").val();
		if(content==null||content==""){
			alertMsg('请选填写内容',0);
			return false;
		}
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:{"ids":${ids},content: content},
			url:"${base}/admin/message/sendMsg.htm",
			traditional:true,
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('发送成功', 1);
					if("${type}"=="per"){
						$('#messageUserListMain #messageUserTable').bootstrapTable("refresh")
					}else{
						$('#messageUserListMain #messageUserTable').bootstrapTable("refresh")
					}
				}else{
					alertMsg(data.error,0)
				}
			},error:function(){
				closeMsg(o);
				alertMsg("系统异常,请重试")
			}
		})
}
</script>

<div style="width:600px;height:200px;padding:5px;overflow:auto;scroll:none;">
<form class="form-horizontal" id="messageSendForm">
	<textarea style="width:593px;height:180px;" type="text" name="content" id="content"></textarea>
</form>
</div>