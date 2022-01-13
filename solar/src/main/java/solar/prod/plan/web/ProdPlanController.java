package solar.prod.plan.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.prod.plan.service.ProdPlanService;

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
}
