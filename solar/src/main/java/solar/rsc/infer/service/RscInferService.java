package solar.rsc.infer.service;

import java.util.List;
import java.util.Map;

public interface RscInferService {
	List<RscInfer> selectAll();
	List<RscInferRate> getQuarteredInferRate(Map<String,String> map);
}
