package solar.prcs.prcs.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.prcs.prcs.service.PrcsService;

@Controller
@RequestMapping("/prcs")
public class PrcsController {

	@Autowired PrcsService prcsservice;
	
	
	@RequestMapping("/prog")
	public String go() {
		return "prcs/prcsprog";
	}
	
	
	@GetMapping
	public String find(Model model) {
		
		model.addAttribute("prcs", prcsservice.SelectAll());
		
		return "JsonView";
		
	}
	
	
	
}
