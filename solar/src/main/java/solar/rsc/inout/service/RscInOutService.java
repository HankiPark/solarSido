package solar.rsc.inout.service;

import java.util.List;

public interface RscInOutService {
	List<RscInOut> selectAll();
	int insert(RscInOut rscInOut);
	int stcInc(RscInOut rscInOut);
}
