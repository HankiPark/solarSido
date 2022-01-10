package solar.sales.order.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import solar.sales.order.service.OrderService;
import twitter4j.Paging;

@RestController
@RequestMapping("/sales/")
public class OrderController {

	@Autowired OrderService oservice;
	
	@RequestMapping("main")
	public String orderList(Model model,Paging paging)
	{
		model.addAttribute("list", oservice.find());
		return "sales/main";
	}
	
}
