$(function(){
    book()
    familySiteBxSlider()
    movieBxSlider()
    slideBtn()
})

function book(){
    $("#curation").click(function(){
        $('#bookContent_1').css('display','none')
        $('#bookContent_2').css('display','block')
        $('#new_book').css('color','black')
        $('#curation').css('color','red')
    })
    $("#new_book").click(function(){
        $('#bookContent_1').css('display','block');
        $('#bookContent_2').css('display','none');
        $('#new_book').css('color','red')
        $('#curation').css('color','black')
    })
}

function familySiteBxSlider(){
    var slider = $("#ulul").bxSlider({
        auto:true,
        minSlides:6,
        maxSlides:6,
        moveSlides:1,
        slideWidth:200,
        slideMargin:10,
        pager:false,
        controls:false,
        speed:1000,
        pause:2000,
    })
    $("#family_slide_prev").click(function(){
        slider.goToPrevSlide();
        return false;
    })
    $("#family_slide_next").click(function(){
        slider.goToNextSlide();
        return false;
    })
    $("#family_slide_control_stop").click(function(){
        slider.stopAuto();
        $("#family_slide_control_stop").hide()
        $("#family_slide_control_start").show()
        return false;
    })
    $("#family_slide_control_start").click(function(){
        slider.startAuto();
        $("#family_slide_control_start").hide()
        $("#family_slide_control_stop").show()
        return false;
    })
}

function movieBxSlider(){
    $("#movieSlide").bxSlider({
        auto:true,
        pager:false,
        controls:false,
        autoControls:false,
        speed:1000,
        pause:2000,
        minSlides:1,
        maxSlides:1,
        moveSlides:1
    })
}


var slideInterval = setInterval(slide,1000)
var count = 0
function slide(){
    if(count!=6) {
        $(".slide_img").removeClass('show')
        $(".slide_img").eq(count+1).addClass('show')
        if(count==5) {
            $(".slide_img").eq(5).removeClass('show')
            $(".slide_img").eq(0).addClass('show')
        }
        count++
    } 
     if(count == 6) {
        count=0
    }
    var Mcount = (count/6).toFixed(2)
    var Mcount2 = Mcount.toString().split('.')[1]
    if(count <0 && Mcount2 == 17){  //마이너스의 경우 나눗셈으로 무한해결하기
        $("#slideNum > span").text(6)
    } else if(count <0 && Mcount2 == 33) {
        $("#slideNum > span").text(5)
    } else if(count <0 && Mcount2 == 50) {
        $("#slideNum > span").text(4)
    } else if(count <0 && Mcount2 == 67) {
        $("#slideNum > span").text(3)
    } else if(count <0 && Mcount2 == 83) {
        $("#slideNum > span").text(2)
    } else if(count <0 && Mcount2 == 00) {
        $("#slideNum > span").text(1)
    } else{
        $("#slideNum > span").text(count+1)
    }
    
}
function slideBtn(){
    $("#slide_play").click(slidePlay)
    $("#slide_stop").click(slideStop)
    $("#slide_prev").click(slidePrev)
    $("#slide_next").click(slideNext)
}

function slidePlay(){
    $("#slide_play").hide()
    $("#slide_stop").show()
    clearInterval(slideInterval)
    slideInterval = setInterval(slide,1000)
}

function slideStop(){
    $("#slide_play").show()
    $("#slide_stop").hide()
    clearInterval(slideInterval)
}

function slidePrev(){
    clearInterval(slideInterval)
    count = count-2
    slide()
    slidePlay()
}

function slideNext(){
    clearInterval(slideInterval)
    slide()
    slidePlay()
}









