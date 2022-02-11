package solar.rsc.inout.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.rsc.inout.service.RscInOut;
import solar.rsc.inout.service.RscInOutService;

@Service
public class RscInOutServiceImpl implements RscInOutService {

	@Autowired RscInOutMapper rscInOutMapper;
	
	@Override
	public List<RscInOut> selectAll() {
		return rscInOutMapper.selectAll();
	}

	@Override
	public int insert(Map map) {
		return rscInOutMapper.insert(map);
	}

	@Override
	public int stcInc(Map map) {
		return rscInOutMapper.stcInc(map);
	}

	@Override
	public List<RscInOut> search(Map map) {
		return rscInOutMapper.search(map);
	}

}