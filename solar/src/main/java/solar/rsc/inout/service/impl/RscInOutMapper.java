package solar.rsc.inout.service.impl;

import java.util.List;
import java.util.Map;

import solar.rsc.inout.service.RscInOut;

public interface RscInOutMapper {
	List<RscInOut> selectAll();
	int insert(Map map);
	int stcInc(Map map);
	List<RscInOut> search(Map map);
}
