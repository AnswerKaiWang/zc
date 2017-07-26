$(function(){
	
	//--页面加载完成前遮罩层
	var imgsrc=base +'/frontCura/images/logo.png';//图片路径
	$('body').prepend("<div class='before_loading'>")
	$('.before_loading').prepend("<img class='before_loading_logo' >");
	$('.before_loading_logo').attr('src',imgsrc);
	var $$=function(func){  
			if (document.addEventListener){  
				window.addEventListener("load", func, false);  
			}else if (document.attachEvent){  
				window.attachEvent("onload", func);  
			}; 
	}; 
	$$(function(){  
	   $('.before_loading').fadeOut();
	}); 
	
	
	//---全站页面元素添加动画效果--
 	var oHead = document.getElementsByTagName('head').item(0);
    var oScript= document.createElement("script");
    oScript.type = "text/javascript";
    oScript.src=base +"/frontCura/js/wow.min.js";//js路径
    oHead.appendChild( oScript);
	
	$('.wqhd_ty_title').addClass('wow  flipInY');
	$('.DL').addClass('wow fadeInLeft');
	$('.picFocus').addClass('wow lightSpeedIn');
	$('.wqhd_4').addClass('wow rotateInUpLeft');
	$('.wqhd_5').addClass('wow rotateInUpRight');
	$('.disclaimer').addClass('wow slideInDown');
	$('.expert ul').find('li:even').addClass('wow  slideInLeft');
	$('.expert ul').find('li:odd').addClass('wow  slideInRight');
	$('.wjt_content').find('.ul').find('li:even').addClass('wow  slideInLeft');
	$('.wjt_content').find('.ul').find('li:odd').addClass('wow  slideInRight');
	$('.user_Box').addClass('wow  slideInDown');
	$('.user_Box').find('.L').find('dt').addClass('wow  rotateIn');
	$('.queryPage_Left').addClass('wow  fadeInLeft');
	$('.queryPage_Right').addClass('wow  fadeInRight');
	$('.news_L').addClass('wow  fadeInLeft');
	$('.news_R').addClass('wow  fadeInRight');
	$('.wjt_Left').addClass('wow  fadeInLeft');
	$('.wjt_Right').addClass('wow  fadeInRight');
	$('.product_details_Left').addClass('wow  slideInUp');
	$('.product_details_Right').addClass('wow  fadeInRight');
	$('.ulWrap').addClass('wow  rotateIn');
	$('.news_title').addClass('wow  pulse');
	$('.news_content').addClass('wow  fadeInUp');
	$('.introduction').addClass('wow  slideInUp');
	$('.Highlights').addClass('wow  bounceInUp');
	$('.Arrangement').addClass('wow  bounceInDown');
	$('.brief_1').find('.dl_1').addClass('wow  fadeInRight');
	$('.brief_1').find('.dl_2').addClass('wow  fadeInLeft');
	$('.footer').addClass('wow  slideInUp');


		
	//--默认css设置
	$('.hd_r ul').find('li:last').css({'background':'none','padding-right':'0px'});
	$('.top').find('.R').find('li:last').css({'background':'none','padding-right':'0px'});
	$('.Arrangement').find('.table').find('tr:odd').find('td').css({'background':'#f3f3f3'});
	$('.Highlights').find('.list_w').find('dl:last').css({'border-bottom':'none'});	
	$('.picScroll_L').find('li').find('.timg').wrap("<span class='imgwrap'></span>");
	
	//全站按钮添加hover效果class---空心变实心
	$('a.more_news').addClass('hvr-sweep-to-right');
	//全站按钮添加hover效果class---实心变空心
	$('a.yy_button,a.view_details,a.close_bookingfinish_popup,button.submit,a.a_sign,a.submit,a.bm,a.yzma_2').addClass('hvr-sweep-to-right-o');
	$('.r_search').find('button.submit').removeClass('hvr-sweep-to-right-o');
	$('.jjcp_search').find('button.submit').removeClass('hvr-sweep-to-right-o');
	$('a.yy_button.disabled').removeClass('hvr-sweep-to-right-o');
	 
	$('a.yy_button,a.view_details,a.close_bookingfinish_popup,button.submit,a.a_sign,a.submit,a.bm,a.yzma_2').each(function(){

        var cl=$(this).text();
		$(cl).empty();
		$(this).prepend("<span class='button_txt_wrap'>"+cl+"</span>")

    });
	$('a.yy_button.disabled').find('.button_txt_wrap').empty();
	//--公用标题
	$('span.j_sp').each(function(index, element) {
	   var W=$(this).outerWidth(true)/2;
       $(this).css('margin-left',-W);
    });
	
	
	
	//---新闻页面banner
	if($('.banner_link').length>0){
		
		var W=$('.banner_link').width()/2;
		var H=$('.banner_link').height();
		$('.banner_link').find('a').find('p').css({'width':W,'height':H});
		$('.banner_link').find('div.fl,div.fr').hover(function(){
			$(this).find('h1').animate({'width':W-40,'height':H-40,'left':'20px','top':'20px'},300);
			$(this).find('p').find('em').addClass('animation_em');
		},function(){
			$(this).find('h1').animate({'width':W,'height':H,'left':'0px','top':'0px'},300);
			$(this).find('p').find('em').removeClass('animation_em');
		});
	
	};


	//---Menu菜单border
	$('.queryPage_Left').find('.Menu').prepend("<li class='border_left'></li>");
	var ul_h=$('.queryPage_Left').find('.Menu').height();
	var li_h=$('.queryPage_Left').find('.Menu').find('li:last').height();
	$('.queryPage_Left').find('.Menu').find('li.border_left').height(ul_h-li_h);
	$('.queryPage_Left').find('.Menu').find('li.border_left').css('top',li_h/2);

	//--微讲堂列表页
	$('.wjt_content').find('.aimg').hover(function() {
		$(this).find('em').show();
		$(this).find('.ico-play').show();
		$(this).find('.ico-play').addClass('bounceIn  animated');
	},function() {
		$(this).find('em').hide();
		$(this).find('.ico-play').hide();
		$(this).find('.ico-play').removeClass('bounceIn  animated');
	});

	
	//登陆页-tab
	$('.login_tab_title').find('a').click(function() {
		$(this).addClass('active').siblings('a').removeClass('active');
		$('.showform').hide();
		$('.showform').eq($('.login_tab_title').find('a').index(this)).show();
	});
	
	//专家照片文字层显示
	$('.imgtxtbox').hover(function(){
		$(this).find('i').stop(true,true).animate({'bottom':'0'},200);
		$(this).find('.txt').stop(true,true).animate({'bottom':'0'},200);
	},function(){
		var b=-$(this).height()+"px";

		$(this).find('i').stop(true,true).animate({'bottom':b},200);
		$(this).find('.txt').stop(true,true).animate({'bottom':b},200);
	});

	//专家照片文字层显示2
	$('.ul_w_picScroll_L').find('.abox').hover(function(){
		$(this).find('.bj').stop(true,true).animate({'bottom':'0'},200);
		$(this).find('.txt').stop(true,true).animate({'bottom':'50%'},200);
	},function(){
		var b=-$(this).height()+"px";

		$(this).find('.bj').stop(true,true).animate({'bottom':b},200);
		$(this).find('.txt').stop(true,true).animate({'bottom':b},200);
	});

	
	
	//注册页-显示用户协议
	$('.show_user_xieyi_1').click(function() {
		$('.xieyi_1').show().addClass('bounceIn_into');
		$('body').prepend("<div id='bg_color'  style='width:100%;filter:alpha(opacity=30);opacity: 0.3;height:100%;background:#000; position:fixed;z-index:600;'></div>");
		$('body').css('overflow-y','hidden');
	});
	$('.show_user_xieyi_2').click(function() {
		$('.xieyi_2').show().addClass('bounceIn_into');
		$('body').prepend("<div id='bg_color'  style='width:100%;filter:alpha(opacity=30);opacity: 0.3;height:100%;background:#000; position:fixed;z-index:999999999;'></div>");
		$('body').css('overflow-y','hidden');
	});
	$('.close_xieyi').click(function() {
		$(this).parents('.user_xieyi').hide().removeClass('bounceIn_into');		
		$('#bg_color').hide();
		$('body').css('overflow-y','auto');
		
	});
	 


	//--微信/在线顾问;浮动窗口显示
	//--
	var weixinBox_h=$('.weixinBox').outerHeight(true)+10;
	var weixinBox_w=$('.weixinBox').outerWidth(true);
	function default_weixina(){
	  var weixina_L=$('.weixina').offset().left+($('.weixina').width()/2)+17;
	  var weixina_T=$('.weixina').offset().top;
	  var weixina_h=$('.weixina').height()+10;
	  $('.weixinBox').css({'left':weixina_L,'top':weixina_T,'margin-top':weixina_h,'margin-left':-(weixinBox_w/2)})
	}
	$('.weixina').hover(function(){
		default_weixina()		
		$('.weixinBox').show()
		$('.weixinBox').addClass('fadeInUp_2 animated');
		$('.weixina').addClass('active')
	},function(){
		$('.weixinBox').hide()
		$('.weixina').removeClass('active')
	});
	//--
	var guwenBox_h=$('.guwenBox').outerHeight(true)+10;
	var guwenBox_w=$('.guwenBox').outerWidth(true);
	function default_guwena(){
	  var guwena_L=$('.guwena').offset().left+($('.guwena').width()/2)+17;
	  var guwena_T=$('.guwena').offset().top;
	  var guwena_h=$('.guwena').height()+10;
	  $('.guwenBox').css({'left':guwena_L,'top':guwena_T,'margin-top':guwena_h,'margin-left':-(guwenBox_w/2)})
	}
	$('.guwena').hover(function(){
		default_guwena()		
		$('.guwenBox').show()
		$('.guwenBox').addClass('fadeInUp_2 animated');
		$('.guwena').addClass('active')
	},function(){
		$('.guwenBox').hide()
		$('.guwena').removeClass('active')

	});

	//--------分享代码显示	
	var time=null;
	$('.ico-fenxiang').hover(function(){
		var bdsharebuttonbox_h=$('.bdsharebuttonbox_style_1').outerHeight(true)+10;
	    var bdsharebuttonbox_w=$('.bdsharebuttonbox_style_1').outerWidth(true);
		$('.bdsharebuttonbox_style_1').show();
		 var fenxiang_L=$(this).offset().left+($('.ico-fenxiang').width()/2)+25;
		 var fenxiang_T=$(this).offset().top;
		 var ifenxiang_h=$(this).height()+10;
	    $('.bdsharebuttonbox_style_1').css({'left':fenxiang_L,'top':fenxiang_T,'margin-top':ifenxiang_h})
		clearInterval(time);
	},function(){
		time=setInterval(function(){
			$('.bdsharebuttonbox_style_1').hide()
			
		},800)

	});
	$('.bdsharebuttonbox_style_1').hover(function(){
		$('.bdsharebuttonbox_style_1').show()
		clearInterval(time);
	},function(){
		$('.bdsharebuttonbox_style_1').hide();
	});

	//--我的消息页,显示更多文字
	$('.my_message_list').each(function(index, element) {
	  //显示出“更多“按钮
	  if($(this).find('dt').find('.txt').height()>$(this).find('dt').height()){
		  $(this).find('dt').find('.more').css('display','block');
	  };
	  //显示更多
	  var This=$(this)
	  var dH=$(This).find('dt').height();
	  var tH=$(This).find('dt').find('.txt').height();
	  $(This).find('dt').find('.more').click(function(){
		  if($(this).hasClass('ico-xiangxia2')){
			  $(this).removeClass('ico-xiangxia2').addClass('ico-shangjiantou');
			  $(This).find('dt').animate({'height':tH},300);
		  }else{
			  $(this).addClass('ico-xiangxia2').removeClass('ico-shangjiantou');
			  $(This).find('dt').animate({'height':dH},300);
		  };
	  });
	});



	
	//--返回顶部
	if($("#back_top").length>0&&$(".main").length>0){
		
		$(window).scroll(function(){
			if ($(window).scrollTop()>200){
				$("#back_top").show();
			}else{
				$("#back_top").hide();
			};
		});
		var mL=$('.main').offset().left;
		var mw=$('.main').width();
		var fth=$('.footer').outerHeight(true);
		$("#back_top").css({'left':mL+mw+5,'bottom':fth+10})	
		$("#back_top").click(function(){
			$('body,html').animate({scrollTop:0},400);
				return false;
	   });

	};


	//导航条下拉时固定	
	if($('.header').length>0){
	$('.header').after("<div class='MT'></div>");
	var MTH=$('.top').outerHeight(true)+$('.header').outerHeight(true);
	$('.MT').height(MTH);
				$('.top').addClass('fixed_top');
				$('.header').addClass('fixed_header');
		/*var header_t=$('.top').offset().top;		
		 $(window).scroll(function () {
			var winTop = $(window).scrollTop();
			
			if(winTop>=header_t){
				$('.header').addClass('fixed_header');
				$('.top').addClass('fixed_top');
			}else{
				$('.header').removeClass('fixed_header');
				$('.top').removeClass('fixed_top');
			};			
		 });*/
	};



	
	  
	  
});


//----
function DrawImage(ImgD,FitWidth,FitHeight){
    var image=new Image();
    image.src=ImgD.src;
    if(image.width>0 && image.height>0){
        if(image.width/image.height>= FitWidth/FitHeight){
            if(image.width>FitWidth){
                ImgD.width=FitWidth;
                ImgD.height=(image.height*FitWidth)/image.width;
            }else{
                ImgD.width=image.width; 
               ImgD.height=image.height;
            }
        } else{
            if(image.height>FitHeight){
                ImgD.height=FitHeight;
                ImgD.width=(image.width*FitHeight)/image.height;
            }else{
               ImgD.width=image.width; 
               ImgD.height=image.height;
            } 
       }
    }
};


