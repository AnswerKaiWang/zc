<script>
var companySecuritEditor1;
var companySecuritEditor2;
$(function(){
	var t = [
        'source',    
        'bold',
        'underline',
        'italic',
        'strikethrough',
        'eraser',
        'forecolor',
        'bgcolor',
        '|',
        'quote',
        'fontfamily',
        'fontsize',
        'head',
        'unorderlist',
        'orderlist',
        'alignleft',
        'aligncenter',
        'alignright'
     ];
	companySecuritEditor1 = new wangEditor('editor1');
    companySecuritEditor1.config.menus =t;
    companySecuritEditor1.create();
	companySecuritEditor2 = new wangEditor('editor2');
    companySecuritEditor2.config.menus =t;
    companySecuritEditor2.create();
    
     companySecuritEditor1.$editorContainer.css('z-index', 40)
     companySecuritEditor2.$editorContainer.css('z-index', 30)
})	

function companySubmitForm(parentIndex){
	var s=$("#companyAddForm").validate().form();
	if(s){
		var dataV=$("#companyAddForm").serializeArray();
		dataV[dataV.length]={"name":"at\[\"companySendEmailUnBindContant\"\]","value":companySecuritEditor1.$txt.html()}
		dataV[dataV.length]={"name":"at\[\"companySendEmailBindContant\"\]","value":companySecuritEditor2.$txt.html()}
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:dataV,
			url:"${base}/admin/company/updateCompanyEmail.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					layer.msg('修改成功');
					$('#companyListMain #companyTable').bootstrapTable("refresh");
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

<div style="width:800px;height:500px;padding:15px;overfolw:auto;">
<form class="form-horizontal" id="companyAddForm">
   
	    	<div class="form-group">
			    <label class="col-xs-3 control-label">发件邮箱</label>
			    <div class="col-xs-7">
			    	<input type="text" class="form-control" placeholder="发件邮箱" name="at['companySendEmail']" value="${at['companySendEmail']}">
			         <input type="hidden"  name="id"  value="${company.id}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">发件用户名</label>
			    <div class="col-xs-7">
			    	<input type="text" class="form-control" placeholder="发件用户名" name="at['companySendEmailUserName']" value="${at['companySendEmailUserName']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">发件昵称</label>
			    <div class="col-xs-7">
			    	<input type="text" class="form-control" placeholder="发件昵称" name="at['companySendEmailNickName']" value="${at['companySendEmailNickName']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">发件密码</label>
			    <div class="col-xs-7">
			    	<input type="text" class="form-control" placeholder="发件密码" name="at['companySendEmailPassword']" value="${at['companySendEmailPassword']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">发件服务器smtp</label>
			    <div class="col-xs-7">
			    	<input type="text" class="form-control" placeholder="客服邮箱" name="at['companySendEmailSmtp']" value="${at['companySendEmailSmtp']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">发件服务器端口</label>
			    <div class="col-xs-7">
			    	<input type="text" class="form-control" placeholder="发件服务器端口" name="at['companySendEmailPort']" value="${at['companySendEmailPort']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">修改邮箱发件主题</label>
			    <div class="col-xs-7">
			    	<input type="text" class="form-control" placeholder="修改邮箱发件主题" name="at['companySendEmailUnBindSub']" value="${at['companySendEmailUnBindSub']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">修改邮箱发件内容</label>
			    <div class="col-xs-7">
			    	<textarea id="editor1">${at['companySendEmailUnBindContant']}</textarea>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">绑定邮箱发件主题</label>
			    <div class="col-xs-7">
			    	<input type="text" class="form-control" placeholder="绑定邮箱发件主题" name="at['companySendEmailBindSub']" value="${at['companySendEmailBindSub']}">
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-xs-3 control-label">绑定邮箱发件内容</label>
			    <div class="col-xs-7">
			    	<textarea id="editor2">${at['companySendEmailBindContant']}</textarea>
			    </div>
			</div>
</form>
</div>