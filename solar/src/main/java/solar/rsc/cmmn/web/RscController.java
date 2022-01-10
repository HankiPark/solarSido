package solar.rsc.cmmn.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.rsc.ordr.service.RscOrdrService;
import solar.rsc.ordr.service.impl.RscOrdrMapper;

@Controller
public class RscController {

	@Autowired
	RscOrdrService rscOrdrService;
	
	@RequestMapping("rsc/ordr")
	public String rscOrdr(Model model) {
		model.addAttribute("rscOrdr",rscOrdrService.selectAll()); 
		return "rsc/ordr";
	}
}