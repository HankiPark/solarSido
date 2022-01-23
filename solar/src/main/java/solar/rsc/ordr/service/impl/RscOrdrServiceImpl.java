	package solar.rsc.ordr.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.rsc.ordr.service.RscOrdr;
import solar.rsc.ordr.service.RscOrdrService;
import solar.rsc.rt.service.impl.RscRtMapper;
import solar.sales.order.dao.ModifyVO;

@Service
public class RscOrdrServiceImpl implements RscOrdrService {

	@Autowired
	RscOrdrMapper rscOrdrMapper;
	@Autowired
	RscRtMapper rscRtMapper;
	
	
	@Override
	public List<RscOrdr> search(Map map) {
		return rscOrdrMapper.search(map);
	}

	@Override
	public void modify(ModifyVO<RscOrdr> mvo) {
		System.out.println("@@@@modify");
		
		if(mvo.getCreatedRows() != null) {
			System.out.println(mvo.getCreatedRows());
			
			for(RscOrdr rscOrdr : mvo.getCreatedRows()) {
				System.out.println(rscOrdr);
				rscOrdrMapper.insert(rscOrdr);
			}
		}
		
		if(mvo.getUpdatedRows() != null) {
			System.out.println(mvo.getUpdatedRows());
			
			for(RscOrdr rscOrdr : mvo.getUpdatedRows()) {
				rscOrdrMapper.update(rscOrdr);
				
				if(rscOrdr.getInspCls().equals("rs002") && !rscOrdr.getRscInferQty().equals("0")) {
					Map<Object,Object> map = new HashMap<Object, Object>();
					map.put("rtngdResnCd", rscOrdr.getRtngdResnCd());
					map.put("ordrCd", rscOrdr.getOrdrCd());
					map.put("rscCd", rscOrdr.getRscCd());
					map.put("ordrDt", rscOrdr.getOrdrDt());
					rscRtMapper.insert(map);
				}
			}
		}
		if(mvo.getDeletedRows() != null) {
			System.out.println(mvo.getDeletedRows());
			
			for(RscOrdr rscOrdr : mvo.getDeletedRows()) {
				System.out.println(rscOrdr);
				rscOrdrMapper.delete(rscOrdr);
			}
		}
	}
}