package solar.rsc.ordr.service;

import java.util.List;
import java.util.Map;

import solar.sales.order.dao.ModifyVO;

public interface RscOrdrService {
	List<RscOrdr> search(Map<String, String> map);
	void modify(ModifyVO<RscOrdr> mvo);
	List<?> selectDmnd(RscOrdr rscOrdr);
	int dmndUpdate(Map<String, List<RscOrdr>> map);
}
