package solar.co.cmmn.service;

import java.util.List;
import java.util.Map;

public interface CoService {
	List<Co> selectAll();
	List<Co> selectR(Co covo);
	List<Co> search(Map map);
}
