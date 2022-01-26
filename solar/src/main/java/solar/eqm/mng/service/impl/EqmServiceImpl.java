package solar.eqm.mng.service.impl;

import java.util.List;
import java.util.Map;

import javax.validation.ConstraintViolationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.eqm.mng.service.EqmService;
import solar.eqm.mng.service.EqmVO;
import solar.rsc.ordr.service.RscOrdr;
import solar.sales.order.dao.ModifyVO;

@Service 
public class EqmServiceImpl implements EqmService{
	
	@Autowired EqmMapper mapper;

	@Override
	public List<EqmVO> eqmList(Map map) {
		return mapper.eqmList(map);
	}

	@Override
	public String modifyData(ModifyVO<EqmVO> mvo) {
		String duplicatedEqmCds = "";
		if(mvo.getCreatedRows() != null	) {
			for(EqmVO eqmVo : mvo.getCreatedRows()) {
				System.out.println(eqmVo);
				try {
				mapper.insert(eqmVo);
				} catch (ConstraintViolationException e) {
					System.out.println(e);
					duplicatedEqmCds += ","+eqmVo.getEqmCd();
					return duplicatedEqmCds.substring(1);
				}
			}
		}
//		if(mvo.getUpdatedRows() != null	) {
//			
//		}
//		if(mvo.getDeletedRows() != null	) {
//			
//		}
		
		return "eqm?true";
	}

}
