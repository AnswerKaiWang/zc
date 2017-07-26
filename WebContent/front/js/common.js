//--弹出登陆窗口
function showlogin(obj){
	obj=$('.'+obj)
	var winWidth = $(window).width();
	var winHeight = $(window).height();
	var H=$(obj).height();
	var W=$(obj).width();
	$('body').prepend("<div id='bg_color'  style='width:100%;filter:alpha(opacity=50);opacity: 0.5;height:100%;background:#000; position:fixed;z-index:1000;'></div>");
	$(obj).show();
	$(obj).addClass('bounceIn_into');
	$(obj).css({'left':((winWidth-W)/2),'top':((winHeight-H)/2)});
	$(obj).find('.close').click(function(){
		$("#errorMsg").html("");
		$(obj).hide();
		$('#bg_color').hide();
	});
};


//--弹窗
function showPopup(obj){
	obj=$('.'+obj)
	var winWidth = $(window).width();
	var winHeight = $(window).height();
	var H=$(obj).height();
	var W=$(obj).width();
	$('body').prepend("<div id='bg_color'  style='width:100%;filter:alpha(opacity=50);opacity: 0.5;height:100%;background:#000; position:fixed;z-index:1000;'></div>");
	$(obj).show();
	$(obj).addClass('bounceIn_into');
	$(obj).css({'left':((winWidth-W)/2),'top':((winHeight-H)/2)});
	$(obj).find('.close').click(function(){
		$(obj).hide();
		$('#bg_color').hide();
	});
	return false;
};


//------------------------------------------------------------------------
$(function(){
	//--默认css设置
	$('.user_L').height($('.inner_wrap').height());
	$('.aqzx ul').find('li:last').css('border-bottom','none');
	$('.grxx ul').find('li:last').css('border-bottom','none');
	$('.dqtz_list ul').find('li:last').css('border-bottom','none');
	$('.fhcx_list ul').find('li:last').css('border-bottom','none');
	$('.grcp_list ul').find('li:even').not('li:first').find('a').css('background','#eeeeee');
	
	var yH=$('.grcp_list ul').outerHeight(true);
	$('.showlmore').click(function(){
			if($(this).hasClass('active')){
				$('.grcp_list ul').css('height',yH);
				$(this).removeClass('active');
			}else{
				$('.grcp_list ul').css('height','auto');
				$(this).addClass('active');
			};
	});
	
	
	
	//用户中心左侧下拉菜单
	$('.l_menu li').each(function(index, element) {
        if($(this).find('ol').length>0){
			$(this).addClass('have_drop')
			$(this).find('.aone').attr('href','javascript:void(0);');
			if($(this).hasClass('active')){
				$(this).find('ol').show();
			}
		}else{
			$(this).find('.aone').find('i').hide();
			$(this).find('.aone').css("background-image",'none');
		}
    });
	$('.aone').click(function(){
		if($(this).siblings('ol').length>0){
			if($(this).siblings('ol').is(':visible')){
				$(this).siblings('ol').slideUp(300)
				$(this).parent().removeClass('active')
			}else{
				$(this).siblings('ol').slideDown(300)
				$(this).parent().siblings('li').find('ol').slideUp(300)
				$(this).parent().addClass('active')
				$(this).parent().siblings('li').removeClass('active')
			}
		}
	});
	//----帮助中心问题展开
	$('.hesp_tab_show').each(function(index, element){
		$(this).find('dl').each(function(index, element) {
            var ind=index+1;
			if(ind<10){
				$(this).find('dt').find('i').text("0"+ind);
			}else{
				$(this).find('dt').find('i').text(ind);
			}
        });
    });
	$('.hesp_tab_show dl').find('dt').click(function(){
		if($(this).siblings('dd').is(':hidden')){
			$(this).addClass('active');
			$(this).parent().siblings('dl').find('dt').removeClass('active');
			$(this).siblings('dd').slideDown(300);
			$(this).parent().siblings('dl').find('dd').slideUp(300);
		}else{
			$(this).removeClass('active');
			$(this).siblings('dd').slideUp(300);
		};
	});
	
	//select模拟
	$('.firstP1').text($('.select_ul1 li:first').text());
	$('.hideselect1').find('option').val($('.select_ul1 li:first').text()).text($('.select_ul1 li:first').text());
	$('.select_div1').find('.clid1, .firstP1').click(function(){
		$(this).siblings('.select_ul1').show();
		$('.clid1').addClass('clid1_bj1');
		$('.select_ul1 li').click(function(){
			$('.firstP1').text($(this).text())	
			$('.hideselect1').find('option').val($(this).text()).text($(this).text());
			$('.select_ul1').hide();
			$('.select_div1').find('.clid1').removeClass('clid1_bj1');
		})
			var lilengths=$('.select_ul1 li').size();
			for(var i=0;i<lilengths;i++){
		if($('.firstP1').text()==$('.select_ul1 li').eq(i).text()){
			$('.select_ul1 li').eq(i).css('background','#f0f0f0').siblings('li').css('background','none');
			}
		}
		$('.select_ul1 li').hover(function(){
			$(this).css('background','#f0f0f0').siblings('li').css('background','none');	
		})
		$('.select_ul1').hover(function(){
			$(this).show();	
		},function(){
			$(this).hide();	
		})
	});
	
	//--nav
	$('.navUl li').hover(function(){
		$(this).addClass('focus')
	},function(){
		$(this).removeClass('focus')
	});
	//--footer友情链接/微信/app下载;浮动窗口显示
	var linkBox_h=$('.linkBox').outerHeight(true)+10;
	var linkBox_w=$('.linkBox').outerWidth(true);
	function default_blink(){
		var blink_L=$('.blink').offset().left+($('.blink').width()/2);
		var blink_T=$('.blink').offset().top;
		$('.linkBox').css({'left':blink_L,'top':blink_T,'margin-top':-linkBox_h,'margin-left':-(linkBox_w/2)});
	}
	var time=null;
	$('.blink').hover(function(){
		default_blink();
		$('.linkBox').show();
		$('.linkBox').addClass('fadeInDown');
		clearInterval(time);
	},function(){
		time=setInterval(function(){
		$('.linkBox').hide();
		},1000)
	});
	$('.linkBox').hover(function(){
		$('.linkBox').show()
		clearInterval(time);
	},function(){
		$('.linkBox').hide();
	});
	//--
	var weixinBox_h=$('.weixinBox').outerHeight(true)+10;
	var weixinBox_w=$('.weixinBox').outerWidth(true);
	function default_weixina(){
	  var weixina_L=$('.weixina').offset().left+($('.weixina').width()/2)+17;
	  var weixina_T=$('.weixina').offset().top;
	  $('.weixinBox').css({'left':weixina_L,'top':weixina_T,'margin-top':-weixinBox_h,'margin-left':-(weixinBox_w/2)})
	}
	$('.weixina').hover(function(){
		default_weixina()		
		$('.weixinBox').show()
		$('.weixinBox').addClass('fadeInDown');
	},function(){
		$('.weixinBox').hide()
	});

	//--
	var appdownBox_h=$('.appdownBox').outerHeight(true)+10;
	var appdownBox_w=$('.appdownBox').outerWidth(true);
	function default_appdown(){
	  var appdown_L=$('.appdown').offset().left+($('.appdown').width()/2)+17;
	  var appdown_T=$('.appdown').offset().top;
	  $('.appdownBox').css({'left':appdown_L,'top':appdown_T,'margin-top':-appdownBox_h,'margin-left':-(appdownBox_w/2)})
	}
	$('.appdown').hover(function(){
		default_appdown()
		$('.appdownBox').show()
		$('.appdownBox').addClass('fadeInDown');
	},function(){
		$('.appdownBox').hide()
	});
	
	//----------
	$('.tip_T').find('.close').click(function(){
		$('.tip_T').remove();
	});
	//----用户中心、用户头像
	$('.dl_name dt').hover(function(){
		$(this).find('.bj_1').show();
		$(this).find('a').show();
	},function(){
		$(this).find('.bj_1').hide();
		$(this).find('a').hide();
	});
	//---Tab
	$('.fund_tab_title').find('a').hover(function(){
		$(this).addClass('active').siblings('a').removeClass('active');
		$('.fund_tab_show').eq($('.fund_tab_title').find('a').index(this)).show().siblings('.fund_tab_show').hide();
	});
	//----基金页文件展开列表/弹出文件详情
		$('.file_list').each(function(index, element) {
            var ind=index+1;
			if(ind<10){
				$(this).find('dt').find('i.num').text("0"+ind);
			}else{
				$(this).find('dt').find('i.num').text(ind);
			}
        });
	$('.file_list').find('dt').click(function(){
		if($(this).siblings('dd').is(':hidden')){
			$(this).addClass('active');
			$(this).parent().siblings('dl').find('dt').removeClass('active');
			$(this).siblings('dd').slideDown(300);
			$(this).parent().siblings('dl').find('dd').slideUp(300);
		}else{
			$(this).removeClass('active');
			$(this).siblings('dd').slideUp(300);
		};
	});
	
	$('.filename').click(function(){
	  var durl=$(this).parent().find('.download').attr('href');
	  var file_text=$(this).parent().find('.file_text').html();
	  var winWidth = $(window).width();
	  var winHeight = $(window).height();
	  var H=$('.file_popup').height();
	  var W=$('.file_popup').width();
	  $('body').prepend("<div id='bg_color'  style='width:100%;filter:alpha(opacity=50);opacity: 0.5;height:100%;background:#000; position:fixed;z-index:1000;'></div>");
	  $('.file_popup').show();
	  $('.file_popup').addClass('bounceIn_into');
	  $('.file_popup').css({'left':((winWidth-W)/2),'top':((winHeight-H)/2)});
	  $('.file_popup').find('.popup_ld').attr('href',durl)
	  $('.file_popup').find('.filetextBox').html(file_text)
	  
	  $('#bg_color').click(function(){
		  $('.file_popup').hide();
		  $('#bg_color').hide();
	  });
	});
	$('.file_popup').find('.close').click(function(){
		$('.file_popup').hide();
		$('#bg_color').hide();
	});
	
	
	//--返回顶部
	$(window).scroll(function(){
	if ($(window).scrollTop()>100){
		$("#backtop").fadeIn(600);
		}
		else
		{
		$("#backtop").fadeOut(600);
		}
	});
	$("#backtop").click(function(){
		$('body,html').animate({scrollTop:0},400);
			return false;
   });

	  
	  
	  
});


