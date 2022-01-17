package solar.rsc.rt.service.impl;

import java.util.List;
import java.util.Map;

import solar.rsc.rt.service.RscRt;

public interface RscRtMapper {
	int insert(Map map);
	List<RscRt> search(Map map);
}
