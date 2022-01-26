package solar.eqm.mng.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import solar.sales.order.dao.ModifyVO;
 
public interface EqmService {
	List<EqmVO> eqmList(Map map); 		//조회
	String modifyData(ModifyVO<EqmVO> mvo);
}