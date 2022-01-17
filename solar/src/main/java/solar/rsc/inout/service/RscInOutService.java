package solar.rsc.inout.service;

import java.util.List;
import java.util.Map;

public interface RscInOutService {
	List<RscInOut> selectAll();
	int insert(RscInOut rscInOut);
	int stcInc(RscInOut rscInOut);
	List<RscInOut> search(Map map);
}
