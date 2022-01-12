package solar.rsc.infer.service;

import lombok.Data;

@Data
public class RscInfer {
	String cmmnCdDetaId;
	String cmmnCdId;
	String cmmnCdNm;
	String cmmnCdDesct;
	String rscInferQty;
	public String getCmmnCdDetaId() {
		return cmmnCdDetaId;
	}
	public void setCmmnCdDetaId(String cmmnCdDetaId) {
		this.cmmnCdDetaId = cmmnCdDetaId;
	}
	public String getCmmnCdId() {
		return cmmnCdId;
	}
	public void setCmmnCdId(String cmmnCdId) {
		this.cmmnCdId = cmmnCdId;
	}
	public String getCmmnCdNm() {
		return cmmnCdNm;
	}
	public void setCmmnCdNm(String cmmnCdNm) {
		this.cmmnCdNm = cmmnCdNm;
	}
	public String getCmmnCdDesct() {
		return cmmnCdDesct;
	}
	public void setCmmnCdDesct(String cmmnCdDesct) {
		this.cmmnCdDesct = cmmnCdDesct;
	}
	
}
