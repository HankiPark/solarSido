package solar.rsc.infer.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.rsc.infer.service.RscInfer;
import solar.rsc.infer.service.RscInferRate;
import solar.rsc.infer.service.RscInferService;

@Service
public class RscInferServiceImpl implements RscInferService {

	@Autowired
	RscInferMapper rscInferMapper;
	
	@Override
	public List<RscInfer> selectAll() {
		return rscInferMapper.selectAll();
	}

	@Override
	public List<RscInferRate> getQuarteredInferRate(Map<String,String> map) {
		List<String> coCdList = new ArrayList<String>();
		for(String coCd : map.get("coCds").split(",")) {
			coCdList.add(coCd);
		}
		Map<String,Object> map2 = new HashMap<String, Object>();
		map2.put("year", map.get("year"));
		map2.put("coCds", coCdList);
		return rscInferMapper.getQuarteredInferRate(map2);
	}

}
