package solar.prcs2.web;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import solar.prcs2.dao.EqmAble;
import solar.prcs2.dao.Prcs2;
import solar.prcs2.service.impl.Prcs2Mapper;

@Component
public class Prcs2Scheduler  {

	@Autowired
	Prcs2Mapper pmapper; // 무한루프 그려서 화면에 표기

	public void sch2() throws Exception {
		System.out.println("스케줄테스트");
		List<Prcs2> plist = pmapper.findTemp();
		List<EqmAble> elist = new ArrayList<EqmAble>();
		List<EqmAble> elist2 = new ArrayList<EqmAble>();
		List<EqmAble> elist3 = new ArrayList<EqmAble>();
		List<EqmAble> elist4 = new ArrayList<EqmAble>();
		List<EqmAble> ilist = new ArrayList<EqmAble>();
		List<EqmAble> ilist2 = new ArrayList<EqmAble>();
		List<EqmAble> ilist3 = new ArrayList<EqmAble>();
		List<EqmAble> ilist4 = new ArrayList<EqmAble>();
		EqmAble eqmNo = new EqmAble();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		int count = 0;
		if (plist.isEmpty()) {
		} else {
			
			eqmNo.setLiNo(Integer.toString(1));
			elist.addAll(pmapper.ableEqm(eqmNo));
			ilist.addAll(pmapper.inferList(eqmNo));
			eqmNo.setLiNo(Integer.toString(2));
			elist2.addAll(pmapper.ableEqm(eqmNo));
			ilist2.addAll(pmapper.inferList(eqmNo));
			eqmNo.setLiNo(Integer.toString(3));
			elist3.addAll(pmapper.ableEqm(eqmNo));
			ilist3.addAll(pmapper.inferList(eqmNo));
			eqmNo.setLiNo(Integer.toString(4));
			elist4.addAll(pmapper.ableEqm(eqmNo));
			ilist4.addAll(pmapper.inferList(eqmNo));
			for (int i = 0; i < plist.size(); i++) {
				double error = pmapper.random();
				int ran = (int)(error*2-1);
				
				//System.out.println(error);
				if (plist.get(i).getPrdtFg().equals("P") && plist.get(i).getPrcsFrTm() == null && elist.size() != 0) {
					EqmAble eq = new EqmAble();
					plist.get(i).setPrcsFrTm(java.sql.Timestamp.valueOf(LocalDateTime.now()));
					pmapper.updatePEqm(elist.get(0));
					String selected = new String(elist.get(0).getEqmCd());
					plist.get(i).setEqmCd(selected);
					pmapper.updateFr(plist.get(i));

					elist.remove(0);

				} else if (plist.get(i).getPrdtFg().equals("P") && plist.get(i).getPrcsFrTm() != null) {

					EqmAble eq = new EqmAble();
					eq.setEqmCd(plist.get(i).getEqmCd());
					eq.setLiNo("1");
					pmapper.updateYEqm(eq);
					elist.add(eq);
					plist.get(i).setPrcsToTm(java.sql.Timestamp.valueOf(LocalDateTime.now()));

					if (error >= 0.92) {
						plist.get(i).setPrdtFg("F");
						pmapper.insertMid(plist.get(i));
						count++;
						pmapper.updateTo(plist.get(i));
						pmapper.updateFg(plist.get(i));
						pmapper.inPrdt(plist.get(i));
					} else {
						pmapper.insertMid(plist.get(i));
						plist.get(i).setPrdtFg("P1");
						pmapper.updateTo(plist.get(i));
						pmapper.updateFg(plist.get(i));
					}

				} else if (plist.get(i).getPrdtFg().equals("P1") && plist.get(i).getPrcsFrTm() == null
						&& elist2.size() != 0) {
					EqmAble eq = new EqmAble();
					plist.get(i).setPrcsFrTm(java.sql.Timestamp.valueOf(LocalDateTime.now()));
					pmapper.updatePEqm(elist2.get(0));
					String selected = new String(elist2.get(0).getEqmCd());
					plist.get(i).setEqmCd(selected);
					pmapper.updateFr(plist.get(i));

					elist2.remove(0);

				} else if (plist.get(i).getPrdtFg().equals("P1") && plist.get(i).getPrcsFrTm() != null) {

					EqmAble eq = new EqmAble();
					eq.setEqmCd(plist.get(i).getEqmCd());
					eq.setLiNo("2");
					pmapper.updateYEqm(eq);
					elist2.add(eq);
					plist.get(i).setPrcsToTm(java.sql.Timestamp.valueOf(LocalDateTime.now()));
					if (error >= 0.92) {
						plist.get(i).setPrdtFg("F");
						pmapper.insertMid(plist.get(i));
						count++;
						pmapper.updateTo(plist.get(i));
						pmapper.updateFg(plist.get(i));
						pmapper.inPrdt(plist.get(i));
					} else {
						pmapper.insertMid(plist.get(i));
						plist.get(i).setPrdtFg("P2");
						pmapper.updateTo(plist.get(i));
						pmapper.updateFg(plist.get(i));
					}

				} else if (plist.get(i).getPrdtFg().equals("P2") && plist.get(i).getPrcsFrTm() == null
						&& elist3.size() != 0) {
					EqmAble eq = new EqmAble();
					plist.get(i).setPrcsFrTm(java.sql.Timestamp.valueOf(LocalDateTime.now()));
					pmapper.updatePEqm(elist3.get(0));
					String selected = new String(elist3.get(0).getEqmCd());
					plist.get(i).setEqmCd(selected);
					pmapper.updateFr(plist.get(i));

					elist3.remove(0);

				} else if (plist.get(i).getPrdtFg().equals("P2") && plist.get(i).getPrcsFrTm() != null) {

					EqmAble eq = new EqmAble();
					eq.setEqmCd(plist.get(i).getEqmCd());
					eq.setLiNo("3");
					pmapper.updateYEqm(eq);
					elist3.add(eq);
					plist.get(i).setPrcsToTm(java.sql.Timestamp.valueOf(LocalDateTime.now()));
					if (error >= 0.92) {
						plist.get(i).setPrdtFg("F");
						pmapper.insertMid(plist.get(i));
						count++;
						pmapper.updateTo(plist.get(i));
						pmapper.updateFg(plist.get(i));
						pmapper.inPrdt(plist.get(i));
					} else {
						pmapper.insertMid(plist.get(i));
						plist.get(i).setPrdtFg("P3");
						pmapper.updateTo(plist.get(i));
						pmapper.updateFg(plist.get(i));
					}

				} else if (plist.get(i).getPrdtFg().equals("P3") && plist.get(i).getPrcsFrTm() == null
						&& elist4.size() != 0) {
					EqmAble eq = new EqmAble();
					plist.get(i).setPrcsFrTm(java.sql.Timestamp.valueOf(LocalDateTime.now()));
					pmapper.updatePEqm(elist4.get(0));
					String selected = new String(elist4.get(0).getEqmCd());
					plist.get(i).setEqmCd(selected);
					pmapper.updateFr(plist.get(i));

					elist4.remove(0);

				} else if (plist.get(i).getPrdtFg().equals("P3") && plist.get(i).getPrcsFrTm() != null) {

					EqmAble eq = new EqmAble();
					eq.setEqmCd(plist.get(i).getEqmCd());
					eq.setLiNo("4");
					pmapper.updateYEqm(eq);
					elist4.add(eq);
					plist.get(i).setPrcsToTm(java.sql.Timestamp.valueOf(LocalDateTime.now()));
					if (error >= 0.92) {
						plist.get(i).setPrdtFg("F");
						pmapper.insertMid(plist.get(i));
					} else {
						pmapper.insertMid(plist.get(i));
						plist.get(i).setPrdtFg("C");
						pmapper.insertMid(plist.get(i));
						
					}
					pmapper.updateFg(plist.get(i));
					pmapper.inPrdt(plist.get(i));
					count++;
				} else if (plist.get(i).getPrdtFg().equals("C") || plist.get(i).getPrdtFg().equals("F")) {
					count++;

				}

				if (count == plist.size()) {
					pmapper.completePrcs();
				}

			}

		}

	}

}
