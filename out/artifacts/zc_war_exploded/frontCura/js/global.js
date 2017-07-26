/**
 * post请求
 */
function asyncPost(url,params,callback){
	$.ajax({
		url: url,
		method: "POST",
		dataType: "json",
		data: params,
		success: function(resp, textStatus, xhr){
			callback(resp);
		},
		error: function(){
			
		}
	});
}

function alertNotification(title,content,btnName,callback){
	var ctx  = '<div id="popupId10" class="cppc_popup_10">'
	  +'<p class="title"><b>'+title+'</b> </p>'
	  +'<p class="txt">'+content+'</p>'
	  +'<p class="y_button"><a href="javascript:void(0);" id="notificationId" class="a1 close_bookingfinish_popup">'+btnName+'</a></p>'
	  +'</div>';
	$(window.document.body).append(ctx);
	var curIndex = 0;
	layer.open({
	  type: 1,
	  title: false,
	  closeBtn:2,
	  area : ['auto' , 'auto'],
	  shadeClose :true,
	  //time:2000, 2秒自动关闭
	  content: $('#popupId10'),
	  cancel:function(index){
		  $("#popupId10").remove();
		  layer.close(index);
	  },
	  yes:function(index,layero){
		  $("#popupId10").remove();
		  layer.close(index);
	  },
	  success: function(layero, index){
		  curIndex = index;
	  }
	});
	$("#notificationId").on("click",function(){
		$("#popupId10").remove();
		layer.close(curIndex);
		if(!!callback){
			callback();
		}
	});
}

function riskMsg(data,callback){
	var ctx  ='<div class="cppc_popup_1" id="popupId11"><p class="title">风险评级：<b id="riskBear">'+data.riskBear+'</b></p>'
	  +'<p class="txt">本产品属于<span class="pink">'+data.riskLevel+'</span>风险投资品种，适合风险识别、评估、承受能力'+data.riskBear+'的合格投资者风险评级与本产品风险等级不匹配</p>'
	  +'<p class="y_button"><a href="javascript:void(0);" class="a1 close_bookingfinish_popup" id="retryEvaluation">继续测评</a></p></div>';
	$(window.document.body).append(ctx);
	var curIndex = 0;
	layer.open({
	  type: 1,
	  title: false,
	  closeBtn:2,
	  area : ['auto' , 'auto'],
	  shadeClose :true,
	  content: $('#popupId11'),
	  cancel:function(index){
		  $("#popupId11").remove();
		  layer.close(index);
	  },
	  yes:function(index,layero){
		  $("#popupId11").remove();
		  layer.close(index);
	  },
	  success: function(layero, index){
		  curIndex = index;
	  }
	});
	$("#retryEvaluation").on("click",function(){
		$("#popupId11").remove();
		layer.close(curIndex);
		if(!!callback){
			callback();
		}
	});
}

/**
 * <div class="bookingfinish_popup">
  <p class="title">预约成功</p>
  <p class="txt">财富顾问会在下个工作日内与您联系</p>
  <p class="y_button"><a href="javascript:void(0);" class="a1 close_bookingfinish_popup">完成预约</a><a href="#" class="a2">预约查询</a></p>
</div>
 * @param title
 * @param content
 * @param btnName
 * @param callback
 * @param cancelBtn
 * @param cancelFn
 */
function alertConfirm(title,content,btnName,callback,cancelBtn,cancelFn){
	var ctx  = '<div id="popupId10" class="bookingfinish_popup">'
	  +'<p class="title"><b>'+title+'</b> </p>'
	  +'<p class="txt">'+content+'</p>'
	  +'<p class="y_button"><a href="javascript:void(0);" id="notificationId" class="a1 close_bookingfinish_popup">'+btnName
	  +'</a><a href="javascript:void(0);" id="cancelNotifyId" class="a2">'+cancelBtn+'</a></p>'
	  +'</div>';
	$(window.document.body).append(ctx);
	var curIndex = 0;
	layer.open({
	  type: 1,
	  title: false,
	  closeBtn:2,
	  area : ['auto' , 'auto'],
	  shadeClose :true,
	  //time:2000, 2秒自动关闭
	  content: $('#popupId10'),
	  cancel:function(index){
		  $("#popupId10").remove();
		  layer.close(index);
	  },
	  yes:function(index,layero){
		  $("#popupId10").remove();
		  layer.close(index);
	  },
	  success: function(layero, index){
		  curIndex = index;
	  }
	});
	$("#notificationId").on("click",function(){
		$("#popupId10").remove();
		layer.close(curIndex);
		if(!!callback){
			callback();
		}
	});
	$("#cancelNotifyId").on("click",function(){
		$("#popupId10").remove();
		layer.close(curIndex);
		if(!!cancelFn){
			cancelFn();
		}
	});
}

function alertM(content){
	var ctx  = '<div id="popupId11" class="cppc_popup_10">'
	  +'<p class="txt">'+content+'</p>\</div>';
	$(window.document.body).append(ctx);
	var curIndex = 0;
	layer.open({
	  type: 1,
	  title: false,
	  closeBtn:0,
	  area : ['auto' , 'auto'],
	  shadeClose :true,
	  time:1000, //2秒自动关闭
	  content: $('#popupId11'),
	  cancel:function(index){
		  $("#popupId11").remove();
		  layer.close(index);
	  },
	  yes:function(index,layero){
		  $("#popupId11").remove();
		  layer.close(index);
	  },
	  success: function(layero, index){
		  curIndex = index;
	  },
	  end:function(){
		  layer.close(curIndex);
	  }
	});
}

function checkLogin(base,callback,errorCallback){
	$.ajax({
    	type:"post",
    	url:base+"/cura/isLogin.htm",
    	dataType:"json",
    	success:function(data){
    		if(!!data && data.code == '00'){
    			callback(data);
    		}else{
    			alertNotification("登陆提示","请先登录!","确定");
    			return false;
    		}
    	},error:function(){
    		//t.text("数据加载出错");
    		alertNotification("登陆提示","请先登录!","确定");
			return false;
    	}
    });
}

function toProduct(base){
	checkLogin(base,function(){
		window.document.location = base+"/cura/fund/product.htm";
	},function(){
		window.document.location = base+"/cura/login.htm";
	});
}
function toCustCenter(base){
	checkLogin(base,function(){
		window.document.location = base+"/cura/cust/base.htm";
	},function(){
		window.document.location = base+"/cura/login.htm";
	});
}

function toCustAccount(base){
	checkLogin(base,function(){
		window.document.location = base+"/cura/cust/me.htm";
	},function(){
		window.document.location = base+"/cura/login.htm";
	});
}
function toCustBase(base){
	checkLogin(base,function(){
		window.document.location = base+"/cura/cust/base.htm";
	},function(){
		window.document.location = base+"/cura/login.htm";
	});
}
function toMessage(base){
	checkLogin(base,function(){
		window.document.location = base+"/cura/cust/message.htm";
	},function(){
		window.document.location = base+"/cura/login.htm";
	});
}
/**
 * 为毛没作用
 */
function choiceSelect(){
	$(this).addClass("active");
	$(this).siblings().each(function(index,ele){
		$(ele).removeClass("active");
	});
}
/**
 * 选中茶品类别，产品期限
 */
function choiceSearchProduct(self,callback,e){
	var e = window.event;
	if(!!e){
		e.preventDefault();
	}
	$(self).addClass("active");
	$(self).siblings().each(function(index,ele){
		$(ele).removeAttr("class");
	});
	if(!!callback){
		callback(1);
	}
}
/**
 * 提交请求
 * @param url
 * @param params
 * @param callback
 */
function submitForm(url,params,callback){
	$.ajax({
		url: url,
		type:"POST",
		dataType:"json",
		data: params,
		success:function(data){
			if(!!data){
				if(data.code == '00'){
					if(!!callback){
						callback(data);
					}
				}else{
					alertNotification("提示",data.message,"确定");
				}
			}
		}
	});
}
var RGX_PHONE = /^((1[3-9]{1}[0-9]{1})+\d{8})$/;//电话
var RGX_NUM = /^[0-9]+.?[0-9]*$/;//数字
var RGX_INT = /^[1-9]+[0-9]*]*$/;//正数
var RGX_NCN = /[\u4E00-\u9FA5]/i;//非中文
var RGX_CNPY =/^[\u4E00-\u9FA5a-zA-Z]*$/ ;
var RGX_EMAIL =  /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",
		34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",
		51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
var idpattern = /^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i;

/**
 * 交易站是中文和拼音
 * @param sid
 */
function checkCnAndChar(sid){
	var v = $("#"+sid);
	if(!!v && !!v.val()){
		if(!RGX_CNPY.test(v.val())){
			alertM("只能填写中文或者拼音!");
			//v.focus();
			return false;
		}
	}
}

function checkEmail(sid){
	var v = $("#"+sid);
	if(!!v && !!v.val()){
		if(!RGX_EMAIL.test(v.val())){
			//layer.msg("请输入正确的邮箱!");
			alertM("请输入正确的邮箱!");
			//v.focus();
			return false;
		}
	}
}
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
				alertM("身份证格式错误!");
				//dob.focus();
				return false;
			}else if(!city[dv.substring(0,2)]){
				alertM("身份证地址编码错误!");
				//dob.focus();
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
                    	alertM("身份证错误!");
        				//dob.focus();
        				return false;
                    }
				}
			}
			if(!!callback){
				callback(dv);
			}
		}
	}
	return true;
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
function checkInt(sid){
	var v = $("#"+sid);
	if(!!v && !!v.val()){
		if(!RGX_INT.test(v.val())){
			alertM("请输入正确的数字!");
			return false;
		}
	}
}

function checkMoney(self){
	var v = $(self);
	if(!!v && !!(v.val())){
		var vv = v.val();
		vv = vv.replace(/[^[0-9]/g,'')
		v.val(vv);
		$("#capitalId").text(numToCapital(vv));
	}
}

function numToCapital(num) {
	var strOutput = "";
	var strUnit = '仟佰拾亿仟佰拾万仟佰拾元角分';
	num += "00";
	var intPos = num.indexOf('.');
	if (intPos >= 0)
		num = num.substring(0, intPos) + num.substr(intPos + 1, 2);
	strUnit = strUnit.substr(strUnit.length - num.length);
	for (var i = 0; i < num.length; i++)
		strOutput += '零壹贰叁肆伍陆柒捌玖'.substr(num.substr(i, 1), 1)
				+ strUnit.substr(i, 1);
	return strOutput.replace(/零角零分$/, '整').replace(/零[仟佰拾]/g, '零').replace(
			/零{2,}/g, '零').replace(/零([亿|万])/g, '$1').replace(/零+元/, '元')
			.replace(/亿零{0,3}万/, '亿').replace(/^元/, "零元");
}

/**
 * 校验手机号
 * 
 * @param sid
 */
function checkMobile(sid){
	var v = $("#"+sid);
	if(!!v && !!v.val()){
		if(!RGX_PHONE.test(v.val())){
			alertM("请输入正确的手机号码!");
			//v.focus();
			return false;
		}
	}
}
/**
 * 禁止中文
 * @param sid
 */
function forbiddenCn(sid){
	var v = $("#"+sid);
	if(!!v && !!v.val()){
		if(RGX_NCN.test(v.val())){
			alertM("该输入框不允许输入中文!");
			return false;
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
