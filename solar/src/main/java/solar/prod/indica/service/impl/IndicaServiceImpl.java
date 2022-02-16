package solar.prod.indica.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.prod.indica.service.IndicaService;
import solar.prod.indica.service.IndicaVO;
import solar.prod.plan.service.ProdPlanVO;
import solar.sales.order.dao.ModifyVO;

@Service
public class IndicaServiceImpl implements IndicaService {
	
	@Autowired IndicaMapper idcMapper;

	@Override
	public List<?> selectIdc(IndicaVO idcVo) {
		return idcMapper.selectIdc(idcVo);
	}

	@Override
	public List<?> findIndica(IndicaVO idcVo) {
		return idcMapper.findIndica(idcVo);
	}

	@Override
	public List<?> selectRscList(IndicaVO idcVo) {
		return idcMapper.selectRscList(idcVo);
	}

	@Override
	public List<?> selectRscLot(IndicaVO idcVo) {
		return idcMapper.selectRscLot(idcVo);
	}

	@Override
	public List<?> noIndicaPlan(ProdPlanVO ppVo) {
		return idcMapper.noIndicaPlan(ppVo);
	}

	@Override
	public String makeDno() {
		return idcMapper.makeDno();
	}
	
	@Override
	public List<?> findEqmUo(IndicaVO idcVo) {
		return idcMapper.findEqmUo(idcVo);
	}

	@Override
	public String makePrdtNo() {
		return idcMapper.makePrdtNo();
	}

	@Override
	public List<?> rscCnt(CmmndataVO cVo) {
		return idcMapper.rscCnt(cVo);
	}

	@Override
	   public int hiddenData(Map<String, List<IndicaVO>> map) {
	    if(map.get("idcDadd") != null ) {
	    	 for(IndicaVO idcVo : map.get("idcDadd")) {
		            if (idcVo == map.get("idcDadd").get(0)) {
		               idcMapper.insertIndica(idcVo);
		            	System.out.println("IDCadd");
		               }
		           idcMapper.insertIndicaD(idcVo);
		    	 }
		    }
		if(map.get("idcD") !=null) {
	       //  IndicaVO idcVo = new IndicaVO();
	         for(IndicaVO idcVo : map.get("idcD")) {
	            if (idcVo == map.get("idcD").get(0)) {
	               idcMapper.insertIndica(idcVo);
	            	System.out.println("IDC");
	               }
	            idcMapper.insertIndicaD(idcVo);
	            idcMapper.updateOdIdQty(idcVo);
	            System.out.println("IDCOR");
	         }
	      }
	      if(map.get("rscCon") !=null) {
	         for(IndicaVO idcVo : map.get("rscCon")) {
	            idcMapper.insertRscCon(idcVo);
	            idcMapper.insertRscOut(idcVo);
	            idcMapper.updateUseRscStc(idcVo);
	        	 System.out.println("RSC");
	         }      
	      }
	      
	      if(map.get("prdtRsc") !=null) {
	    	 int k=0;
	         int cnt =idcMapper.bomRscCnt(map.get("prdtRsc").get(0).getPrdtCd());
	         int prdtCnt =map.get("prdtRsc").size();
	         for(IndicaVO idcVo : map.get("prdtRsc")) {
	           //idcMapper.insertPdRc(idcVo);
	         }
	         for(int i=0;i<prdtCnt/cnt+k;i++) {
	        	 if(i!=0) {
	        		 IndicaVO idcVo2 =map.get("prdtRsc").get(i-1);
	 	            IndicaVO idcVo = map.get("prdtRsc").get(i);
	 	            if(idcVo2.getPrdtLot().equals(idcVo.getPrdtLot())) {
	 	            	k++;
	 	            }else {
		            idcMapper.insertPdSc(idcVo); 
	 	            }
	        	 }else {
	 	            IndicaVO idcVo = map.get("prdtRsc").get(i);
		            idcMapper.insertPdSc(idcVo);   
	        	 } 
	         }
	         System.out.println("데이터insert끝");
	      }
	      return 1;
	   }
	
	@Override
	public int modifyData(ModifyVO<IndicaVO> mvo) {
		if(mvo.getCreatedRows()!=null) {
			for(IndicaVO idcVo : mvo.getCreatedRows()) {
				if (idcVo == mvo.getUpdatedRows().get(0)) {
					//idcMapper.insertIndica(idcVo);
					}
				//idcMapper.insertIndicaD(idcVo);
				}
			}
		if(mvo.getDeletedRows()!=null) {
			for(IndicaVO idcVo : mvo.getDeletedRows()) {
				//idcMapper.deleteIndicaD(idcVo);
				}
			}
		if(mvo.getUpdatedRows()!=null) {
				if (mvo.getUpdatedRows().get(0).getIndicaNo() != null) {
					for(IndicaVO idcVo : mvo.getUpdatedRows()) {
					//idcMapper.updateIndica(idcVo);
					//idcMapper.updateIndicaD(idcVo);
					}
				} else {
					for(IndicaVO idcVo : mvo.getUpdatedRows()) {
						if (idcVo == mvo.getUpdatedRows().get(0)) {
							//idcMapper.insertIndica(idcVo);
						}
						//idcMapper.insertIndicaD(idcVo);
						//idcMapper.updateOdIdQty(idcVo);
					}
				}
			}
		return 1;
	}

}
