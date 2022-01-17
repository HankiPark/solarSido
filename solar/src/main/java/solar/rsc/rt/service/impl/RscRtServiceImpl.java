package solar.rsc.rt.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.rsc.rt.service.RscRt;
import solar.rsc.rt.service.RscRtService;

@Service
public class RscRtServiceImpl implements RscRtService {

	@Autowired RscRtMapper rscRtMapper;
	
	@Override
	public int insert(Map map) {
		return rscRtMapper.insert(map);
	}

	@Override
	public List<RscRt> search(Map map) {
		return rscRtMapper.search(map);
	}

}
