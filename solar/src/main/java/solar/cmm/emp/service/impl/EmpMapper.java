package solar.cmm.emp.service.impl;

import java.util.List;

import solar.cmm.emp.dao.EmpVO;
import solar.sales.order.dao.ModifyVO;

public interface EmpMapper {
	List<EmpVO> empList(EmpVO empVO);
	public EmpVO findById(String no);
	public int empInsert(EmpVO empVO);
	public int empUpdate(EmpVO empVO);
	public int empDelete(EmpVO empVO);
	public int modifyData(ModifyVO<EmpVO> modifyVO);
}
