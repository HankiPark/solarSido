package solar.sales.inout.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.sales.inout.dao.Prdt;
import solar.sales.inout.service.PrdtService;

@Controller
public class PrdtController {

	@Autowired PrdtService pservice;
	
	@RequestMapping("/sales/prdt_inout_mng")
	public String prdtPage() {
		return "sales/prdt_inout_mng";
	}
	
	@RequestMapping("/grid/prdtInput.do")
	public String prdtList(Model model,Prdt prdt) throws Exception{
		
		
		
		return "jsonView";
	}
}
