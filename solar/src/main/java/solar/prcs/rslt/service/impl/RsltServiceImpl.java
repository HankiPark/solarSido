package solar.prcs.rslt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prcs.rslt.service.RsltService;
import solar.prcs.rslt.service.RsltVO;

@Service
public class RsltServiceImpl implements RsltService {


	@Autowired
	RsltMapper rsltmapper;
	
	@Override
	public List<RsltVO> SelectAll() { 
		return rsltmapper.SelectAll();
	}

}
