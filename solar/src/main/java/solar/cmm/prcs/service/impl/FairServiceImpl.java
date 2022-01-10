package solar.cmm.prcs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.prcs.dao.FairVO;
import solar.cmm.prcs.service.FairService;

@Service
public class FairServiceImpl implements FairService {

	@Autowired FairMapper fairMapper;
	
	@Override
	public List<FairVO> fairList(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.fairList(fairVO);
	}

	@Override
	public FairVO findById(String no) {
		// TODO Auto-generated method stub
		return fairMapper.findById(no);
	}

	@Override
	public int insert(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.insert(fairVO);
	}

	@Override
	public int update(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.update(fairVO);
	}

	@Override
	public int remove(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.remove(fairVO);
	}

}
