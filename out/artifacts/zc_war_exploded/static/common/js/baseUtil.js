function openWindows(title,url,data,yesFunction,disableBtn){
	var loadIndex = loadMsg();
	$.ajax({
		type:"post",
		url:url,
		data:data,
		dataType:"html",
		traditional:true,
		success:function(result){
			closeMsg(loadIndex);
			var autoWidth=$(result).eq(2).outerWidth()+"px";
			if(autoWidth=="0px"){
				autoWidth=[];
			}
			if(disableBtn){
				layer.open({
					type:1,
					title:title,
					content:result,
					area: autoWidth,
					//shift:Math.floor(Math.random()*6 + 1),
					success: function(layero, index){
						$(".layui-layer-btn0").attr("class", "layui-layer-btn0 fa fa-save");
						$(".layui-layer-btn1").attr("class", "layui-layer-btn1 fa fa-angle-left");
						var con=$(layero).find(".layui-layer-content");
						con.css("height",con.height()+"px");
					}
				});
			}else{
			layer.open({
				type:1,
				title:title,
				content:result,
				area: autoWidth,
				//shift:Math.floor(Math.random()*6 + 1),
				btn: [' 提交', ' 取消'],
				btn1: function(index, layero){
					yesFunction(index,layero);
				},
				btn2: function(index){ 
					layer.close(index);
				},
				success: function(layero, index){
					$(".layui-layer-btn0").attr("class", "layui-layer-btn0 fa fa-save");
					$(".layui-layer-btn1").attr("class", "layui-layer-btn1 fa fa-angle-left");
					var con=$(layero).find(".layui-layer-content");
					con.css("height",con.height()+"px");
				}
			});
			}
		},error:function(){
			closeMsg(loadIndex);
			layer.msg('系统异常,请重试', {shade: [0.5,'#000']});
		}
	})
}
function formValidate(formId,r,m){
 $(formId).validate({
	success : function(a) {
		a.closest(".form-group").removeClass("has-error").addClass("has-success");
	},
	highlight: function (element) { // hightlight error inputs
        $(element).closest('.form-group').removeClass('has-success').addClass('has-error'); // set error class to the control group
    },
    unhighlight: function (element) { // revert the change dony by hightlight
        $(element).closest('.form-group').removeClass('has-error'); // set error class to the control group
    },
	errorClass : "help-block m-b-none",
    errorElement: 'span',
    errorPlacement: function(error, element) { 
        error.appendTo(element.parent());  
    },
    focusInvalid: false, // 提交表单后，未通过验证的表单（第一个或提交之前获得焦点的未通过验证的表单）会获得焦点。
    focusCleanup:true,//如果是 true 那么当未通过验证的元素获得焦点时，移除错误提示。避免和 focusInvalid 一起用。
//    onclick:true,//在点击复选框和单选按钮时验证。
//    onfocusout:true,//失去焦点时验证（不包括复选框/单选按钮）。
//    onsubmit:true,//提交时验证。设置为 false 就用其他方法去验证。
//    onkeyup:true,//在 keyup 时验证。
    ignore: "",
    rules: r,
    messages:m
});
}
function alertMsg(msg,i){
	var icon="";
	if(i==0){
		icon="<i class='fa fa-remove' style='color:red;vertical-align:middle;font-size:30px;'></i>&nbsp;";
	}else if(i==1){
		icon="<i class='fa fa-check' style='color:green;vertical-align:middle;font-size:30px;'></i>&nbsp;";
	}
	msg="<div style='padding:20px 15px 10px 15px;fon-size:20px;'>"+icon+msg+"</div>";
	layer.open({type:1,title:false,shade:[0.5,"#000"],content:msg,btn:["确定"],yes:function(index){layer.close(index)}});
}
function loadMsg(){
	return layer.load(0, {shade: [0.5,'#000']});
}
function onlyMsg(title,i){
	if(!i){
		i=1;
	}
	layer.msg(title, {icon: i});
}
function closeMsg(index){
	layer.close(index);
}
function closeAllMsg(){
	layer.closeAll();
}
function refeshJmenu(id,title,daaa) {
    var t = $('.J_iframe[data-id="' +id+ '"]');
    if(t.length<=0){
    	return openJmenu(id,title,daaa);
    }else{
    	var sss = $('.J_menuTab[data-id="' +id+ '"]');
    	sss.click();
    }
    t.html("数据加载中......")
    $.ajax({
    	type:"post",
    	url:id,
    	data:(!daaa)?{}:daaa,
    	dataType:"html",
    	success:function(data){
    		t.html(data)
    	},error:function(){
    		t.text("数据加载出错");
    	}
    })
}
function refeshOneJmenu(id,data) {
    var t = $('.J_iframe[data-id="' + id + '"]');
    if(t.length==0){
    	return;
    }
    t.html("数据加载中......")
    $.ajax({
    	type:"post",
    	url:id,
    	data:(!daaa)?{}:daaa,
    	dataType:"html",
    	success:function(data){
    		t.html(data)
    	},error:function(){
    		t.text("数据加载出错");
    	}
    })
}
/**
 * Replace All 
 * @param source
 * @param target
 */
function replaceAll(source,target){
	var reg = new RegExp(/(-)/g);
	
}


function closeOneJmenu(id){
	var temp = $('.J_menuTab[data-id="' +id+ '"]');
	temp.find("i:last").click()
}
function closeJmenu() {
    var t = $(this).parents(".J_menuTab").data("id"),
    a = $(this).parents(".J_menuTab").width();
    if ($(this).parents(".J_menuTab").hasClass("active")) {
        if ($(this).parents(".J_menuTab").next(".J_menuTab").size()) {
            var i = $(this).parents(".J_menuTab").next(".J_menuTab:eq(0)").data("id");
            $(this).parents(".J_menuTab").next(".J_menuTab:eq(0)").addClass("active"),
            $(".J_mainContent .J_iframe").each(function() {
                return $(this).data("id") == i ? ($(this).show().siblings(".J_iframe").hide(), !1) : void 0
            });
            var n = parseInt($(".page-tabs-content").css("margin-left"));
            0 > n && $(".page-tabs-content").animate({
                marginLeft: n + a + "px"
            },
            "fast"),
            $(this).parents(".J_menuTab").remove(),
            $(".J_mainContent .J_iframe").each(function() {
                return $(this).data("id") == t ? ($(this).remove(), !1) : void 0
            })
        }
        if ($(this).parents(".J_menuTab").prev(".J_menuTab").size()) {
            var i = $(this).parents(".J_menuTab").prev(".J_menuTab:last").data("id");
            $(this).parents(".J_menuTab").prev(".J_menuTab:last").addClass("active"),
            $(".J_mainContent .J_iframe").each(function() {
                return $(this).data("id") == i ? ($(this).show().siblings(".J_iframe").hide(), !1) : void 0
            }),
            $(this).parents(".J_menuTab").remove(),
            $(".J_mainContent .J_iframe").each(function() {
                return $(this).data("id") == t ? ($(this).remove(), !1) : void 0
            })
        }
    } else $(this).parents(".J_menuTab").remove(),
    $(".J_mainContent .J_iframe").each(function() {
        return $(this).data("id") == t ? ($(this).remove(), !1) : void 0
    }),
    beautifulJmenu($(".J_menuTab.active"));
    return ! 1
}
function subJmenu(t) {
    var e = 0;
    return $(t).each(function() {
        e += $(this).outerWidth(!0)
    }),
    e
}
function beautifulJmenu(e) {
    var a = subJmenu($(e).prevAll()),
    i = subJmenu($(e).nextAll()),
    n = subJmenu($(".content-tabs").children().not(".J_menuTabs")),
    s = $(".content-tabs").outerWidth(!0) - n,
    r = 0;
    if ($(".page-tabs-content").outerWidth() < s) r = 0;
    else if (i <= s - $(e).outerWidth(!0) - $(e).next().outerWidth(!0)) {
        if (s - $(e).next().outerWidth(!0) > i) {
            r = a;
            for (var o = e; r - $(o).outerWidth() > $(".page-tabs-content").outerWidth() - s;) r -= $(o).prev().outerWidth(),
            o = $(o).prev()
        }
    } else a > s - $(e).outerWidth(!0) - $(e).prev().outerWidth(!0) && (r = a - $(e).prev().outerWidth(!0));
    $(".page-tabs-content").animate({
        marginLeft: 0 - r + "px"
    },
    "fast")
}
function openJmenu(t,i,daaa) {
    var n = !0;
    if (void 0 == t || 0 == $.trim(t).length) return ! 1;
    if ($(".J_menuTab").each(function() {
        return $(this).data("id") == t ? ($(this).hasClass("active") || ($(this).addClass("active").siblings(".J_menuTab").removeClass("active"), e(this), $(".J_mainContent .J_iframe").each(function() {
            return $(this).data("id") == t ? ($(this).show().siblings(".J_iframe").hide(), !1) : void 0
        })), n = !1, !1) : void 0
    }), n) {
        var menuA = $('<a href="javascript:;" class="active J_menuTab" data-id="' + t + '">' + i + ' <i class="fa fa-refresh"></i>  <i class="fa fa-times-circle"></i></a>');
        $(".J_menuTab").removeClass("active");
        //var r = '<iframe class="J_iframe" name="iframe' + a + '" width="100%" height="100%" src="' + t + '?v=3.0" frameborder="0" data-id="' + t + '" seamless></iframe>';
        var r = $('<div class="J_iframe" id="iframe' + _all_menu_index_index_index + '"  data-id="' + t + '" style="width:100%;height:100%;overflow-y:auto;overflow-x:visible;position:relative;">数据加载中......</div>');
        $(".J_mainContent").find("div.J_iframe").hide().parents(".J_mainContent").append(r);
        menuA.find("i:first").on("click", function(){refeshJmenu(t,i,(!daaa)?{}:daaa)})
        menuA.find("i:last").on("click", closeJmenu)
        $(".J_menuTabs .page-tabs-content").append(menuA),
        beautifulJmenu($(".J_menuTab.active"))
        $.ajax({
        	type:"post",
        	url:t,
        	data:(!daaa)?{}:daaa,
        	dataType:"html",
        	success:function(data){
        		r.html(data)
        	},error:function(){
        		r.text("数据加载出错");
        	}
        })
        _all_menu_index_index_index++;
    }
    return ! 1
}

function addFileClick(base,selectBtn,targetId){
//	setTimeout(function(){
		//文件上传
	  	var fileUploader = WebUploader.create({
	    	// 文件接收服务端。
	    	server: base+'/admin/fileUpload.htm',
	    	pick: '#'+selectBtn,
	    	auto:true,
	    	compress: false
		});
	  	fileUploader.on('uploadSuccess', function( file,res) {
			closeMsg(loadFileUpload)
			if(res.status!="00"){
				alertMsg("文件上传异常,请重试")
				$("#"+targetId).val("")
			}else{
				$("#"+targetId).val(res.url)
			}
		});
	  	fileUploader.on( 'uploadError', function( file ) {
			closeMsg(loadFileUpload)
			$("#"+targetId).val("")
	    	alertMsg("文件上传异常,请重试")
		});
	  	fileUploader.on( 'startUpload', function(  ) {
			loadFileUpload=loadMsg();
		});
//	}, 500);
	  	return fileUploader;
}

function addFileClik(url,sid, spanId,inputId){
	var uploder = WebUploader.create({
    	// 文件接收服务端。
    	server: url,
    	pick: '#'+sid,
    	auto:true,
    	compress: false
	});
	uploder.on('uploadSuccess', function( file,res) {
		closeMsg(loadFileUpload)
		if(res.status!="00"){
			alertMsg("文件上传异常,请重试")
			$("#"+spanId).html("")
			$("#"+inputId).val("")
		}else{
			$("#"+spanId).html("<a href='${base}"+res.url+"' target='_blank'>"+res.url+"</a>")
			$("#"+inputId).val(res.url)
		}
	});
	uploder.on( 'uploadError', function( file ) {
		closeMsg(loadFileUpload)
		$("#"+spanId).val("")
    	alertMsg("文件上传异常,请重试")
	});
	uploder.on( 'startUpload', function(  ) {
		loadFileUpload=loadMsg();
	});
}

function addWedEditor(base,selectId,initValue){
	var webEditor = new wangEditor(''+selectId);
	webEditor.config.uploadImgUrl = base+'/admin/upload.htm';
	webEditor.config.uploadParams = {
        token: 'abcdefg',
        user: 'wangfupeng1988'
    };
	webEditor.config.uploadHeaders = {
        'Accept' : 'text/x-json'
    };
	webEditor.config.hideLinkImg = true;
	webEditor.create();
	if(!!initValue){
		webEditor.$txt.html(initValue);
	}
	return webEditor;
}

function getSelected(id,rowid){
	var ids=[];
	var rows=$(id).bootstrapTable("getSelections");
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i][rowid]);
	}
	return ids;
}
$(function(){
	//验证小数点后的位数  
	jQuery.validator.addMethod("dec", function(value, element,d){  
	     var a = value.indexOf(".")+1;  
	     if(a==0){  
	        a=value.length;  
	     }  
	     var b = value.length;  
	     var c = b-a;  
	    return this.optional(element) || c<=d;   
	},$.validator.format("小数位数大于{0}位")); 
});
/***
 * 
 * 格式化货币
 * @param num XX,XXX.XX
 */
function fmtCurrency(num){
	if(!num){
		return "";
	}
	num = num.toString().replace(/\$|\,/g,'');  
    if(isNaN(num))  
        num = "0";  
    sign = (num == (num = Math.abs(num)));  
    num = Math.floor(num*100+0.50000000001);  
    cents = num%100;  
    num = Math.floor(num/100).toString();  
    if(cents<10)  
    cents = "0" + cents;  
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
    num = num.substring(0,num.length-(4*i+3))+','+  
    num.substring(num.length-(4*i+3));  
    return (((sign)?'':'-') + num + '.' + cents); 
}
function checkLogin(callback,errorCallback){
	$.ajax({
    	type:"post",
    	url:"${base}/cura/isLogin",
    	dataType:"json",
    	success:function(data){
    		console.log(data);
    		if(!!data && data.code == '00'){
    			callback(data);
    		}else{
    			alertMsg("请先登录!");
    			return false;
    		}
    	},error:function(){
    		//t.text("数据加载出错");
    		alertMsg("请先登录!");
			return false;
    	}
    });
}

function toProduct(){
	checkLogin(function(){
		window.document.location = "${base}/cura/fund/product.htm";
	},function(){
		window.document.location = "${base}/cura/login.htm";
	});
}


/**
 * 给元素添加日期事件
 * @param sid
 */
function laydateToId(sid){
	var ld = {
   		fixed:true,
   		elem: '#'+sid,
    	istime: true,
    	format: 'YYYY-MM-DD',
    	choose: function(data){
         //end.min = data; 
         //end.start = data 
    	}
   	};
	laydate(ld);
	return false;
}
var dpattern = /^(\d{4})-(\d{2})-(\d{2})$/
/**
 * 校验是否符合日期规则
 * @param sid
 */
function checkDate(sid){
	var dob = $("#"+sid);
	if(!!dob){
		var dv = dob.val();
		if(!!dv){
			if(!dpattern.test(dv)){//格式错误
				alertMsg("日期格式错误，请重新填写!");
				dob.val("").focus();
				return false;
			}
		}
	}
}
var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",
		34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",
		51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
var idpattern = /^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i;
/**
 * 校验身份证 18位
 * @param sid
 */
function checkID(sid,callback){
	var dob = $("#"+sid);
	if(!!dob){
		var dv = dob.val();
		if(!!dv){
			if(!idpattern.test(dv)){//格式错误
				alertMsg("身份证格式错误!");
				dob.val("").focus();
				return false;
			}else if(!city[dv.substring(0,2)]){
				alertMsg("身份证地址编码错误!");
				dob.val("").focus();
				return false;
			}else{
				if(dv.length == 18){//验证最后一位，暂时
					var cs = dv.split('');
					var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];//加权因子
					var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];//校验位
					var sum = 0;
                    var ai = 0;
                    var wi = 0;
                    for (var i = 0; i < 17; i++)
                    {
                        ai = cs[i];
                        wi = factor[i];
                        sum += ai * wi;
                    }
                    var last = parity[sum % 11];
                    if(parity[sum % 11] != cs[17]){//最后一位
                    	alertMsg("身份证错误!");
        				dob.val("").focus();
        				return false;
                    }
				}
			}
			if(!!callback){
				callback(dv);
			}
		}
	}
}
function getNow(){
	var now = new Date();
	var m = now.getMonth()+1;
	if(m <10){
		m = "0"+m;
	}
	var d = now.getDate();
	if(d<10){
		d = "0"+d;
	}
	return now.getFullYear()+"-"+m+"-"+d;
}
function fmtDate(odate){
	if(odate.length == 6){
		return odate.substring(0,4)+"-0"+odate.substring(4,5)+"-0"+odate.substring(5,6);
	}else if(odate.length == 8){
		return odate.substring(0,4)+"-"+odate.substring(4,6)+"-"+odate.substring(6,8);
	}else{
		return "";
	}
}