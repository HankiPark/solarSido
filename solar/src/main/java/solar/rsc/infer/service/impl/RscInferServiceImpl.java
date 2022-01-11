package solar.rsc.infer.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.rsc.infer.service.RscInfer;
import solar.rsc.infer.service.RscInferService;

@Service
public class RscInferServiceImpl implements RscInferService {

	@Autowired
	RscInferMapper rscInferMapper;
	
	@Override
	public List<RscInfer> selectAll() {
		return rscInferMapper.selectAll();
	}

}
