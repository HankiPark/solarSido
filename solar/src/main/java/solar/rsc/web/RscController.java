package solar.rsc.web;

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
	public String rscInspData(@RequestParam Map<String,String> map, Model model) {
		model.addAttribute("insp",rscInferService.selectAll());
		return "jsonView";
	}
	
	@GetMapping("rsc/inspModal")
	public String rscInspModal() {
		return "modal/searchInsp";
	}

}