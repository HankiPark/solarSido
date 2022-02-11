<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자제코드 정보</title>
</head>
<body>
<label>자재코드</label> <input type = "text" id="rscCdIn">
<label>자재명</label> <input type = "text" id="rscNmIn">
<button type = "button" id ="btnFind">조회</button>
<div id = "gridRsc">
</body>
<script type="text/javascript">
function rscinfoList(key){

	var dataSource = {
			  api: {
			    	readData: { url: '${pageContext.request.contextPath}/grid/rscinfoModal', 
						    	method: 'GET' 
						   },
					modifyData: { url: '${pageContext.request.contextPath}/grid/prdtbomUpdateIn.do', 
								method: 'POST',
								cache:false			 
						},
	/*				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 */
					contentType: 'application/json'
					}
			}
		const gridRsc = new tui.Grid({
			el : document.getElementById('gridRsc'), // 컨테이너 엘리먼트
			data : dataSource,
			scrollY : true,
			bodyHeight : 500,
			
			  columns : [
					{
						header : '자재코드',
						name : 'rscCd',
					    sortable: true,
					},
					{
						header : '자재명',
						name : 'rscNm'
					},
					{
						header : '안전재고',
						name : 'safStc',
						hidden : true
					},
					{
						header : '업체코드',
						name : 'coCd',
						hidden : true
					},
					{
						header : '규격',
						name : 'rscSpec',
						hidden : true
					},
					{
						header : '관리단위',
						name : 'rscUnit',
						hidden : true
					},
					{
						header : '이미지',
						name : 'rscImg',
						hidden : true
					},
					{
						header : '규격',
						name : 'rscUntprc',
						hidden : true
					}
				]
			  });

	gridRsc.on('onGridUpdate', function(){
			gridRsc.refreshLayout();
		});
		
	gridRsc.on('response', function(ev) { 
			let res = JSON.parse(ev.xhr.response);
			if(res.mode=='upd'){
				gridRsc.resetOriginData();
			}
			else {
				gridRsc.refreshLayout()
				}
		});

		$('#btnFind').on('click', function(){
			
			var rscCd = $("#rscCdIn").val();
			var rscNm = $("#rscNmIn").val();
			var parameter = {
					'rscCd' : rscCd,
					'rscNm' : rscNm
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/grid/findRsc',
				data : parameter,
				contentType: 'application/json; charset=utf-8'
			}).done(function(res){
				var info = JSON.parse(res);
				gridRsc.resetData(info["data"]["contents"]);
			})
			
		});
		
		gridRsc.on('dbclick', function(ev){
			$('#rscNm').val(gridRsc.getValue(ev["rowKey"], "rscNm"));
			dialog2.dialog("close")
		});
			
		gridRsc.on('dblclick', function(ev){
			if(ev["rowKey"]!=null){
				grid.setValue(key, 'rscCd', gridRsc.getValue(ev["rowKey"], "rscCd"));
				grid.setValue(key, 'rscNm', gridRsc.getValue(ev["rowKey"], "rscNm"));
				dialog2.dialog("close");
			}
		});
}
</script>
</html>