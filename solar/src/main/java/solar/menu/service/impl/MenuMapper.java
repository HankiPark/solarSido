package solar.menu.service.impl;

import java.util.List;

import solar.menu.dao.Menu;

public interface MenuMapper {
	List<Menu> menuList(Menu vo);
}
