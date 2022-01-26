package solar.eqm.mng.service.impl;

import java.util.List;
import java.util.Map;

import solar.eqm.mng.service.EqmVO;
import solar.sales.order.dao.ModifyVO;

public interface EqmMapper { 
	List<EqmVO> eqmList(Map map); 		//조회
	int insert(EqmVO eqmVo);			//등록
}
