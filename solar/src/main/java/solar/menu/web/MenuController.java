package solar.menu.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.menu.dao.Menu;
import solar.menu.service.MenuService;

@Controller
public class MenuController {

	@Autowired MenuService service;
	
	@RequestMapping("/ajax/MenuList")
	public String menu(Model model, Menu menu) {
		model.addAttribute("menu",service.menuList(menu));
		return "jsonView";
	}
}
