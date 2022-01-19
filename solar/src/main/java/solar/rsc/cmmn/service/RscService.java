package solar.rsc.cmmn.service;

import java.util.List;
import java.util.Map;

public interface RscService {
	List<Rsc> selectAll();
	List<Rsc> search(Map map);
}
