package solar.rsc.stc.service;

import java.util.List;
import java.util.Map;

public interface RscStcService {
	List<RscStc> selectAll();
	List<RscStc> search(Map map);
}
