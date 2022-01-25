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
	 @RequestMapping("/prod/prodPlanMng")
		public String planMng() {
			return "prod/prodPlanMng";
		}
	 
	//생산계획조회 페이지이동
	 @RequestMapping("/prod/prodPlanList")
		public String planList() {
			return "prod/prodPlanList";
		}
	 
	//생산계획상세 조회 그리드
	@GetMapping("/grid/planGrid.do")
	public String planGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.selectPlan(ppVo);
		Map<String,Object> map = new HashMap<>();
		map.put("contents", list);	
		System.out.println("list:"+list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		System.out.println("map:" + map);
		return "jsonView";
	}
	
	//제품재고 조회 그리드
	@GetMapping("/grid/pStcGrid.do")
	public String pStcGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.selectPstc(ppVo);
		Map<String,Object> map = new HashMap<>();
		map.put("contents", list);
		System.out.println("list:"+list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		System.out.println("map:" + map);
		return "jsonView";
	}
	
	//자재재고 조회 그리드
	@GetMapping("/grid/rStcGrid.do")
	public String rStcGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.selectRstc(ppVo);
		Map<String,Object> map = new HashMap<>();
		map.put("contents", list);
		System.out.println("list:"+list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		System.out.println("map:" + map);
		return "jsonView";
	}
	
	//modifyData
	@PostMapping("/grid/planModify.do")
	public String modifyPlan(Model model, ProdPlanVO ppVo, 
							@RequestBody ModifyVO<ProdPlanVO> mvo) throws Exception {
		ppService.modifyData(mvo);
//		System.out.println("mvo:" + ppService.modifyData(mvo)); //절대 실행하지 말 것 변수에 담아서 할것
		model.addAttribute("mode", "upd");
		return "jsonView";
	}
	
	//생산계획서검색 모달
	@RequestMapping("/modal/findProdPlan")
	public String findProdPlan() {
		return "modal/findProdPlan";
	}
		
	//생산계획서검색 모달그리드
	@GetMapping("/grid/findProdPlan.do")
	public String findProdPlanGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> list = ppService.findProdPlan(ppVo);
		Map<String, Object> map = new HashMap<>();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		System.out.println("map:" + map);
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
		System.out.println("map:" + map);
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
		System.out.println("map:" + map);
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
		System.out.println("map:" + map);
		return "jsonView";
	}
	
}
