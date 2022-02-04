<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="inferGrid"></div>
</body>
<script>
var Grid = tui.Grid;
Grid.setLanguage('ko');
var inferGrid = new Grid({
    el: document.getElementById('inferGrid'),
    scrollX: true,
    scrollY: true,
    data: inferDataSource,
    columns: [{
        header: '불량코드',
        name: 'cmmnCdDetaId'
      },
      {
        header: '불량명',
        name: 'cmmnCdNm'
      },
      {
        header: '불량량',
        name: 'rscInferQty',
        editor: 'text'
      }
    ],
    summary: {
    	position: 'bottom',
    	height: 50,
    	columnContent: {
    		rscInferQty:{
    			template(summary){
    				sum = summary.sum;
    				return '합계: ' + summary.sum;
    			}
    		}
    	}
    }
  });
  
  inferGrid.on('editingFinish',function(ev){
	  let rowCnt = inferGrid.getRowCount();
	  let fullQty = parseInt(grid.getValue(curRowKey,'rscIstQty'));
	  let inferSum = 0;
	  let rest = fullQty;
	  
	  
	  for(let i = 0; i<rowCnt; i++){
		  let curVal = parseInt(inferGrid.getValue(i,'rscInferQty'));
		  if(curVal+''!='NaN'){
			  inferSum += curVal;
		  }
	  }

	  
	  if(inferSum>fullQty){
		  for(let i = 0; i<rowCnt; i++){
              let curVal = parseInt(inferGrid.getValue(i,'rscInferQty'));
			  if(i!=ev.rowKey && curVal+'' != 'NaN'){
				  rest -= curVal; 
			  }
		  }
		  alert('총량보다 많은 불량량을 입력할 수 없습니다.\n초과된 수량: '+(inferSum-fullQty));
		  inferGrid.setValue(ev.rowKey,'rscInferQty',rest);
	  }
	  
	  console.log(fullQty);
	  console.log(inferSum);
	  console.log(rest);
  });
</script>
</html>