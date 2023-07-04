class ReplyService {
	static add(reply,callback,error){
		$.ajax({
			type:"post",
			url:"/replies/new",
			data:JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success:function(result,status,xhr){
				if(callback){
					callback(status);
				}
			},
			error:function(xhr,status,er){
				if(error) {
					error(xhr.status + " " + status);
				}
			}
		});
	}
	static getList(param,callback,error){
		let url = "/replies/pages/"+param.bno;
		$.getJSON(url,function(data){
			if(callback){
				//console.log(data)
				callback(data);
				}
			}).fail(function(xhr,status,er){
				error(xhr.status + " " + status);
			});
		}
		
	static get(rno,callback,error){
		//alert(rno + "번");
		let url = "/replies/"+rno;
		$.get(url,function(result){
			if(callback){
				callback(result);
				}
			}).fail(function(xhr,status,err){
				if(error){
				error();
				}
			});
		}
	static update(reply , callback , error) {
		let url = "/replies/"+reply.rno;
		$.ajax({
			type:"patch",
			url:url,
			data:JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success:function(result,status,xhr){
				if(callback){
					callback(status);
				}
			},
			error:function(xhr,status,err){
				if(error) {
					error(xhr.status + " " + status);
				}
			}
		});
	}
	static remove(rno , callback , error){
		let url = "/replies/"+rno;
		$.ajax({
			type:"delete",
			url:url,
			success:function(result,status,xhr){
				if(callback){
					callback(status);
				}
			},
			error:function(xhr,status,err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	static getListWithPaging(param,callback,error){
	let bno = param.bno;
	let page = param.page;
	$.getJSON("/replies/pages/" + bno + "/" + page,
	function(data) {
		if(callback) {
			//console.log(data.replyCnt, data.list);
			callback(data.replyCnt , data.list);
			}
		}).fail(function(xhr,status,err){
			if(error) {
				error(xhr.status + ' ' + status);
				}
			});
		};
		
	static displayTime(timeValue) {
	let today= new Date();
	let gap = today.getTime()-timeValue;
	let dateObj = new Date(timeValue);
	let str="";
	if(gap < (1000 * 60 * 60 * 24)) {
		let hh = dateObj.getHours();
		let mi = dateObj.getMinutes();
		let ss = dateObj.getSeconds();
		return [ (hh>9 ? '': '0') + hh, ':', (mi >9 ? '':'0') +mi, ':', (ss>9 ? '' : '0')+ss].join('');
	} else {
		let yy=dateObj.getFullYear();
		let mm=dateObj.getMonth() +1; //getMonth is zero-based
		let dd=dateObj.getDate();
		return[ yy, '/', (mm>9 ? '':'0') +mm, '/', (dd>9 ?'':'0')+dd ].join('');
	}
}
		
}
