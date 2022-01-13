package solar.cmm.emp.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.cmm.emp.dao.EmpVO;
import solar.cmm.emp.service.EmpService;
import solar.cmm.emp.service.impl.EmpMapper;

@Controller
public class EmpController {

	@Autowired EmpService empService;
	@Autowired EmpMapper empMapper;
	
	@RequestMapping("common/emp")
	public String empList() {
		return "common/emp";
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
	
}
