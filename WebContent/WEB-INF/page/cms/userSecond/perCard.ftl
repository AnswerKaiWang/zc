<script>
$(function(){
	formValidate("#userSecondPerAddForm",{
		perCardNo:{
			required: true
		},
		perName:{
			required: true
		},
		perPhone:{
			required: true
		},
		perEmail:{
			email:true
		}
	})
	var firstPicIndex=0;
	picPathFileUpload();
});

function addPicture(url){
	var row = "<div class='file-item thumbnail'><img src='${base}"+url+"' >";
	row = row +"<div class='cancel'>删除</div></div>";
	$("#fileList").append(row);
}

 // 当有文件添加进来时执行，负责view的创建
    function addFile( file ) {
        var $li = $( '<li id="' + file.id + '">' +
                '<p class="title">' + file.name + '</p>' +
                '<p class="imgWrap"></p>'+
                '<p class="progress"><span></span></p>' +
                '</li>' ),

            $btns = $('<div class="file-panel">' +
                '<span class="cancel">删除</span>' +
                '<span class="rotateRight">向右旋转</span>' +
                '<span class="rotateLeft">向左旋转</span></div>').appendTo( $li ),
            $prgress = $li.find('p.progress span'),
            $wrap = $li.find( 'p.imgWrap' ),
            $info = $('<p class="error"></p>'),

            showError = function( code ) {
                switch( code ) {
                    case 'exceed_size':
                        text = '文件大小超出';
                        break;

                    case 'interrupt':
                        text = '上传暂停';
                        break;

                    default:
                        text = '上传失败，请重试';
                        break;
                }

                $info.text( text ).appendTo( $li );
            };

        if ( file.getStatus() === 'invalid' ) {
            showError( file.statusText );
        } else {
            // @todo lazyload
            $wrap.text( '预览中' );
            uploader.makeThumb( file, function( error, src ) {
                if ( error ) {
                    $wrap.text( '不能预览' );
                    return;
                }

                var img = $('<img src="'+src+'">');
                $wrap.empty().append( img );
            }, thumbnailWidth, thumbnailHeight );

            percentages[ file.id ] = [ file.size, 0 ];
            file.rotation = 0;
        }

        file.on('statuschange', function( cur, prev ) {
            if ( prev === 'progress' ) {
                $prgress.hide().width(0);
            } else if ( prev === 'queued' ) {
                $li.off( 'mouseenter mouseleave' );
                $btns.remove();
            }

            // 成功
            if ( cur === 'error' || cur === 'invalid' ) {
                console.log( file.statusText );
                showError( file.statusText );
                percentages[ file.id ][ 1 ] = 1;
            } else if ( cur === 'interrupt' ) {
                showError( 'interrupt' );
            } else if ( cur === 'queued' ) {
                percentages[ file.id ][ 1 ] = 0;
            } else if ( cur === 'progress' ) {
                $info.remove();
                $prgress.css('display', 'block');
            } else if ( cur === 'complete' ) {
                $li.append( '<span class="success"></span>' );
            }

            $li.removeClass( 'state-' + prev ).addClass( 'state-' + cur );
        });

        $li.on( 'mouseenter', function() {
            $btns.stop().animate({height: 30});
        });

        $li.on( 'mouseleave', function() {
            $btns.stop().animate({height: 0});
        });

        $btns.on( 'click', 'span', function() {
            var index = $(this).index(),
                deg;

            switch ( index ) {
                case 0:
                    uploader.removeFile( file );
                    return;

                case 1:
                    file.rotation += 90;
                    break;

                case 2:
                    file.rotation -= 90;
                    break;
            }

            if ( supportTransition ) {
                deg = 'rotate(' + file.rotation + 'deg)';
                $wrap.css({
                    '-webkit-transform': deg,
                    '-mos-transform': deg,
                    '-o-transform': deg,
                    'transform': deg
                });
            } else {
                $wrap.css( 'filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
                // use jquery animate to rotation
                // $({
                //     rotation: rotation
                // }).animate({
                //     rotation: file.rotation
                // }, {
                //     easing: 'linear',
                //     step: function( now ) {
                //         now = now * Math.PI / 180;

                //         var cos = Math.cos( now ),
                //             sin = Math.sin( now );

                //         $wrap.css( 'filter', "progid:DXImageTransform.Microsoft.Matrix(M11=" + cos + ",M12=" + (-sin) + ",M21=" + sin + ",M22=" + cos + ",SizingMethod='auto expand')");
                //     }
                // });
            }


        });

        $li.appendTo( $queue );
    }

function picPathFileUpload(){
	var fundFileUploader = WebUploader.create({
    	// 文件接收服务端。
    	server: '${base}/admin/fileUpload.htm',
    	pick: '#picPathFilePicker',
    	auto:true,
    	compress: false,
    	accept: {
            title: 'Images',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/*'
        },
    	swf: '${base}/static/common/css/plugins/webuploader/Uploader.swf'
	});
	
	fundFileUploader.on('uploadSuccess', function( file,res) {
		closeMsg(loadFileUpload)
		if(res.status!="00"){
			alertMsg("文件上传异常,请重试")
			$("#picPathPickerName").html("")
			$("#picPathAddFormUrl").val("")
		}else{
			var existPics = $("#picPathPickerName").html();
			existPics = existPics+";"+res.url;
			//$("#picPathPickerName").html(existPics+";"+res.url);
			$("#picPathAddFormUrl").val(existPics);
			//$("#uploadResults").append("<img width='70px' height='50px' src='${base}"+res.url+"'>");
			//addPicture(res.url);
		}
	});
	fundFileUploader.on( 'fileQueued', function( file ) {
        var $li = $(
                '<div id="' + file.id + '" class="file-item thumbnail">' +
                    '<img>' +
                    '<div class="info">' + file.name + '</div>' +
                '</div>'
                ),
            $img = $li.find('img');

        $("#fileList").append( $li );
        ratio = window.devicePixelRatio || 1,
        // 缩略图大小
        thumbnailWidth = 100 * ratio,
        thumbnailHeight = 100 * ratio,
        // 创建缩略图
        fundFileUploader.makeThumb( file, function( error, src ) {
            if ( error ) {
                $img.replaceWith('<span>不能预览</span>');
                return;
            }
            $img.attr( 'src', src );
        }, thumbnailWidth, thumbnailHeight );
    });
	
	fundFileUploader.on( 'uploadError', function( file ) {
		closeMsg(loadFileUpload)
		$("#picPathAddFormUrl").val("")
    	alertMsg("文件上传异常,请重试")
	});
	fundFileUploader.on( 'startUpload', function(  ) {
		loadFileUpload=loadMsg();
	});
}
function userSecondSubmitForm(parentIndex){
	var s=$("#userSecondPerAddForm").validate().form();
	if(s){
		var o=loadMsg();
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("#userSecondPerAddForm").serializeArray(),
			url:"${base}/admin/userSecond/per/save.htm",
			success:function(data){
				closeMsg(o);
				if(data.error=="00"){
					closeMsg(parentIndex);
					alertMsg('添加客户成功', 1);
					$('#userSecondPerListMain #userSecondPerTable').bootstrapTable("refresh")
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

<div style="width:800px;height:600px;padding:15px;overflow:auto;">
<form class="form-horizontal" id="userSecondPerAddForm">
	<div class="tab-content">
		<div class="tab-pane fade in active" id="userSecondPerZhengZhao">
				<br />
				<div class="form-group">
				    <label class="col-xs-2 control-label">证照名称</label>
				    <div class="col-xs-4">
				        <input type="text" class="form-control" placeholder="证照名称" name="picName" id="picName" value="">
				    </div>
				    <label class="col-xs-2 control-label">有效期</label>
				    <div class="col-xs-3">
				        <input type="text" class="form-control" placeholder="有效期" name="有效期" id="picYouxiaoqi" value="">
				    </div>
				</div>
				<div class="form-group">
				    <label class="col-xs-2 control-label">选择证照</label>
				    <div class="col-xs-7">
				    	<div id="uploader-demo" class="wu-example">
					    	<div class="uploader-list" id="fileList">
					    	
					    	</div>
					    	<div id="picPathFilePicker">选择</div>
				    	</div>
				    </div>
				    <div class="col-xs-2">
				    	<div id="picPathPickerName"></div>
				    	
				    </div>
				</div>
		</div>
	</div>
</form>
</div>