package solar.rsc.rt.service;

import java.util.List;
import java.util.Map;

public interface RscRtService {
	int insert(Map map);
	List<RscRt> search(Map map);
}
