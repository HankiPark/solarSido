package solar.prcs.clot.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import solar.prcs.clot.service.ClotService;


@RestController
@RequestMapping("/prcs")
public class ClotController {

	@Autowired
	ClotService clotservice;

	@RequestMapping("/clot")
	public String find(Model model) {
		model.addAttribute("clot", clotservice.SelectAll());
		return "jsonView";
		
	}
	
	
	
}
