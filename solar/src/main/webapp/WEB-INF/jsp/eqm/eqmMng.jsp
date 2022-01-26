<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	margin: 0;
	padding: 0;
}

ul {
	list-style: none;
}

a {
	text-decoration: none;
	color: #333;
}

.wrap {
	padding: 15px;
	letter-spacing: -0.5px;
}

.tab_menu .list {
	overflow: hidden;
}

.tab_menu .list li {
	float: left;
	margin-right: 14px;
}

.tab_menu .list .btn {
	font-size: 13px;
}

.tab_menu .list li.is_on .btn {
	font-weight: bold;
	color: #5f76e8;
}

.tab_menu .list li.is_on .cont {
	display: block;
}

#oG {
	display: none;
}
</style>
</head>
<body>
	<div class="wrap">
		<div class="tab_menu">
			<ul class="list">
				<li class="is_on"><a href="#" id="in" class="btn">조회</a></li>
				<li><a href="#" id="out" class="btn">등록</a></li>
			</ul>
		</div>
	</div>

	<div id="iG">
		<div class="card card-pricing card-primary card-white">
			<div class="card-body">
				<div class="row">
					<div data-role="fieldcontain" class="col-3">

						<div>
							<label>설비코드</label><input type="text">
						</div>
					</div>

					<label for="defandroid">날짜 선택</label> <input name="startT"
						class="dtp" id="startT" type="text" data-role="datebox"
						data-options='{"mode": "calbox"}'>
				</div>
				<div data-role="fieldcontain" class="col-5">
					<label>제품명</label> <input type="text" id="prdNm">
					<button type="button" id="prdtNmBtn" style="width: 33px">
						🔍</button>
				</div>
			</div>
			<div>
				<button type="button" id="findgrid">조회</button>
			</div>

			<div align="right">
				<button type="button" id="insertBtn"
					class="btn btn-default btn-simple btn-sm">추가</button>
				<button type="button" id="updateBtn"
					class="btn btn-default btn-simple btn-sm">저장</button>
				<button type="button" id="deleteBtn"
					class="btn btn-default btn-simple btn-sm">삭제</button>
			</div>
		</div>
		<div id="grid"></div>
	</div>




	<div id="oG">

		
		<div class="card card-pricing card-primary card-white">
			<div class="card-body">
				<h2>설비 등록</h2>
				<form action="" method="get">
				<div class="container">
				<div class="row">
					<div class="col-1">설비코드 *</div>
					<div class="col-2"><input type="text" id="eqmCd" name="eqmCd" style="width:90%" readonly></div>
					<div class="col-1">설비구분 *</div>
					<div class="col-2"><select name="eqmFg" id="eqmFg" style="width:90%">
										  <option value="제조기">제조기</option>
										  <option value="레이저">레이저</option>
										  <option value="검사기">검사기</option>
										  <option value="세정기">세정기</option>
										</select></div>
					<div class="col-1">설비명 *</div>
					<div class="col-2"><input type="text" id="eqmNm" name="eqmNm" style="width:90%"></div>
					
					<hr>
				</div>
				
				<div class="row">
					<div class="col-1">모델 *</div>
					<div class="col-2"><select name="eqmMdl" id="eqmMdl"  style="width:90%">
										  <option value="MEL-01">MEL-01</option>
										  <option value="MEL-02">MEL-02</option>
										  <option value="MEL-03">MEL-03</option>
										  <option value="MEL-04">MEL-04</option>
										</select></div>
					<div class="col-1">용량/규격 *</div> 
					<div class="col-2"><select name="eqmSpec" id="eqmSpec" style="width:90%">
										  <option value="1000*1000">1000*1000</option>
										  <option value="1000*2000">1000*2000</option>
										  <option value="2000*1000">2000*1000</option>
										  <option value="3000*2000">3000*2000</option>
										</select></div>
					<div class="col-1">제작업체</div>
					<div class="col-2"><input type="text" id="eqmCo" name="eqmCo" style="width:90%"></div><hr>
				</div>
				<div class="row">
					<div class="col-1">구매일자 *</div>
					<div class="col-2"><input name="purcDt" class="dtp"
							id="eqmBuyDt" type="text" data-role="datebox"
							data-options='{"mode": "calbox"}' style="width:90%"></div>
					<div class="col-1">구매금액 *</div>
					<div class="col-2"><input type="text" name="purcAmt" id="eqmBuyAmt" style="width:90%"></div>
					<div class="col-1">라인번호 *</div>
					<div class="col-2"><input type="text" name="liNo" id="eqmLiNo" style="width:90%"></div><hr>
				</div>
				<div class="row">
					<div class="col-1">작업자 *</div>
					<div class="col-2"><input type="text" name="empId" id="eqmEmp" style="width:90%"></div>
					<div class="col-1">사용에너지</div>
					<div class="col-2"><input type="text" name="energy" id="eqmEn" style="width:90%"></div>
					<div class="col-1">부하율</div>
					<div class="col-2"><input type="text" name="lf" id="eqmLf" style="width:90%"></div><hr>
				</div>
				<div class="row">
					<div class="col-1">기준온도</div>
					<div class="col-2"><input type="text" name="temp" id="eqmTemp" style="width:90%"></div>
					<div class="col-1">UPH *</div>
					<div class="col-2"><input type="text" name="uph" id="eqmUPH" style="width:90%"></div>
					<div class="col-1">공정코드 *</div>
					<div class="col-2"><input type="text" name="prcs_cd" id="eqmPCd" style="width:90%"></div>
					<input type="hidden" id="eqmYn" name="eqmUn" style="width:90%" value="Y"></div>
				</div>
				</div>
				<br>
				<br>
				<button type="button" id="btnSub" style="width:60px">저장</button>
				</form>
			</div>
		</div>

	</div>





	<div id="dialog-form" title="제품명단"></div>
	<div id="dialog-sl" title="전표명단"></div>
	<div id="dialog-lot" title="입고대기명단"></div>
	<div id="dialog-outLot" title="출고대기명단"></div>
	<div id="dialog-ord" title="주문서명단"></div>
	<div id="dialog-outEndList" title="출고완료명단"></div>



	<script>
	//탭 설정
	const tabList = document.querySelectorAll('.tab_menu .list li');
	
	for (var i = 0; i < tabList.length; i++) {
		tabList[i].querySelector('.btn').addEventListener('click', function(e) {
					e.preventDefault();
					for (var j = 0; j < tabList.length; j++) {
						tabList[j].classList.remove('is_on');
					}
					this.parentNode.classList.add('is_on');
					if ($(this)[0].id == "in") {
						$("#oG").css("display", "none");
						$("#iG").css("display", "block");

						grid.refreshLayout();
						grid.clear();

					} else {
						$("#iG").css("display", "none");
						$("#oG").css("display", "block");
							}
						});
					}
	
	
	
	$(function() {
		
		  $('input[name="eqmBuyDt"]').daterangepicker({
			  showDropdowns: true,
		    opens: 'right',
		    startDate: moment().startOf('hour').add(-7, 'day'),
			  endDate: moment().startOf('hour'),
			  minYear: 1990,
			    maxYear: 2025,
			  autoApply: true,
			    locale: {
			      format: 'YYYY-MM-DD',
			      singleDatePicker: true,
			    	  separator: " ~ ",
			          applyLabel: "적용",
			          cancelLabel: "닫기",
			          prevText: '이전 달',
			          nextText: '다음 달',
			          monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			          daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
			          showMonthAfterYear: true,
			          yearSuffix: '년'
			    }
		  }, function(start, end, label) {
		    console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
		  },
		  
		  );
		  
		  
		  
		});
	
	
var Grid = tui.Grid;	  

const dataSource = {
	  api: {
	    	readData: { url: '${pageContext.request.contextPath}/grid/eqmList.do', 
				    	method: 'GET'
	    				},
			}, 
		contentType: 'application/json'
	};


const grid = new Grid({
	  el: document.getElementById('grid'),
	  data:dataSource,
	  columns: [
				  {
				    header: '설비코드',
				    name: 'eqmCd'
				  },
				  {
				    header: '설비구분',
				    name: 'eqmFg'
				  },
				  {
				    header: '설비명',
				    name: 'eqmNm'
				  },
				  {
				    header: '라인번호',
				    name: 'eqmMdl'                                                                                                           
				  },		  
				  {
				    header: '작업자',
				    name: 'empId'
				  },
				  {
				    header: '사용에너지',
				    name: 'energy'
				  },
				  {
				    header: '부하율',
				    name: 'lf',
				  },
				  {
				    header: '기준온도',
				    name: 'temp'
				  },
				  {
				    header: 'UPH',
				    name: 'uph',
				  },
				  {
				    header: '공정코드',
				    name: 'prcsCd',
				  },
				  {
				    header: '가동여부',
				    name: 'eqmYn',
				  },
		 		 ]
		 		
		});
		
grid.on('onGridUpdated', function() {
	grid.refreshLayout();
});

grid.on('click', (ev) => {
	console.log(ev);
  	console.log('clicked!!');
})

// 성공 실패와 관계 없이 응답을 받았을 경우
grid.on('response', function(ev) { 
	console.log(ev);
})
</script>
</body>
</html>