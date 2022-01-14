package solar.prcs.clot.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prcs.clot.service.ClotService;
import solar.prcs.prcs.service.ClotVO;

@Service
public class ClotServiceImpl implements ClotService {

	
	@Autowired
	ClotMapper clotMapper;
	
	@Override
	public List<ClotVO> SelectAll() {
		return clotMapper.SelectAll();
	}

}
