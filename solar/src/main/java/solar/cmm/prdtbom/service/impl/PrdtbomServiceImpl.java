package solar.cmm.prdtbom.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.prdtbom.dao.PrdtbomVO;
import solar.cmm.prdtbom.service.PrdtbomService;
import solar.sales.order.dao.ModifyVO;

@Service
public class PrdtbomServiceImpl implements PrdtbomService{

	@Autowired PrdtbomMapper prdtbomMapper;
	
	@Override
	public List<PrdtbomVO> prdtbomList(PrdtbomVO prdtbomVO) {
		// TODO Auto-generated method stub
		return prdtbomMapper.prdtbomList(prdtbomVO);
	}

	@Override
	public List<PrdtbomVO> prdtbomFind(PrdtbomVO prdtbomVO) {
		// TODO Auto-generated method stub
		return prdtbomMapper.prdtbomFind(prdtbomVO);
	}

	@Override
	public int prdtbomInsert(PrdtbomVO prdtbomVO) {
		// TODO Auto-generated method stub
		return prdtbomMapper.prdtbomInsert(prdtbomVO);
	}

	@Override
	public int prdtbomUpdate(PrdtbomVO prdtbomVO) {
		// TODO Auto-generated method stub
		return prdtbomMapper.prdtbomUpdate(prdtbomVO);
	}

	@Override
	public int prdtbomDelete(PrdtbomVO prdtbomVO) {
		// TODO Auto-generated method stub
		return prdtbomMapper.prdtbomDelete(prdtbomVO);
	}

	@Override
	public int modifyData(ModifyVO<PrdtbomVO> modifyVO) {
		
		if(modifyVO.getCreatedRows()!=null) {
			for(PrdtbomVO prdtbomVO : modifyVO.getCreatedRows()) {
				prdtbomMapper.prdtbomList(prdtbomVO);
			}
		}
		if(modifyVO.getDeletedRows()!=null) {
			for(PrdtbomVO prdtbomVO : modifyVO.getDeletedRows()) {
				prdtbomMapper.prdtbomDelete(prdtbomVO);
			}
			if(modifyVO.getUpdatedRows()!=null) {
				for(PrdtbomVO prdtbomVO : modifyVO.getUpdatedRows()) {
					prdtbomMapper.prdtbomUpdate(prdtbomVO);
				}
			}	
	}
		
		return 1;
	}

	@Override
	public List<PrdtbomVO> prdtinfoFind(PrdtbomVO prdtvomVO) {
		// TODO Auto-generated method stub
		return prdtbomMapper.prdtinfoFind(prdtvomVO);
	}

	@Override
	public List<PrdtbomVO> prdtList(PrdtbomVO prdtbomVO) {
		// TODO Auto-generated method stub
		return prdtbomMapper.prdtList(prdtbomVO);
	}

	@Override
	public List<PrdtbomVO> prdtbomSearch(PrdtbomVO prdtbomVO) {
		List<PrdtbomVO> l1 = null;
		try {
			l1 = prdtbomMapper.prdtbomSearch(prdtbomVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return l1;
	}
	
}
