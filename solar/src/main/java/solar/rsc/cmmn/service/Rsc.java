package solar.rsc.cmmn.service;

import lombok.Data;

@Data
public class Rsc {
	String rscCd;
	String rscNm;
	String safStc;
	String coCd;
	String rscSpec;
	String rscUnit;
	String rscImg;
	String rscUntprc;
	public String getRscCd() {
		return rscCd;
	}
	public void setRscCd(String rscCd) {
		this.rscCd = rscCd;
	}
	public String getRscNm() {
		return rscNm;
	}
	public void setRscNm(String rscNm) {
		this.rscNm = rscNm;
	}
	public String getSafStc() {
		return safStc;
	}
	public void setSafStc(String safStc) {
		this.safStc = safStc;
	}
	public String getCoCd() {
		return coCd;
	}
	public void setCoCd(String coCd) {
		this.coCd = coCd;
	}
	public String getRscSpec() {
		return rscSpec;
	}
	public void setRscSpec(String rscSpec) {
		this.rscSpec = rscSpec;
	}
	public String getRscUnit() {
		return rscUnit;
	}
	public void setRscUnit(String rscUnit) {
		this.rscUnit = rscUnit;
	}
	public String getRscImg() {
		return rscImg;
	}
	public void setRscImg(String rscImg) {
		this.rscImg = rscImg;
	}
	public String getRscUntprc() {
		return rscUntprc;
	}
	public void setRscUntprc(String rscUntprc) {
		this.rscUntprc = rscUntprc;
	}
	@Override
	public String toString() {
		return "Rsc [rscCd=" + rscCd + ", rscNm=" + rscNm + ", safStc=" + safStc + ", coCd=" + coCd + ", rscSpec="
				+ rscSpec + ", rscUnit=" + rscUnit + ", rscImg=" + rscImg + ", rscUntprc=" + rscUntprc + "]";
	}
	
}
