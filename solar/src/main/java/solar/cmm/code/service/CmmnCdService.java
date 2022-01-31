package solar.cmm.code.service;

import java.util.List;
import java.util.Map;

public interface CmmnCdService {
	Map<String, List<Map>> select(List<String> cd);
	Map<String, List<Map>> selectCd(List<String> cd);
}
