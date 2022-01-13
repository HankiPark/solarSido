package solar.cmm.emp.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class EmpVO {
	String empId;
	String empPw;
	String empNm;
	String empNo;
	String dept;
	String wkdty;
	String phone;
	String email;
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	Date hireDate;
	
}
