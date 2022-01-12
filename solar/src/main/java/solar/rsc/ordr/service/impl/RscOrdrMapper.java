package solar.rsc.ordr.service.impl;

import java.util.List;
import java.util.Map;

import solar.rsc.ordr.service.RscOrdr;

public interface RscOrdrMapper {
	List<RscOrdr> search(Map map);
	int update();
}
