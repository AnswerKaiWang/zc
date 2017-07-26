/** */
var productApp = function(){

  
 
  var pushFun = function(){
    var roundabout = $('#j_push_product').roundabout({
      autoplay: true,
      autoplayDuration: 5000,
      autoplayPauseOnHover: true,
      minScale:0.9,
      minOpacity:1,
      btnNext:'#j_roundabout_next',
      btnPrev:'#j_roundabout_prev'
    });

    $('#j_roundabout_next,#j_roundabout_prev').bind({
      'mouseenter':function(){
        roundabout.roundabout("stopAutoplay")
      },
      'mouseleave':function(){
        roundabout.roundabout("startAutoplay")
      }
    });
    //console.log($('#j_push_product li:eq(2)').data('roundabout'))
  }

 

  return{
    init:function(){

    },
    productList:function(){
      pushFun();
    },
    productDetail:function(){
      moneySpinner();
    }
  }
}();