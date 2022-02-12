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
import solar.prcs2.service.SchedulerService;
import solar.sales.order.dao.ModifyVO;

@Controller
public class Prcs2Controller {

	@Autowired
	Prcs2Service pservice;
	@Autowired
	SchedulerService sservice;
	
	@RequestMapping("/prcs2/mng/prcsPr")
	public String prdtLotChasePage() {
		return "prcs2/mng/prcsPr";
	}

	@RequestMapping("/grid/scheduler.do")
	public String schedulerGrid(Model model, Prcs2 vo) {
		List<?> list = pservice.searchPlanList(vo);
		Map<String, Object> map = new HashMap();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}

	@RequestMapping("/ajax/insertWk.do")
	public String insertWk(Model model, Prcs2 vo) {
		pservice.insertData(vo);
		model.addAttribute("No", vo.getWkNo());
		sservice.register();
		return "jsonView";
	}

	@PostMapping("/grid/insertWkDetail.do")
	public String insertWkDetail(Model model, Prcs2 vo, @RequestBody ModifyVO<Prcs2> mvo) throws Exception {
		// pservice.insertDetail(mvo);
		pservice.insertDetailO(mvo);
		model.addAttribute("mode", "upd");
		return "jsonView";
	}

	// 시작버튼을 누르면 해당 지시번호에 해당하는 lot를 불러와서 list에 넣고 이를 토대로 돌아가는 스케줄러 작성
	@RequestMapping("/ajax/showGrid")
	public String showGrid(Model model, Prcs2 vo) {
		List<?> list = pservice.findTemp();
		Map<String, Object> map = new HashMap();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
	@RequestMapping("/ajax/scheduleEnd")
	public String scheduleEnd(Model model, Prcs2 vo) {
		sservice.remove();
		return "jsonView";
	}
	@RequestMapping("/modal/progIng")
	public String progIng(Model model, Prcs2 vo) {
		return "modal/progIng";
	}
	@RequestMapping("/grid/prdtIng.do")
	public String progIngGrid(Model model, Prcs2 vo) {
		List<?> list =pservice.prIng(vo);
		Map<String, Object> map = new HashMap();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}

	@RequestMapping("/ajax/repeat")
	public String repeat(Model model, Prcs2 vo) {
		int a = 0, b = 0, c = 0, d = 0, e = 0,f=0;
		List<Prcs2> list = pservice.repeat(vo);
		Map<String, Object> map = new HashMap();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getPrdtFg().equals("P")) {
				a++;
			} else if (list.get(i).getPrdtFg().equals("P1")) {
				b++;
			} else if (list.get(i).getPrdtFg().equals("P2")) {
				c++;
			} else if (list.get(i).getPrdtFg().equals("P3")) {
				d++;
			} else if (list.get(i).getPrdtFg().equals("C")) {
				e++;
			}else if (list.get(i).getPrdtFg().equals("F")) {
				f++;
			}
		}
		model.addAttribute("len",list.size() );
		model.addAttribute("p1", a);
		model.addAttribute("p2", b);
		model.addAttribute("p3", c);
		model.addAttribute("p4", d);
		model.addAttribute("p5", e);
		model.addAttribute("error", f);
		return "jsonView";
	}
}
