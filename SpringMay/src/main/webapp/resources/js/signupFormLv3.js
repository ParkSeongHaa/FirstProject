var phone_check = false;
var id_duplicate_check = false;
function addressCheck(){
	$("#error__address").css('color','red');
	$("#error__address").text("필수항목입니다.");
	$("#address_detail").focus();
	return false;
}

$(function(){
	$(".info_select").on("change",function(){
		$("#email2").val($(this).val());
	})

	$("#phone1").on("input",function(e){
		let phone1 = $(this).val();
		if(phone1.length === 3) {
			$("#phone2").focus();
		}
	});
	$("#phone2").on("input",function(e){
		let phone2 = $(this).val();
		if(phone2.length === 4) {
			$("#phone3").focus();
		}
	});
	$("#phone3").on("input",function(e){
		let phone3 = $(this).val();
		if($("#phone1").val().length === 3 && $("#phone2").val().length === 4 && $("#phone3").val().length === 4) {
			$("#send").attr("style","background-color: #FFFFFF; color: #0068FF; cursor:pointer;");
			$("#send").attr("disabled",false);
		} 
	});
	$("#signup__button").on("click",function(e){
		e.preventDefault();
		if(isValid()) {
		console.log("가입완료")
			$("form").submit();
		}
	}); 
 	
	function isValid(){
		const username = $("#username").val();
		const password1 = $("#userpw1").val();
		const password2 = $("#userpw2").val();
//		const location = $("#Location").val();
		const birthday = $("#birthday").val();
		const address = $("#address_detail").val();
		const address2 = $("#addresscode").val();
		const address3 = $("#address").val();
		const genderWoman = $("#gender__woman").is(":checked");
		const genderMan = $("#gender__man").is(":checked");
		const email1 = $("#email1").val();
		const email2 = $("#email2").val();
		
		console.log(phone_check);
		$("#error__email").text("");
		$("#error__name").text("");
		$("#error__password1").text("");
		$("#error__password2").text("");
//		$("#error__location").text("");
		$("#error__gender").text(""); 

		if(password1==="") {
			$("#error__password1").text("필수항목입니다.");
			$("#userpw1").focus();
			return false;
		}
		if(password2==="") {
			$("#error__password2").css('color','red');
			$("#error__password2").text("필수항목입니다.");
			$("#userpw2").focus();
			return false;
		}
		if(password1 != password2) {
			alert("비밀번호가 일치하지 않습니다!")
			return false;
		}
		var regExp2 = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{9,20}$/;
		if(regExp2.test(password1)===false) {
			$("#error__password1").text("비밀번호가 올바르지 않습니다.");
			$("#userpw1").focus();
			return false;
		}
		if(username === "") {
			$("#error__name").text("필수항목입니다.");
			$("#username").focus();
			return false;
		}
		if(genderWoman === false && genderMan == false) {
			$("#error__gender").css('color','red');
			$("#error__gender").text("필수항목입니다.");
			$("#gender__woman").focus();
			return false;
		}
		if(birthday === "") {
			$("#error__birthday").css('color','red');
			$("#error__birthday").text("필수항목입니다.");
			$("#birthday").focus();
			return false;
		} else{
			$("#error__birthday").text("");
		} 
		if(address === "") {
			addressCheck();
		} else if(address2 === ""){
			addressCheck();
		} else if(address3 === ""){
			addressCheck();
		} else {
			$("#error__address").text("");
		}
		
	/*	const validLocations = ["서울","경기도","인천","대전","광주","대구","부산","울산","충청도","강원도","전라도","경상도","제주도"];
		if(!validLocations.includes(location)){
			$("#error__location").css('color','red');
			$("#error__location").text("필수항목입니다.");
			$("#location").focus();2
			return false;	
		}*/
		if(phone_check === false){
			alert("휴대전화 인증을 완료해주세요");
			return false;
		}
		if(email1 === "") {
			$("#error__email").css('color','red');
			$("#error__email").text("필수항목입니다.");
			$("#email1").focus();
			return false;
		}
		if(email2 === "") {
			$("#error__email").css('color','red');
			$("#error__email").text("필수항목입니다.");
			$("#email2").focus();
			return false;
		}
		if(id_duplicate_check == false){
			alert("아이디 중복검사를 완료해 주십시오.");
			return false;
		}
		
		alert("회원가입을 축하드립니다!");
		return true;
	}
	
	const timer = new Timer()
	$("#send").on("click",function(e){
		timer.getToken($("#token") , $("#send"), $("#finished"),$("#timer"));
	});
	$("#finished").on("click",function(e){
		timer.getTimerIntervalConfirm($("#finished"),$("signup__button"));
	});

//--------------------------------------------	
	
    $("#error__id").css("color","red")
	$("#userid").on("input",function(e){
		let userId = $(this).val();
		if(userId.length ===0) {
			$("#error__id").text("필수항목입니다.");
		} else if(userId.length!=0) {
            $("#error__id").text("");
        }
	}) 
	
    $("#error__name").css("color","red")
	$("#username").on("input",function(e){
		let userName = $(this).val();
		if(userName.length ===0) {
			$("#error__name").text("필수항목입니다.");
		} else if(userName.length!=0) {
            $("#error__name").text("");
        }
	})

    $("#error__password1").css("color","red")
	$("#userpw1").on("input",function(e){
		let userPw = $(this).val();
		if(userPw.length ===0) {
			$("#error__password1").text("필수항목입니다.");
		} else if(userPw.length!=0) {
            $("#error__password1").text("");
        }
	})
	

    
	$("#userpw2").on("input",function(e){
        let userPw1 = $("#userpw1").val();
		let userPw2 = $(this).val();
		if(userPw2 != userPw1) {
			$("#error__password2").text("비밀번호가 일치하지 않습니다.")
			$("#error__password2").css("color","red")
        } else if(userPw1 == userPw2) {
            $("#error__password2").text("비밀번호가 일치합니다!")
            $("#error__password2").css("color","blue")
        }
	})
	
/*	$("#Location").on("change",function(e){
		$("#error__location").text("");
	}) */
	
	$(".radioGender").on("change",function(e){
		$("#error__gender").text("");
	})	
	
	$("#birthday").on("change",function(e){
		$("#error__birthday").text("");
	})
	
	
	$(".phone").on("change",function(e){
		$("#error__phoneNum").text("");
	})
	
	$("#id_check").click(function(){
		var id = $("#userid").val();
		var regExp = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,20}$/;
		if(regExp.test(id)===false) {
			$("#error__id").text("아이디가 올바르지 않습니다.");
			$("#userid").focus();
			return false;
		} else{
        $.ajax({
          type: "POST",
          url: "/member/checkDuplicateId",
          data: id,
          async:false,
          success: function(result) {
            if (result === "duplicate") {
              alert("아이디가 중복됩니다.");
              $("#error__id_duplicate").css("color","red");
              $("#error__id_duplicate").text("중복된 아이디");
              id_duplicate_check = false;
            } else {
              alert("사용할 수 있는 아이디입니다.");
              $("#error__id_duplicate").css("color","blue");
              $("#error__id_duplicate").text("사용가능 아이디");
              id_duplicate_check = true;
              $("#userid").attr("readonly","true");
              $("#userid").css("background-color","grey");
            }
          },
          error: function(xhr , status , error) {
          console.log(xhr.status);
          console.log(error);
            alert("중복 검사에 실패했습니다.");
          }
        }); 
      }
      }); 
	

	
}) // ready end

class Timer {
	interval;	
	
	getToken(token , send , finished , timer) {
		const tk = String(Math.floor(Math.random()*100000)).padStart(6,"0")
		token.text(tk);
		send.attr("style","background-color : #FFFFFF; cursor:default;");
		send.attr("disabled",true);
		finished.attr("style","background-color: #0068FF; color:#FFFFFF; cursor:pointer;");
		finished.attr("disabled",false);
		this.getTimerInterval(token , send , finished , timer);
	}
	
	getTimerIntervalConfirm(finished , signup){
		clearInterval(this.interval)
		finished.attr("style","background-color:#FFFFFF; cursor:default;");
		finished.attr("disabled",true);
		finished.text("인증완료");
		alert("인증이 완료되었습니다.");
		phone_check = true; /* 가입시 휴대전화 인증 확인 */
		console.log(phone_check);
		signup.attr("style","background-color : #FFFFFF; color:#2c3639; border:1px solid #2c3639; cursor:pointer;");
		signup.attr("disabled",false);
	}
	
	getTimerInterval(token,send,finished,timer){
		let time=179;
		this.interval = setInterval(() =>{
			if(time >=0) {
				const minutes = Math.floor(time / 60);
				const seconds = time % 60;
				$("#timer").text(minutes + ":" + String(seconds).padStart(2,"0"));
				time-=1;
			} else{
				$("#token").text("000000");
				$("#send").attr("style","");
				$("#send").attr("disabled",true);
				$("#timer").text("3:00");
				$("#finished").attr("style","");
				$("#finished").attr("disabled",true);
				clearInterval(interval);
			}
		},1000);
	}
}

function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("addressnote").value = extraAddr;
            
            } else {
                document.getElementById("addressnote").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('addresscode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("address_detail").focus();
        }
    }).open();
}
