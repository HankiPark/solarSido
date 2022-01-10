package solar.rsc.cmmn.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import solar.rsc.ordr.service.RscOrdrService;

@Controller
public class RscController {

	@Autowired
	RscOrdrService rscOrdrService;
	
	@GetMapping("rsc/ordr")
	public String rscOrdr() {
		return "rsc/ordr";
	}
	
	@GetMapping("rsc/ordrData")	
	public String rscOrdrData(@RequestParam(value = "ordrDtStt",required = false) String ordrDtStt,
							  @RequestParam(value = "ordrDtEnd",required = false) String ordrDtEnd,
							  @RequestParam(value = "co",required = false) String co,
							  @RequestParam(value = "rsc",required = false) String rsc,
							  Model model) {
		System.out.println(ordrDtStt);
		System.out.println(ordrDtEnd);
		System.out.println(co);
		System.out.println(rsc);
		model.addAttribute("rscOrdr",rscOrdrService.selectAll());
		return "jsonView";
	}
}