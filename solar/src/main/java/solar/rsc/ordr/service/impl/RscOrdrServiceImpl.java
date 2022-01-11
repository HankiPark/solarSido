package solar.rsc.ordr.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.rsc.ordr.service.RscOrdr;
import solar.rsc.ordr.service.RscOrdrService;

@Service
public class RscOrdrServiceImpl implements RscOrdrService {

	@Autowired
	RscOrdrMapper rscOrdrMapper;
	
	@Override
	public List<RscOrdr> search(Map map) {
		return rscOrdrMapper.search(map);
	}
}