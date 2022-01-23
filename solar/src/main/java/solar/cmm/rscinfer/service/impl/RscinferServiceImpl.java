package solar.cmm.rscinfer.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.prcs.dao.FairVO;
import solar.cmm.rscinfer.dao.RscinferVO;
import solar.cmm.rscinfer.service.RscinferService;
import solar.cmm.uoprcd.dao.UoprcdVO;
import solar.sales.order.dao.ModifyVO;

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

	@Override
	public int modifyData(ModifyVO<RscinferVO> modifyVO) {
		if(modifyVO.getCreatedRows()!=null) {
		for(RscinferVO rscinferVO : modifyVO.getCreatedRows()) {
			rscinferMapper.rscinferInsert(rscinferVO);
			}
		if(modifyVO.getDeletedRows()!=null) {
			for(RscinferVO rscinferVO : modifyVO.getDeletedRows()) {
				rscinferMapper.rscinferDelete(rscinferVO);
				}
			}
		if(modifyVO.getUpdatedRows()!=null) {
			for(RscinferVO rscinferVO : modifyVO.getUpdatedRows()) {
				rscinferMapper.rscinferUpdate(rscinferVO);
				}
			}
		}
		return 1;
	}

	@Override
	public List<RscinferVO> rscinferdataFind(RscinferVO rscinferVO) {
		// TODO Auto-generated method stub
		return rscinferMapper.rscinferdataFind(rscinferVO) ;
	}
}
