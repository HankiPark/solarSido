package solar.prcs.rsltd.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prcs.rsltd.service.RsltDService;
import solar.prcs.rsltd.service.RsltDVO;

@Service
public class RsltDServiceImpl implements RsltDService {

	@Autowired
	RsltDMapper rsltdmapper;
	
	@Override
	public List<RsltDVO> SelectAll() {
		return rsltdmapper.SelectAll();
	}

}
