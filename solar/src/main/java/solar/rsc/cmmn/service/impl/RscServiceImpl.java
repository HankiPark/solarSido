package solar.rsc.cmmn.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.rsc.cmmn.service.Rsc;
import solar.rsc.cmmn.service.RscService;

@Service
public class RscServiceImpl implements RscService{

	@Autowired
	RscMapper rscMapper;
	
	@Override
	public List<Rsc> selectAll() {
		return rscMapper.selectAll();
	}

	@Override
	public List<Rsc> search(Map map) {
		return rscMapper.search(map);
	}

}
