package solar.cmm.emp.web;

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

import solar.cmm.emp.dao.EmpVO;
import solar.cmm.emp.service.EmpService;
import solar.cmm.emp.service.impl.EmpMapper;
import solar.sales.order.dao.ModifyVO;

@Controller
public class EmpController {

	@Autowired EmpService empService;
	@Autowired EmpMapper empMapper;
	
	@RequestMapping("common/emp")
	public String empList() {
		return "common/mng/emp";
	}
	
	@GetMapping("/grid/empList.do")
	public String empList(Model model, EmpVO empVO) {
		List<?> empList = empService.empList(empVO);		
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		data.put("contents", empList);		
		model.addAttribute("result", true);
		model.addAttribute("data", data);
		
		return "jsonView";
	}
	
	@PostMapping("/grid/empModify.do")
	public String insertUpdate(Model model, EmpVO empVO, @RequestBody ModifyVO<EmpVO> modifyVO) throws Exception{
		empService.modifyData(modifyVO);
		model.addAttribute("mode", "upd");
		
		return "jsonView";
	}
	
	@GetMapping("/grid/empdataFind")
	public String cmmnfind(Model model, EmpVO empVO) throws Exception{
		
		List<?> empList = empService.empdataFind(empVO);
		model.addAttribute("result", true);
		Map<String, Object>map = new HashMap();
		Map<String, Object>map2 = new HashMap();
		map.put("contents", empList);
		map2.put("page", 1);
		map2.put("totalCount", empList.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
}
