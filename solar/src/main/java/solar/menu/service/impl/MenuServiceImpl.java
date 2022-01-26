package solar.menu.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.menu.dao.Menu;
import solar.menu.service.MenuService;
@Service
public class MenuServiceImpl implements MenuService{

	@Autowired MenuMapper mapper;
	
	@Override
	public List<Menu> menuList(Menu vo) {
		return mapper.menuList(vo);
	}

}
