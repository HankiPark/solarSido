package solar.rsc.inout.service;

import java.util.List;
import java.util.Map;

public interface RscInOutService {
	List<RscInOut> selectAll();
	int insert(Map map);
	int stcInc(Map map);
	List<RscInOut> search(Map map);
}
