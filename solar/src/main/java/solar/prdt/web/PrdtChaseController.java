package solar.prdt.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PrdtChaseController {


	@RequestMapping("/prdt/ref/prdtLotChase")
	public String prdtLotChasePage() {
		return "prdt/ref/prdtLotChase";
	}
}
