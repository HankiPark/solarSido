package solar.prod.plan.web;

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

import solar.prod.plan.service.ProdPlanService;
import solar.prod.plan.service.ProdPlanVO;
import solar.sales.order.dao.ModifyVO;

@Controller
public class ProdPlanController {

	 @Autowired ProdPlanService ppService;
	 
	 //생산계획관리 페이지이동
	 @RequestMapping("/prod/mng/prodPlanMng")
		public String planMng() {
			return "prod/mng/prodPlanMng";
		}
	 
	//생산계획조회 페이지이동
	 @RequestMapping("/prod/ref/prodPlanList")
		public String planList() {
			return "prod/ref/prodPlanList";
		}
	 
	//생산계획상세 조회 그리드
	@GetMapping("/grid/planGrid.do")
	public String planGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.selectPlan(ppVo);
		Map<String,Object> map = new HashMap<>();
		map.put("contents", list);	
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
	
	//자재재고 조회 그리드
	@GetMapping("/grid/rStcGrid.do")
	public String rStcGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.selectRstc(ppVo);
		Map<String,Object> map = new HashMap<>();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
	
	//modifyData
	@PostMapping("/grid/planModify.do")
	public String modifyPlan(Model model, ProdPlanVO ppVo, 
							@RequestBody ModifyVO<ProdPlanVO> mvo) throws Exception {
		ppService.modifyData(mvo);
		model.addAttribute("mode", "upd");
		return "jsonView";
	}
	
	//미생산계획서검색 모달
	@RequestMapping("/modal/findProdPlan")
	public String findProdPlan() {
		return "modal/findProdPlan";
	}
		
	//미생산계획서검색 모달그리드
	@GetMapping("/grid/findProdPlan.do")
	public String findProdPlanGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.findProdPlan(ppVo);
		Map<String, Object> map = new HashMap<>();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
		
	//생산계획서검색 - 계획상세조회
	@GetMapping("/grid/searchPlan.do")
	public String selectPlanGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.selectPlan(ppVo);
		model.addAttribute("data", list);
		return "jsonView";
	}
		
	//주문서검색 모달
	@RequestMapping("/modal/findOrder")
	public String findOrder() {
		return "modal/findOrder";
	}
	
	//주문서검색 모달그리드
	@GetMapping("/grid/findOrder.do")
	public String findOrderGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.findOrder(ppVo);
		Map<String, Object> map = new HashMap<>();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
	
	//주문서검색 - 계획상세조회
	@GetMapping("/grid/searchOrder.do")
	public String selectOrderGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.searchOrder(ppVo);
		model.addAttribute("data", list);
		return "jsonView";
	}

	//업체검색 모달
	@RequestMapping("/modal/findCoCd")
	public String findCoCd() {
		return "modal/findCoCd";
	}
	
	//업체검색 모달그리드
	@GetMapping("/grid/findCoCd.do")
	public String findCoCdGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.findCoCd(ppVo);
		Map<String, Object> map = new HashMap<>();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
	
	//제품검색 모달
	@RequestMapping("/modal/findPrdtCd")
	public String findPrdtCd() {
		return "modal/findPrdtCd";
	}
	
	//제품검색 모달그리드
	@GetMapping("/grid/findPrdtCd.do")
	public String findPrdtCdGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.findPrdtCd(ppVo);
		Map<String, Object> map = new HashMap<>();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
	
	//생산계획서검색 모달
	@RequestMapping("/modal/findPlanDetail")
	public String findPlanDetail() {
		return "modal/findPlanDetail";
	}
	
	//히든그리드 데이터 
	@PostMapping("/ajax/planModified.do")
	public String planDmndData(@RequestBody Map<String, List<ProdPlanVO>> map) {
		ppService.planDmndData(map);
		return "jsonView";
	}
}
