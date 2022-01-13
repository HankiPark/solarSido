package solar.sales.order.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.cmmndata.service.CmmndataService;
import solar.sales.order.dao.Order;
import solar.sales.order.service.OrderService;

@Controller
public class OrderController {

	@Autowired
	OrderService oservice;
	@Autowired CmmndataService cmmndataService;
	
	@RequestMapping("/sales/order")
	public String orderList(Model model, Order order) {

		  CmmndataVO cmVo = new CmmndataVO(); cmVo.setCmmnCdId("prod");
		  System.out.println(cmVo); List<CmmndataVO> list
		  =(List<CmmndataVO>)cmmndataService.cmmndataDetailList(cmVo);
		  System.out.println(list); Order n =new Order(); for(int
		  i=0;i<list.size();i++) { n.setPrdtCd((list.get(i).getCmmnCdDetaId())) ;
		  oservice.inStcUpdate(n) ;
		  }	
		  
		return "sales/order";
	}

	@GetMapping("/grid/orderList.do")

	public String orderListGrid(Model model, Order order) throws Exception {
		List<?> list = oservice.find(order);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page", 1);
		map2.put("totalCount", list.size());

		model.addAttribute("data", map);
		model.addAttribute("pagination", map2);
		return "jsonView";
	}

	@GetMapping("/modal/orderDetailList")
	public String orderDetailList(Model model, Order order) throws Exception {
		

		 

		return "modal/orderDetailList";
	}

	@GetMapping("/grid/orderDetailList.do")
	public String orderDetailListGrid(Model model, Order order) throws Exception {
		
		/*
		 * List<Order> list2 = oservice.findDetail(order); for(Order n : list2) {
		 * oservice.inStcUpdate(n); }
		 */
		List<Order> list = oservice.findDetail(order);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page", 1);
		map2.put("totalCount", list.size());
		model.addAttribute("data", map);

		return "jsonView";
	}
}
