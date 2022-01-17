package solar.rsc.stc.service.impl;

import java.util.List;
import java.util.Map;

import solar.rsc.stc.service.RscStc;

public interface RscStcMapper {
	List<RscStc> selectAll();
	List<RscStc> search(Map map);
}
