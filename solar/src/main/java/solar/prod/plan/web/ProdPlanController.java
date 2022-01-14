package solar.prod.plan.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.prod.plan.service.ProdPlanService;
import solar.prod.plan.service.ProdPlanVO;

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
	 
	//생산지시관리 페이지이동
	 @RequestMapping("/prod/indicaMng")
		public String indMng() {
			return "prod/indicaMng";
		}
	 
	//생산지시조회 페이지이동
	 @RequestMapping("/prod/indicaList")
		public String indList() {
			return "prod/indicaList";
		}
	 
	//생산계획 조회
	@GetMapping("/grid/planGrid.do")
	public String planGrid(Model model, ProdPlanVO ppVo) throws Exception {
		List<?> pPlanList = ppService.selectPlan(ppVo);
		Map<String,Object> data = new HashMap<>();
		data.put("contents", pPlanList);
		model.addAttribute("result", true);
		model.addAttribute("data", data);
		System.out.println(data);
		return "jsonView";
		}
}
