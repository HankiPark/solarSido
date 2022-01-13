package solar.sales.inout.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.sales.inout.dao.Prdt;
import solar.sales.inout.service.PrdtService;
import solar.sales.order.dao.ModifyVO;

@Controller
public class PrdtController {

	@Autowired PrdtService pservice;
	
	@RequestMapping("/sales/prdt_inout_mng")
	public String prdtPage() {
		return "sales/prdt_inout_mng";
	}
	
	@RequestMapping("/grid/prdtInput.do")
	public String prdtList(Model model,Prdt prdt) throws Exception{
		List<?> list= pservice.findList(prdt);
		Map<String,Object> map = new HashMap();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		
		
		return "jsonView";
	}
	
	@RequestMapping("/modal/prdtNmList")
	public String prdtNmList(Model model,Prdt prdt) throws Exception{
		return "modal/prdtNmList";
	}
	@RequestMapping("/modal/prdtInWaitList")
	public String prdtInWait(Model model,Prdt prdt) throws Exception{
		return "modal/prdtInWaitList";
	}
	
	
	@GetMapping("/grid/prdtNmList.do")
	public String orderDetailListGrid(Model model,Prdt prdt) throws Exception
	{	List<?> list=pservice.findPrdt(prdt);
		model.addAttribute("result",true);
		Map<String,Object> map = new HashMap();
		Map<String,Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page",1);
		map2.put("totalCount", list.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	
	@PostMapping("/grid/prdtInputUpdate.do")
	public String insertInput(Model model,Prdt prdt,@RequestBody ModifyVO<Prdt> mvo) throws Exception
	{	
		System.out.println(mvo);
		pservice.modifyData(mvo);
		model.addAttribute("mode","upd");
		
		return "jsonView";
		
	}
	
}
