package solar.cmm.rscinfer.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.rscinfer.dao.RscinferVO;
import solar.cmm.rscinfer.service.RscinferService;

@Service
public class RscinferServiceImpl implements RscinferService{

	@Autowired RscinferMapper rscinferMapper;
	
	@Override
	public List<RscinferVO> rscinferList(RscinferVO rscinferVO) {
		// TODO Auto-generated method stub
		return rscinferMapper.rscinferList(rscinferVO);
	}

	@Override
	public RscinferVO findById(String no) {
		// TODO Auto-generated method stub
		return rscinferMapper.findById(no);
	}

	@Override
	public int rscinferInsert(RscinferVO rscinferVO) {
		// TODO Auto-generated method stub
		return rscinferMapper.rscinferInsert(rscinferVO);
	}

	@Override
	public int rscinferUpdate(RscinferVO rscinferVO) {
		// TODO Auto-generated method stub
		return rscinferMapper.rscinferUpdate(rscinferVO);
	}

	@Override
	public int rscinferDelete(RscinferVO rscinferVO) {
		// TODO Auto-generated method stub
		return rscinferMapper.rscinferDelete(rscinferVO);
	}
}
