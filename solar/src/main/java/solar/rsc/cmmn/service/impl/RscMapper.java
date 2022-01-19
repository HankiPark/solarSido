package solar.rsc.cmmn.service.impl;

import java.util.List;
import java.util.Map;

import solar.rsc.cmmn.service.Rsc;

public interface RscMapper {
	List<Rsc> selectAll();
	List<Rsc> search(Map map);
}
