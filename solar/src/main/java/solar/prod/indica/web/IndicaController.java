package solar.prod.indica.web;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.code.service.CmmnCdService;
import solar.prod.indica.service.IndicaService;
import solar.prod.indica.service.IndicaVO;
import solar.prod.plan.service.ProdPlanVO;
import solar.sales.order.dao.ModifyVO;

@Controller
public class IndicaController {
	
	@Autowired IndicaService idcService;
	@Autowired CmmnCdService cmmnCdService;
	
	//생산지시관리 페이지이동
	 @RequestMapping("/prod/mng/indicaMng")
		public String indMng() {
			return "prod/mng/indicaMng";
		}
	 
	//생산지시조회 페이지이동
	 @RequestMapping("/prod/ref/indicaList")
		public String indList() {
			return "prod/ref/indicaList";
		}
	
	//생산지시상세 조회그리드
	@GetMapping("/grid/indicaGrid.do")
	public String indicaGrid(Model model, IndicaVO idcVo) throws Exception {
		List<?> list = idcService.selectIdc(idcVo);
		Map<String,Object> map = new HashMap<>();
		map.put("contents", list);
		System.out.println("list:"+list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		System.out.println("map:" + map);
		return "jsonView";
		}
	
	//지시조회버튼: 생산지시서검색 모달
	@RequestMapping("/modal/findIndica")
	public String findIndica() {
		System.out.println("생산지시서검색 모달호출");
		return "modal/findIndica";
	}
		
	//생산지시서검색 모달그리드
	@GetMapping("/grid/findIndica.do")
	public String findIndicaGrid(Model model, IndicaVO idcVo) throws Exception {
		List<?> list = idcService.findIndica(idcVo);
		Map<String, Object> map = new HashMap<>();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		System.out.println("map:" + map);
		return "jsonView";
	}
	
	//계획조회 버튼: 미지시 계획검색 모달
	@RequestMapping("/modal/findPlanDlist")
	public String findPlanDlist() {
		System.out.println("미지시 계획검색 모달호출");
		return "modal/findPlanDlist";
	}
	
	//미지시 생산계획상세 조회 그리드
	@GetMapping("/grid/noIndicaGrid.do")
	public String planGrid(Model model, ProdPlanVO ppVo) throws Exception {
		System.out.println("미지시 생산계획 호출");
		List<?> list = idcService.noIndicaPlan(ppVo);
		Map<String,Object> map = new HashMap<>();
		map.put("contents", list);	
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		System.out.println("map:" + map);
		return "jsonView";
	}
		
	//생산지시서검색 - 지시상세조회
	@GetMapping("/grid/searchIndica.do")
	public String selectIndicaGrid(Model model, IndicaVO idcVo) throws Exception {
		List<?> list = idcService.selectIdc(idcVo);
		model.addAttribute("data", list);
		return "jsonView";
	}
	
	//제품별 소요 자재 목록 그리드
	@GetMapping("/grid/rscGrid.do")
	public String rscGrid(Model model, IndicaVO idcVo) throws Exception {
		List<?> list = idcService.selectRscList(idcVo);
		Map<String, Object> map = new HashMap<>();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		System.out.println("map:" + map);
		return "jsonView";
	}
	
	//소요 자재 lot 목록 그리드
	@GetMapping("/grid/rscLotGrid.do")
	public String rscLotGrid(Model model, IndicaVO idcVo) throws Exception {
		List<?> list = idcService.selectRscLot(idcVo);
		Map<String, Object> map = new HashMap<>();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		System.out.println("map:" + map);
		return "jsonView";
	}
	
	//생산지시서검색 모달
	@RequestMapping("/modal/findIndicaDetail")
	public String findIndicaDetail() {
		System.out.println("생산지시서 조회");
		return "modal/findIndicaDetail";
	}
	
	//지시상세번호 부여
	@GetMapping("/ajax/makeDno.do")
	public String makeDno(Model model, IndicaVO idcVo) {
		model.addAttribute("num2", idcService.makeDno());
		return "jsonView";
	}
	
	//제품lot 시퀀스
	@GetMapping("/ajax/makePrdtNo.do")
	public String makePrdtNo(Model model, IndicaVO idcVo) {
		model.addAttribute("num", idcService.makePrdtNo());
		return "jsonView";
	}
	
	//자재수 가지고 오는 ajax
	@GetMapping("/ajax/rscCnt.do")
	public String rscCnt(Model model, CmmndataVO cVo) {
		model.addAttribute("num", idcService.rscCnt(cVo));
		return "jsonView";
	}
		
	//modifyData
	@PostMapping("/grid/indicaModify.do")
	public String modifyPlan(Model model, IndicaVO idcVo, 
							@RequestBody ModifyVO<IndicaVO> mvo) throws Exception {
		idcService.modifyData(mvo);
		model.addAttribute("mode", "upd");
		return "jsonView";
	}
	
	//공통-제품코드 목록 요청
	@GetMapping("/ajax/cmmn/code")
	public String cmmnCodes(Model model) {
		model.addAttribute("codes", cmmnCdService.selectCd(Arrays.asList("prod")));
		return "jsonView";
	}
	
	//히든그리드 데이터
	@PostMapping("/ajax/modified.do")
	public String hiddenData(@RequestBody Map<String, List<IndicaVO>> map) {
		System.out.println("히든그리드데이터" + map);
		idcService.hiddenData(map);
		return "jsonView";
	}
}
