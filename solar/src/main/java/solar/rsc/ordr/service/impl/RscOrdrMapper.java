package solar.rsc.ordr.service.impl;

import java.util.List;
import java.util.Map;

import solar.rsc.ordr.service.RscOrdr;

public interface RscOrdrMapper {
	List<RscOrdr> search(Map map);
	List<?> selectDmnd(RscOrdr rscOrdr);
	int update(RscOrdr rscOrdr);
	int insert(RscOrdr rscOrdr);
	int delete(RscOrdr rscOrdr);
	int deleteDmnd(RscOrdr rscOrdr);
	int dmndUpdate(Map<String, List<RscOrdr>> map);
}