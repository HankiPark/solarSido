<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<span>제품 LOT : </span><span id="nnn"></span><br>
<span class="float-right" >시작 : S , 종료 : E, 설비 : EQ</span>
	<div id="gridIng"></div>
	<script type="text/javascript">
	function progIng(lot){
		$("#nnn").html(lot);
		//미니 그리드(제품명단) 기본적으로 전체명단이 나옴
		const gridIng = new tui.Grid({
			el : document.getElementById('gridIng'), // 컨테이너 엘리먼트
			data : {api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/prdtIng.do',
					method : 'GET',
					initParams : {prdtLot : lot}
				}
				
			},
			contentType : 'application/json'
		},
			bodyHeight : 130,
			columns : [ 
				{
				header : '제조공정S',
				name : 'oneFr',
				 formatter:function(value){
					  if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
						else {return null;} 
				},
				align : 'center' 
				}, {
				header : '제조공정E',
				name : 'oneTo',
				 formatter:function(value){
					  if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
						else {return null;} 
				},
				align : 'center' 
			}, {
				header : '제조공정EQ',
				name : 'oneEqm',
				align : 'center'
				
			},
				{
				header : '전극공정S',
				name : 'twoFr',
				 formatter:function(value){
					  if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
						else {return null;} 
				},
				align : 'center' 
				}, {
				header : '전극공정E',
				name : 'twoTo',
				 formatter:function(value){
					  if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
						else {return null;} 
				},
				align : 'center' 
			}, {
				header : '전극공정EQ',
				name : 'twoEqm',
				align : 'center'
				
			},
				{
				header : '용접공정S',
				name : 'threeFr',
				 formatter:function(value){
					  if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
						else {return null;} 
				},
				align : 'center' 
				}, {
				header : '용접공정E',
				name : 'threeTo',
				 formatter:function(value){
					  if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
						else {return null;} 
				} ,
				align : 'center'
			}, {
				header : '용접공정EQ',
				name : 'threeEqm',
				align : 'center'
				
			},
				{
				header : '접합공정S',
				name : 'fourFr',
				 formatter:function(value){
					  if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
						else {return null;} 
				} ,
				align : 'center'
				}, {
				header : '접합공정E',
				name : 'fourTo',
				 formatter:function(value){
					  if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
						else {return null;} 
				} ,
				align : 'center'
			}, {
				header : '접합공정EQ',
				name : 'fourEqm',
				align : 'center'
				
			},
				{
				header : '불량발생S',
				name : 'errFr',
				align : 'center'
				 formatter:function(value){
					  if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
						else {return null;} 
				} 
				}, {
				header : '불량발생E',
				name : 'errTo',
				align : 'center'
				 formatter:function(value){
					  if(value.value !=null && value.value !=''){
						 var t= new Date(value.value);
						 var h,m,s;
						 if(t.getHours().toString().length==1){h="0"+t.getHours()}else{h=t.getHours()}
						 if(t.getMinutes().toString().length==1){m="0"+t.getMinutes()}else{m=t.getMinutes()}
						 if(t.getSeconds().toString().length==1){s="0"+t.getSeconds()}else{s=t.getSeconds()}
						return h+":"+m+":"+s; }
						else {return null;} 
				} 
			}, {
				header : '불량발생EQ',
				name : 'errEqm',
				align : 'center'
				
			},
			 {
				header : '에러코드',
				name : 'errCd',
				align : 'center'
				
			},
			 {
				header : '에러명',
				name : 'errNm',
				align : 'center'
				
			},

			],

		});
		

		
		
		
		gridIng.on('onGridUpdated', function() {
			gridIng.refreshLayout();
		});
	}
	
	</script>
</body>
</html>