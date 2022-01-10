package solar.prcs.prcs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prcs.prcs.service.PrcsService;
import solar.prcs.prcs.service.PrcsVO;

@Service
public class PrcsServiceImpl implements PrcsService {

	
	@Autowired
	PrcsMapper prcsmapper;
	
	@Override
	public List<PrcsVO> SelectAll() {
		return prcsmapper.SelectAll();
	}

}
