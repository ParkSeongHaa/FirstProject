
$(function(){
    menu()
    closeBtn()
    popupCheck()
    cookieCheck()
})

function menu(){
    $("#gnb>li").mouseover(function(){
        var a = $(this).index()
        $(".lnb").eq(a).css('display','block')
    })
    $("#gnb>li").mouseout(function(){
        var c = $(this).index()
        $(".lnb").eq(c).css('display','none')
    })
}

function closeBtn(){
    $("#closeBtn1").click(function(){
        $("#popup_1").hide()
    })    
    $("#closeBtn2").click(function(){
        $("#popup_2").hide()
    })    
}

function popupCheck(){
    $("#select1").click(function(){
        $.cookie('popup1_oneday','ok',{
            expires:1,
            path:'/'
        })
        $("#popup_1").hide()
    })
    $("#select2").click(function(){
        $.cookie('popup1_oneweek','ok',{
            expires:7,
            path:'/'
        })
        $("#popup_1").hide()
    })
    $("#select3").click(function(){
        $.cookie('popup2_oneday','ok',{
            expires:1,
            path:'/'
        })
        $("#popup_2").hide()
    })
    $("#select4").click(function(){
        $.cookie('popup2_oneweek','ok',{
            expires:7,
            path:'/'
        })
        $("#popup_2").hide()
    })
}

function cookieCheck(){
    if( $.cookie('popup1_oneday') === 'ok'){
        $("#popup_1").hide()
    }
    if( $.cookie('popup1_oneweek') === 'ok'){
        $("#popup_1").hide()
    }
    if( $.cookie('popup2_oneday') === 'ok'){
        $("#popup_2").hide()
    }
    if( $.cookie('popup2_oneweek') === 'ok'){
        $("#popup_2").hide()
    }
}

