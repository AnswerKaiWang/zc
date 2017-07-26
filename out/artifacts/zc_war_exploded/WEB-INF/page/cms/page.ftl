<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <title>中城投资</title>

    <!--[if lt IE 8]>
    <script>
        alert('已不支持IE6-8，请使用谷歌、火狐等浏览器\n或360、QQ等国产浏览器的极速模式浏览本页面！');
    </script>
    <![endif]-->

    <link href="${base}/static/common/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/static/common/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

    <link href="${base}/static/common/css/animate.min.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/static/common/css/style.min.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/static/common/css/plugins/boottable/bootstrap-table.min.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/static/common/css/plugins/jsTree/style.min.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/static/common/css/plugins/webuploader/webuploader.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/static/common/css/plugins/wangEditor/wangEditor.min.css" rel="stylesheet" type="text/css"/>
    <link href="${base}/static/common/css/plugins/select2/select2.min.css" rel="stylesheet" type="text/css"/>
</head>
<body class="fixed-sidebar full-height-layout gray-bg" style="overflow: hidden;">
    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
            	<div style="background-color:#f3f3f4;height:60px;padding-top:5px;">
            		<img alt="image" src="${base}/front/images/logo.png" style="display:block;height:50px;margin:auto;"/>
            	</div>
                <ul class="nav" id="side-menu" style="padding-top:20px;">
                    	[#list permission as pe]
                    	[#if !(pe.parentId??)]
                    	[@shiro.hasPermission  name=pe.value+'']
                    	<li>
						<a>
                            <i class="fa fa-home"></i>
                            <span class="nav-label">${pe.name}</span>
                            <span class="fa arrow"></span>
                        </a>
                        	<ul class="nav nav-second-level">
                        	[#list permission as ch]
                        		[#if pe.id==ch.parentId]
                        		[@shiro.hasPermission  name=ch.value+'']
	                           	<li>
	                               <a class="J_menuItem" href="${base}${(ch.value)!"#"}">${ch.name}</a>
	                           	</li>
	                           	[/@shiro.hasPermission]
	                           	[/#if]
                        	[/#list]
                        	</ul>
                        </li>
                        [/@shiro.hasPermission]
                        [/#if]
                        [/#list]
                </ul>
            </div>
        </nav>
        <!--左侧导航结束-->
        
        <!--右侧部分开始-->
        <div id="page-wrapper" class="dashbard-1">
            <div class="row border-bottom">
                 <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header">
                    	<a class="navbar-minimalize minimalize-styl-2 btn btn-primary "  href="javascript:void(0);"><i class="fa fa-bars"></i> </a>
                    </div>

                    <ul class="nav navbar-top-links navbar-right">
                    	<li class="" >欢迎:${(name)!}</li>
                        <li class="dropdown" >
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="javascript:;" title="修改资料" onclick="editLoginMember()">
                                <i class="fa fa-tasks"></i>
                            </a>
                            <div class="dropdown-menu dropdown-messages">
                            	修改资料
                            </div>
                        </li>
                    </ul>
                </nav> 
            </div>
            <div class="row content-tabs">
                <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
                </button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content">
                        <a href="javascript:;" class="active J_menuTab" data-id="index">首页<i class="fa fa-refresh"></i></a>
                    </div>
                </nav>
                <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
                </button>
                <button class="roll-nav roll-right dropdown J_tabClose"><span class="dropdown-toggle" data-toggle="dropdown">关闭操作<span class="caret"></span></span>
                    <ul role="menu" class="dropdown-menu dropdown-menu-right">
                        <li class="J_tabShowActive"><a>定位当前选项卡</a>
                        </li>
                        <li class="divider"></li>
                        <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                        </li>
                        <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                        </li>
                    </ul>
                </button>
                <a href="${base}/admin/login/logout.htm" class="roll-nav roll-right J_tabExit" ><i class="fa fa fa-sign-out"></i> 退出</a>
            </div>
            <div class="row J_mainContent" id="content-main" style="background-color:#f3f3f4;">
                <div class="J_iframe active" name="iframe0"  src="${base}/index/welcome.html"  data-id="index" seamless></div>
            </div>
            <div class="footer">
                <div class="pull-right">&copy; ${(adminSystemName)!} 
                </div>
            </div>
        </div>
        <!--右侧部分结束-->
 
    </div>
	
	      
    <!-- 全局js -->
    <script src="${base}/static/common/js/jquery-2.1.1.min.js"></script>
    <script src="${base}/static/common/js/bootstrap.min.js?v=3.4.0"></script>
    <script src="${base}/static/common/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="${base}/static/common/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <!-- layerDate 日期 -->
	<script src="${base}/static/common/js/plugins/layer/laydate/laydate.js?v=${version}"></script>
	<!-- 弹出层 -->
	<script src="${base}/static/common/js/plugins/layer/layer.js?v=${version}"></script>
	<!-- boottable -->
	<script src="${base}/static/common/js/plugins/boottable/bootstrap-table.js?v=${version}"></script>
	<script src="${base}/static/common/js/plugins/boottable/bootstrap-table-zh-CN.min.js?v=${version}"></script>
	 <!--树-->
	<script src="${base}/static/common/js/plugins/jsTree/jstree.min.js"></script>
    <!-- 自定义js -->
    <script src="${base}/static/common/js/hplus.min.js?v=3.0.0"></script>
    <script type="text/javascript" src="${base}/static/common/js/contabs.min.js"></script>
	 <!-- 自动补全 -->
    <script src="${base}/static/common/js/plugins/select2/select2.full.min.js"></script>
    <script src="${base}/static/common/js/plugins/select2/zh-CN.js"></script>
    <!-- 第三方插件 -->
    <script src="${base}/static/common/js/plugins/pace/pace.min.js"></script>
    <!--上传文件-->
    <script src="${base}/static/common/js/plugins/wangEditor/wangEditor.min.js"></script>
    <!--富文本-->
    <script src="${base}/static/common/js/plugins/webuploader/webuploader.min.js"></script>
    <!-- 验证 -->
	<script src="${base}/static/common/js/plugins/validate/jquery.validate.min.js?v=${version}"></script>
	<script src="${base}/static/common/js/plugins/validate/messages_zh.min.js?v=${version}"></script>
    <script src="${base}/static/common/js/baseUtil.js?v=${version}"></script>
	<script>
		$(function(){
			//加载首页
			var r = $("div[name='iframe0']");
			$.ajax({
        	type:"post",
        	url:'${base}/admin/main/welcome.htm',
        	dataType:"html",
        	success:function(data){
        		r.html(data)
        	},error:function(){
        		r.text("数据加载出错");
        	}
        })
		});
		
		function editLoginMember(){
			openWindows("修改资料","${base}/admin/member/editLoginMember.htm",null,
	 		function(index,layero){
	 				loginMemberSubmitForm(index)
	 		});
		}
	</script>

</body>



</html>