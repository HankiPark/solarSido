package solar.rsc.ordr.service;

import lombok.Data;
  
@Data
public class RscOrdr {
	String ordrDt;
	String rscNm;
	String rscCd;
	String ordrQty;
	String ordrCd;
	String coNm;
	String rscIstQty;
	String rscInferQty;
	String inspCls;
	public String getOrdrDt() {
		return ordrDt;
	}
	public void setOrdrDt(String ordrDt) {
		this.ordrDt = ordrDt;
	}
	public String getRscNm() {
		return rscNm;
	}
	public void setRscNm(String rscNm) {
		this.rscNm = rscNm;
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
	public String getOrdrCd() {
		return ordrCd;
	}
	public void setOrdrCd(String ordrCd) {
		this.ordrCd = ordrCd;
	}
	public String getCoNm() {
		return coNm;
	}
	public void setCoNm(String coNm) {
		this.coNm = coNm;
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
	
}
