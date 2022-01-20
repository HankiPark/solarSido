package solar.rsc.infer.service.impl;

import java.util.List;
import java.util.Map;

import solar.rsc.infer.service.RscInfer;
import solar.rsc.infer.service.RscInferRate;

public interface RscInferMapper {
	List<RscInfer> selectAll();
	List<RscInferRate> getQuarteredInferRate(Map<String,Object> map);
}
