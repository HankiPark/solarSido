package solar.co.cmmn.service;

import lombok.Data;

@Data
public class Co {
	String coCd;
	String coNm;
	String bizno;
	String coPhone;
	String coFg;
	public String getCoCd() {
		return coCd;
	}
	public void setCoCd(String coCd) {
		this.coCd = coCd;
	}
	public String getCoNm() {
		return coNm;
	}
	public void setCoNm(String coNm) {
		this.coNm = coNm;
	}
	public String getBizno() {
		return bizno;
	}
	public void setBizno(String bizno) {
		this.bizno = bizno;
	}
	public String getCoPhone() {
		return coPhone;
	}
	public void setCoPhone(String coPhone) {
		this.coPhone = coPhone;
	}
	public String getCoFg() {
		return coFg;
	}
	public void setCoFg(String coFg) {
		this.coFg = coFg;
	}
	@Override
	public String toString() {
		return "Co [coCd=" + coCd + ", coNm=" + coNm + ", bizno=" + bizno + ", coPhone=" + coPhone + ", coFg=" + coFg
				+ "]";
	}
	
}
