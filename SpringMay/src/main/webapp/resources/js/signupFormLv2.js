$(function(){
    agree()
})

function agree(){
    $("#all_agree").change(function(){
        if($(this).is(':checked')){
            $('.agree').prop('checked',true);
        } else{
            $('.agree').prop('checked',false);
        }
    })
    
    $(".agree").change(function(){
        if($('#agree1').is(':checked') && $('#agree2').is(':checked') && $('#agree3').is(':checked')) {
            $("#all_agree").prop('checked',true);
        } else{
            $("#all_agree").prop('checked',false);
        }
    })
    
    $("#next_level").click(function(e){
    	
        if($('#all_agree').is(':checked')){
            console.log("약관동의 완료")
        } else {
            e.preventDefault();
            alert("약관을 모두 동의해 주십시오.")
        }
    })
}







