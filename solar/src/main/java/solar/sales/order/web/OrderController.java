package solar.sales.order.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.cmm.cmmndata.service.CmmndataService;
import solar.sales.order.dao.CalendarVO;
import solar.sales.order.dao.Order;
import solar.sales.order.service.OrderService;

@Controller
public class OrderController {

	@Autowired
	OrderService oservice;
	@Autowired CmmndataService cmmndataService;
	

	
	@RequestMapping("/sales/ref/order")
	public String orderList(Model model, Order order) {
		return "sales/ref/order";
	}
	@RequestMapping("/sales/ref/prodCalendar")
	public String prodCalendar(Model model) {
		return "sales/ref/prodCalendar";
	}
	@RequestMapping("/sales/ref/rscCalendar")
	public String rscCalendar(Model model) {
		return "sales/ref/rscCalendar";
	}
	@RequestMapping("/sales/ref/eqmCalendar")
	public String eqmCalendar(Model model) {
		return "sales/ref/eqmCalendar";
	}
	@RequestMapping("/sales/ref/saleCalendar")
	public String saleCalendar(Model model) {
		return "sales/ref/saleCalendar";
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
	
	//영업 캘린더 시작
	@GetMapping("/ajax/orderCal")
	public String orderCal(Model model) throws Exception {
		List<CalendarVO> list = oservice.orderCal();
		model.addAttribute("events", list);
		
		return "jsonView";
	}
	@GetMapping("/ajax/orderEndCal")
	public String orderEndCal(Model model) throws Exception {
		List<CalendarVO> list = oservice.orderEndCal();
		model.addAttribute("events", list);
		
		return "jsonView";
	}
	@GetMapping("/ajax/inPrdtCal")
	public String inPrdtCal(Model model) throws Exception {
		List<CalendarVO> list = oservice.inPrdtCal();
		model.addAttribute("events", list);
		
		return "jsonView";
	}
	@GetMapping("/ajax/outPrdtCal")
	public String outPrdtCal(Model model) throws Exception {
		List<CalendarVO> list = oservice.outPrdtCal();
		model.addAttribute("events", list);
		
		return "jsonView";
	}
	//영업 캘린더 끝
	
	//자재 캘린더 시작
	@GetMapping("/ajax/rscCal")
	public String rscCal(Model model) throws Exception {
		List<CalendarVO> list = oservice.rscCal();
		model.addAttribute("events", list);
		
		return "jsonView";
	}
	
	//자재 캘린더 끝
	
	//영업 캘린더 시작
	@GetMapping("/ajax/prodCal")
	public String prodCal(Model model) throws Exception {
		List<CalendarVO> list = oservice.prodCal();
		model.addAttribute("events", list);
		
		return "jsonView";
	}
	//영업 캘린더 끝
	//설비 캘린더 시작
	@GetMapping("/ajax/eqmCal")
	public String eqmCal(Model model) throws Exception {
		List<CalendarVO> list = oservice.eqmCal();
		model.addAttribute("events", list);
		
		return "jsonView";
	}
	@GetMapping("/ajax/eqmEndCal")
	public String eqmEndCal(Model model) throws Exception {
		List<CalendarVO> list = oservice.eqmEndCal();
		model.addAttribute("events", list);
		
		return "jsonView";
	}

}
