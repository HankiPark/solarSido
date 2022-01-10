package solar.rsc.ordr.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
  
@Data
public class RscOrdr {
	String ordrCd;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date ordrDt;
	String rscCd;
	String ordrQty;
	String coCd;
	String rscIstQty;
	String rscInferQty;
	String inspCls;
	public String getOrdrCd() {
		return ordrCd;
	}
	public void setOrdrCd(String ordrCd) {
		this.ordrCd = ordrCd;
	}
	public Date getOrdrDt() {
		return ordrDt;
	}
	public void setOrdrDt(Date ordrDt) {
		this.ordrDt = ordrDt;
	}
	public String getRscCd() {
		return rscCd;
	}
	public void setRscCd(String rscCd) {
		this.rscCd = rscCd;
	}
	public String getOrdrQty() {
		return ordrQty;
	}
	public void setOrdrQty(String ordrQty) {
		this.ordrQty = ordrQty;
	}
	public String getCoCd() {
		return coCd;
	}
	public void setCoCd(String coCd) {
		this.coCd = coCd;
	}
	public String getRscIstQty() {
		return rscIstQty;
	}
	public void setRscIstQty(String rscIstQty) {
		this.rscIstQty = rscIstQty;
	}
	public String getRscInferQty() {
		return rscInferQty;
	}
	public void setRscInferQty(String rscInferQty) {
		this.rscInferQty = rscInferQty;
	}
	public String getInspCls() {
		return inspCls;
	}
	public void setInspCls(String inspCls) {
		this.inspCls = inspCls;
	}
	@Override
	public String toString() {
		return "RscOrdr [ordrCd=" + ordrCd + ", ordrDt=" + ordrDt + ", rscCd=" + rscCd + ", ordrQty=" + ordrQty
				+ ", coCd=" + coCd + ", rscIstQty=" + rscIstQty + ", rscInferQty=" + rscInferQty + ", inspCls="
				+ inspCls + "]";
	}
	
	
}
