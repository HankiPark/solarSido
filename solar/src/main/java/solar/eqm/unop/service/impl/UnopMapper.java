package solar.eqm.unop.service.impl;

import java.util.List;
import java.util.Map;

import solar.eqm.unop.service.UnopCdVO;
import solar.eqm.unop.service.UnopVO;

public interface UnopMapper {
	List<UnopCdVO> selectUnopCdAll();
	int updateEqmYn(Map map);
	int eqmuoInsert(Map map);
	List<UnopVO> selectUnopList(Map map);
}
