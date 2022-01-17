package solar.rsc.inout.service.impl;

import java.util.List;

import solar.rsc.inout.service.RscInOut;

public interface RscInOutMapper {
	List<RscInOut> selectAll();
	int insert(RscInOut rscInOut);
	int stcInc(RscInOut rscInOut);
}
