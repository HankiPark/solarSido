package solar.sales.order.web;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.sales.order.dao.Order;
import solar.sales.order.service.OrderService;
import twitter4j.Paging;

@Controller
public class OrderController {

	@Autowired OrderService oservice;
	
	@RequestMapping("/sales/main")
	public String orderList(Model model,Paging paging)
	{
		
		return "sales/main";
	}
	@GetMapping("/grid/orderList.do")

	public String orderListGrid(Model model,Order order) throws Exception
	{	
		model.addAttribute("result",true);
		Map<String,Object> map = new HashMap();
		map.put("contents", oservice.find(order));
		model.addAttribute("data", map);

    return "jsonView";
	}	
	@GetMapping("/modal/orderDetailList")
	public String orderDetailList(Model model,Order order) throws Exception
	{
		
		return "modal/orderDetailList";
	}


	@GetMapping("/grid/orderDetailList.do")
	public String orderDetailListGrid(Model model,Order order) throws Exception
	{
		model.addAttribute("result",true);
		Map<String,Object> map = new HashMap();
		map.put("contents", oservice.findDetail(order));
		model.addAttribute("data", map);
		
		return "jsonView";
	}
}
