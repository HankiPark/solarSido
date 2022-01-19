package solar.co.cmmn.service.impl;

import java.util.List;
import java.util.Map;

import solar.co.cmmn.service.Co;

public interface CoMapper {
	List<Co> selectAll();
	List<Co> search(Map map);
}
