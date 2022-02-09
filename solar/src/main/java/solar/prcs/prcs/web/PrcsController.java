package solar.prcs.prcs.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import solar.prcs.prcs.service.ClotVO;
import solar.prcs.prcs.service.IndicaVO;
import solar.prcs.prcs.service.PrcsEqmVO;
import solar.prcs.prcs.service.PrcsFlowVO;
import solar.prcs.prcs.service.PrcsPrMVO;
import solar.prcs.prcs.service.PrcsService;
import solar.prcs.prcs.service.PrdtStcVO;
import solar.prcs.prcs.service.RscConVO;
import solar.prcs.prcs.service.RsltVO;

@Controller
public class PrcsController {

	@Autowired PrcsService prcsservice;
	
	
	@RequestMapping("/prcs/mng/prcsprog")						// 공정관리 페이지 이동
	public String go() {
		return "prcs/mng/prcsprog";
	}
	
	/*------------------------------------------------------------------------------------------------ */
	// 생산지시검색 / 자재 / 제품 LOT 제외
	
	@RequestMapping("/modal/searchIndicaDetail")				// 생산지시상세 Modal 페이지 호출
	public String callIndicaModal() {
		return "modal/searchIndicaDetail";
	}
	
	@GetMapping("/modal/searchIndicaDetail/indica")				// 생산지시상세 Modal 페이지 데이터 호출
	public String insIndicaModal(IndicaVO vo, Model model) {
			
		Map<String, Object> map = new HashMap();
		System.out.println(vo.getSDate());
		map.put("contents", prcsservice.selectPDay(vo));
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	
	/*------------------------------------------------------------------------------------------------ */
	// LOT추적 테이블을 탐색해 최초 등록된 장비 가져오는 명령
		
	  @GetMapping("/prcs/prcsBasicItem")
	  public String getBasic(ClotVO vo, Model model) {
		  Map<String, Object> map = new HashMap();
		  map.put("contents", prcsservice.selectBasicItem(vo));
		  model.addAttribute("result", true);
		  model.addAttribute("data", map);
		  
		  return "jsonView";
		  
	  }
	
	
	  @GetMapping("/prcs/prcsItem") 
	  public String getItem(ClotVO vo, Model model) {
	  
	  Map<String, Object> map = new HashMap(); 
	  map.put("contents", prcsservice.selectPrcsItem(vo)); 
	  model.addAttribute("result", true);
	  model.addAttribute("data", map);
	  
	  return "jsonView"; 
	  }
	 
	// 상세지시 번호를 메인페이지로 가져올때 가져온 번호를 기준으로 등록된 소모자재테이블 조회
	  
	  @GetMapping("/prcs/prcsItemRsc")
	  public String getItemRsc(RscConVO vo, Model model) {  
		model.addAttribute("RSC", prcsservice.selectPrcsItemRSC(vo));	  
		return "jsonView";
	  }
	  
	  
	 
	/*------------------------------------------------------------------------------------------------ */
	// 설비검색 Modal 페이지 호출
		
	  @RequestMapping("/modal/searchPrcsEqm")
	  public String callPrcsEqmModal() {
		  return "modal/searchPrcsEqm";
	  }
	  
	  
	  
	  // 공정 검색 데이터 호출
	  @GetMapping("modal/searchPrcsEqm/prcs")
	  public String getPrcs(PrcsEqmVO vo, Model model) {
		
		  Map<String, Object> map = new HashMap();
		  map.put("contents", prcsservice.selectPrcs(vo));
		  model.addAttribute("result", true);
		  model.addAttribute("data", map);
		  
		  return "jsonView";
		  
	  }
	  
	  // 선택한 공정의 가동 순서에대한 가동정보를 리턴
	  @GetMapping("/prcs/searchPrcsFlow")
	  public String getPrcsFlow(PrcsFlowVO vo, Model model) {
		  model.addAttribute("PRCSFLOW", prcsservice.selectPrcsFlow(vo));
		  return "jsonView";
		  
	  }
	  
	  
	  // 선택한 공정이 몇개의 설비가 존재하는지 prcsCd를 조건으로 검색해서 데이터를 받아 리턴
	  @GetMapping("/prcs/searchPrcsEqmDetail")
	  public String getPrcsEqmDetail(PrcsEqmVO vo, Model model) {
		  model.addAttribute("PRCS", prcsservice.selectPrcsEqm(vo));
		return "jsonView";
	  }
	  
	  /*------------------------------------------------------------------------------------------------ */
	  // 공정 진입시 호출될 명령
	  
	  // 시작버튼 누를시 기본정보를 포함한 진행관리작업등록
	  @RequestMapping("prcs/insertPrcsPrM")
	  public String insertPrcsPrM(PrcsPrMVO vo, Model model) {
		  Map<String, Object> map = new HashMap();
		  
		  map.put("contents", prcsservice.insertPrcsPrM(vo));
		  model.addAttribute("result", true);
		  model.addAttribute("data", map);
		  
		  return "jsonView";
		  
	  }
	  
	  @RequestMapping("prcs/updateRscClot")
	  @ResponseBody
	  public int updateRscClot(ClotVO vo) {
		  return prcsservice.updateRscClot(vo);
	  }
	  
	  
	  @RequestMapping("prcs/insertRscClot")
	  public String insertRscClot(ClotVO vo, Model model) {
		  
		  Map<String, Object> map = new HashMap();
		  map.put("contents", prcsservice.insertRscClot(vo));
		  model.addAttribute("result", true);
		  model.addAttribute("data", map);
		  
		  return "jsonView";  
	  }
	  
	  @RequestMapping("prcs/insertPrdtStc")
	  public String insertPrdtStc(PrdtStcVO vo, Model model) {
		  Map<String, Object> map = new HashMap();
		  map.put("contents", prcsservice.insertPrdtStc(vo));
		  model.addAttribute("result", true);
		  model.addAttribute("data", map);
		  
		  return "jsonView";
		  
	  }
	  
	  
	  @RequestMapping("prcs/insertRslt")
	  public String insertRslt(RsltVO vo, Model model) {
		  Map<String, Object> map = new HashMap();
		  
		  map.put("contents", prcsservice.insertRslt(vo));
		  model.addAttribute("result", true);
		  model.addAttribute("data", map);
		  
		  return "jsonView";
	  }

	  
	  
}
