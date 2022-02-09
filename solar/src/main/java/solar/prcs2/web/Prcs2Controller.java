package solar.prcs2.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.prcs2.dao.Prcs2;
import solar.prcs2.service.Prcs2Service;
import solar.sales.order.dao.ModifyVO;

@Controller
public class Prcs2Controller {

	@Autowired Prcs2Service pservice;
	
	@RequestMapping("/prcs2/mng/prcsPr")
	public String prdtLotChasePage() {
		return "prcs2/mng/prcsPr";
	}
	@RequestMapping("/grid/scheduler.do")
	public String schedulerGrid(Model model,Prcs2 vo) {
		List<?> list = pservice.searchPlanList(vo);
		Map<String, Object> map = new HashMap();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
	@RequestMapping("/ajax/insertWk.do")
	public String insertWk(Model model,Prcs2 vo) {
		pservice.insertData(vo);
		model.addAttribute("No", vo.getWkNo());
		return "jsonView";
	}
	@PostMapping("/grid/insertWkDetail.do")
	public String insertWkDetail(Model model,Prcs2 vo,@RequestBody ModifyVO<Prcs2> mvo)throws Exception  {
		//pservice.insertDetail(mvo);
		pservice.insertDetailO(mvo);
		model.addAttribute("mode", "upd");
		return "jsonView";
	}
	
	//시작버튼을 누르면 해당 지시번호에 해당하는 lot를 불러와서 list에 넣고 이를 토대로 돌아가는 스케줄러 작성
	@RequestMapping("/ajax/showGrid")
	public String showGrid(Model model,Prcs2 vo) {
		List<?> list = pservice.findTemp();
		Map<String, Object> map = new HashMap();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
	
}
