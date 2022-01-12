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
	public int fairInsert(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.fairInsert(fairVO);
	}

	@Override
	public int fairUpdate(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.fairUpdate(fairVO);
	}

	@Override
	public int fairDelete(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.fairDelete(fairVO);
	}

	@Override
	public void createCode(List<FairVO> createdRows) throws Exception {
		if(createdRows != null) {
			for(FairVO row : createdRows) {
				
			}
		}
	}

	@Override
	public void updateCode(FairVO fairVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteCode(FairVO fairVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void createCode(FairVO fairVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateCode(List<FairVO> updatedRows) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteCode(List<FairVO> deletedRows) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
