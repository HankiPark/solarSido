package solar.eqm.mng.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import solar.eqm.mng.service.EqmService;
import solar.eqm.mng.service.EqmVO;

@Controller
public class EqmController {
	
	@Autowired EqmService eqmService;
	
	//설비관리페이지 이동
	@RequestMapping("/eqm/eqmMng")
	public String eqmList(Model model, EqmVO vo) {
		return "eqm/eqmMng";
	}
	
	//설비목록
	@GetMapping("/grid/eqmList.do")
	public String eqmListGrid(Model model, EqmVO vo) throws Exception {
		List<?> eqmList = eqmService.eqmList(vo);
    	
    	Map<String,Object> data = new HashMap<>();
		data.put("contents", eqmList);
		
		Map<String,Object> map = new HashMap<>();
		model.addAttribute("result", true);
		
		model.addAttribute("data", data);
		return "jsonView";
	}
}
