package solar.cmm.uoprcd.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.uoprcd.dao.UoprcdVO;
import solar.cmm.uoprcd.service.UoprcdService;
import solar.sales.order.dao.ModifyVO;

@Service
public class UoprcdServiceImpl implements UoprcdService{

	@Autowired UoprcdMapper uoprcdMapper;
	
	@Override
	public List<UoprcdVO> uoprcdList(UoprcdVO uoprcdVO) {
		// TODO Auto-generated method stub
		return uoprcdMapper.uoprcdList(uoprcdVO);
	}

	@Override
	public UoprcdVO findById(String no) {
		// TODO Auto-generated method stub
		return uoprcdMapper.findById(no);
	}

	@Override
	public int uoprcdInsert(UoprcdVO uoprcdVO) {
		// TODO Auto-generated method stub
		return uoprcdMapper.uoprcdInsert(uoprcdVO);
	}

	@Override
	public int uoprcdUpdate(UoprcdVO uoprcdVO) {
		// TODO Auto-generated method stub
		return uoprcdMapper.uoprcdUpdate(uoprcdVO);
	}

	@Override
	public int uoprcdDelete(UoprcdVO uoprcdVO) {
		// TODO Auto-generated method stub
		return uoprcdMapper.uoprcdDelete(uoprcdVO);
	}

	@Override
	public int modifyData(ModifyVO<UoprcdVO> mvo) {
		if(mvo.getCreatedRows()!=null) {
		for(UoprcdVO uoprcdVO : mvo.getCreatedRows()) {
			uoprcdMapper.uoprcdInsert(uoprcdVO);
			}
		if(mvo.getDeletedRows()!=null) {
			for(UoprcdVO uoprcdVO : mvo.getDeletedRows()) {
					uoprcdMapper.uoprcdDelete(uoprcdVO);
				}
			}
		if(mvo.getUpdatedRows()!=null) {
			for(UoprcdVO uoprcdVO : mvo.getUpdatedRows()) {
					uoprcdMapper.uoprcdUpdate(uoprcdVO);
				}
			}
		}
		return 1;
	}

}
