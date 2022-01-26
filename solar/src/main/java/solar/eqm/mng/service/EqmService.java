package solar.eqm.mng.service;

import java.util.List;
import java.util.Map;

import solar.sales.order.dao.ModifyVO;
 
public interface EqmService {
	List<EqmVO> eqmList(Map map); 		//조회
	String modifyData(ModifyVO<EqmVO> mvo);			//등록
}