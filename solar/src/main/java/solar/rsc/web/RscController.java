package solar.rsc.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import solar.rsc.cmmn.service.RscService;
import solar.rsc.infer.service.RscInferService;
import solar.rsc.ordr.service.RscOrdrService;

@Controller
public class RscController {

	@Autowired
	RscOrdrService rscOrdrService;
	@Autowired
	RscService rscService;
	@Autowired
	RscInferService rscInferService;

	@GetMapping("rsc/ordr")
	public String rscOrdr() {
		return "rsc/ordr";
	}

	@GetMapping("rsc/ordrData")
	public String rscOrdrData(@RequestParam Map<String,String> map, Model model) {
		model.addAttribute("rscOrdr", rscOrdrService.search(map));
		System.out.println(map.get("isNotInspected"));
		return "jsonView";
	}

	@GetMapping("co")
	public String getCo() {
		return "modal/searchCo";
	}
	
	@GetMapping("rsc")
	public String rsc() {
		return "modal/searchRsc";
	}
	
	@GetMapping("rsc/rscData")
	public String rscData(Model model) {
		model.addAttribute("rsc",rscService.selectAll());
		return "jsonView";
	}
	
	@GetMapping("rsc/insp")
	public String rscInsp() {
		return "rsc/insp";
	}
	
	@GetMapping("rsc/inspData")
	public String rscInspData(/*@RequestParam Map<String,String> map, */Model model) {
		Map<String,Object> data = new HashMap<String, Object>();
		Map<String,Object> page = new HashMap<String, Object>();
		List<?> list = rscInferService.selectAll();
		
		model.addAttribute("result",true);
		
		page.put("page", 1);
		page.put("totalCount", list.size());
		
		data.put("contents", list);
		data.put("pagination", page);
		
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	@GetMapping("rsc/inspModal")
	public String rscInspModal() {
		return "modal/searchInsp";
	}
	
//	@PutMapping("rsc/ordrData")
//	public String rscOrdrData(ModifyVo<Rsc> mvo) {
//		rscOrdrService.update();
//		return "";
//	}

}