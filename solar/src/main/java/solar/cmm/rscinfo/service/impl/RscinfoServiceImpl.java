package solar.cmm.rscinfo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.rscinfo.dao.RscinfoVO;
import solar.cmm.rscinfo.service.RscinfoService;
import solar.sales.order.dao.ModifyVO;

@Service
public class RscinfoServiceImpl implements RscinfoService{

	@Autowired RscinfoMapper rscinfoMapper;
	
	@Override
	public List<RscinfoVO> rscinfoList(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.rscinfoList(rscinfoVO);
	}

	@Override
	public List<RscinfoVO> rscinfofind(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.rscinfofind(rscinfoVO);
	}

	@Override
	public int rscinfoInsert(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.rscinfoInsert(rscinfoVO);
	}

	@Override
	public int rscinfoUpdate(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.rscinfoUpdate(rscinfoVO);
	}

	@Override
	public int rscinfoDelete(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.rscinfoDelete(rscinfoVO);
	}

	@Override
	public int modifyData(ModifyVO<RscinfoVO> modifyVO) {
		
		if(modifyVO.getCreatedRows()!=null) {
			for(RscinfoVO rscinfoVO : modifyVO.getCreatedRows()) {
				rscinfoMapper.rscinfoInsert(rscinfoVO);
			}
		}
		if(modifyVO.getDeletedRows()!=null) {
			for(RscinfoVO rscinfoVO : modifyVO.getDeletedRows()) {
				rscinfoMapper.rscinfoDelete(rscinfoVO);
			}
			if(modifyVO.getUpdatedRows()!=null) {
				for(RscinfoVO rscinfoVO : modifyVO.getUpdatedRows()) {
					rscinfoMapper.rscinfoUpdate(rscinfoVO);
				}
			}	
	}
		
		return 1;
	}

	@Override
	public RscinfoVO rscinfo(RscinfoVO rscinfoVO) {
		return rscinfoMapper.rscinfo(rscinfoVO);
	}

	@Override
	public List<RscinfoVO> findRsc(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.findRsc(rscinfoVO);
	}

	@Override
	public int rscinfoStc(RscinfoVO rscinfoVO) {
		return rscinfoMapper.rscinfoStc(rscinfoVO);
	}

}
