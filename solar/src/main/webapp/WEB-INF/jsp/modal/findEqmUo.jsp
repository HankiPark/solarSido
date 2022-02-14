<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 설비현황 조회 그리드 -->
	<label>제품코드</label>
	<input type="text" id="prdtCdFind">
	<button type="button" id="btnfind">검색</button>
	<button type="button" id="btnReset">초기화</button>
		
	<div id="eqmUogrid"></div>
</body>

<script type="text/javascript">
function eqmUoList(){
	const eqmUogrid = new tui.Grid({
		el: document.getElementById('eqmUogrid'),
		data: {
			api: {
				readData: { 
					url: '${pageContext.request.contextPath}/grid/eqmUoMoniter.do', 
					method: 'GET'
					}
				},
			contentType: 'application/json'
		}, 
		scrollX: false,
		scrollY: true,
		bodyHeight: 500,
		columns: [
			 {
			    header: '제품번호',
			    name: 'prdt_cd',
				align : 'center'
			  },
		 	 {
			    header: '공정순서',
			    name: 'prcs_ord',
				align : 'center'
			  },
			  {
			    header: '공정코드',
			    name: 'prcs_cd',
				align : 'center'
			  },
			  {
			    header: '설비코드',
			    name: 'eqm_cd',
				align : 'center'
			  },
			 
			  { 
			    header: '비가동코드',
			    name: 'uopr_cd',
				align : 'center'
			  }
	 		 ]
	});	
	
	//검색버튼
	$('#btnfind').on('click', function() {
		var prdtCd = $("#prdtCdFind").val();
		var params = {
			'prdtCd' : prdtCd
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/grid/eqmUoMoniter.do',
			data : params,
			contentType : 'application/json; charset=utf-8'
		}).done(function(res) {
			var sres = JSON.parse(res);
			eqmUogrid.resetData(sres["data"]["contents"]);
		})
	});
	
	eqmUogrid.on('onGridUpdated', function() {
		eqmUogrid.refreshLayout();
	});
	
}
	</script>
</html>