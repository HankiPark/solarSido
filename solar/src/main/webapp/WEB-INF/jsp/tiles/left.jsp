<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Sidebar scroll-->
<div class="scroll-sidebar" data-sidebarbg="skin6">
	<!-- Sidebar navigation-->
	<nav class="sidebar-nav">
		<ul id="sidebarnav">
		
			<li class="sidebar-item"><a class="sidebar-link has-arrow"
				href="javascript:void(0)" aria-expanded="false"><i
					data-feather="file-text" class="feather-icon"></i><span
					class="hide-menu">기준정보관리 </span></a>
				<ul aria-expanded="false"
					class="collapse  first-level base-level-line">
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/common/cmmndata"
						class="sidebar-link"><span class="hide-menu"> 공통코드 관리 
						</span></a>
					</li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/common/rscinfo"
						class="sidebar-link"><span class="hide-menu"> 자재정보 관리 
						</span></a>
					</li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/common/prdtbom"
						class="sidebar-link"><span class="hide-menu"> 제품 BOM 관리
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/common/fair"
						class="sidebar-link"><span class="hide-menu"> 공정 관리 
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/common/emp"
						class="sidebar-link"><span class="hide-menu"> 사원 관리 
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/common/uoprcd"
						class="sidebar-link"><span class="hide-menu"> 비가동코드 관리
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/common/prdtinfer"
						class="sidebar-link"><span class="hide-menu"> 제품 불량코드 관리 
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/common/rscinfer"
						class="sidebar-link"><span class="hide-menu"> 자재 불량코드 관리 
						</span></a></li>
				</ul></li>
			<li class="sidebar-item"><a class="sidebar-link has-arrow"
				href="javascript:void(0)" aria-expanded="false"><i
					data-feather="grid" class="feather-icon"></i><span
					class="hide-menu">영업관리 </span></a>
				<ul aria-expanded="false"
					class="collapse  first-level base-level-line">
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/sales/order"
						class="sidebar-link"><span class="hide-menu"> 주문서 참조 </span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/sales/prdt_inout_mng"
						class="sidebar-link"><span class="hide-menu"> 입출고 관리 </span></a></li>
					<li class="sidebar-item"><a href="table-sizing.html"
						class="sidebar-link"><span class="hide-menu"> 입출고 조회 </span></a></li>
					<li class="sidebar-item"><a href="table-layout-coloured.html"
						class="sidebar-link"><span class="hide-menu"> 반품 관리 </span></a></li>
				</ul></li>
			<li class="sidebar-item"><a class="sidebar-link has-arrow"
				href="javascript:void(0)" aria-expanded="false"><i
					data-feather="bar-chart" class="feather-icon"></i><span
					class="hide-menu">자재관리</span></a>
				<ul aria-expanded="false"
					class="collapse  first-level base-level-line">
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/rsc/ordradmin"
						class="sidebar-link"><span class="hide-menu"> 자재 발주 관리
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/rsc/ordr"
						class="sidebar-link"><span class="hide-menu"> 자재 발주 참조(기능완)
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/rsc/inadmin"
						class="sidebar-link"><span class="hide-menu"> 자재 입고 관리(기능완)
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/rsc/in"
						class="sidebar-link"><span class="hide-menu"> 자재 입고 조회(기능완)
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/rsc/out"
						class="sidebar-link"><span class="hide-menu"> 자재 출고 조회
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/rsc/rt"
						class="sidebar-link"><span class="hide-menu"> 자재 반품 조회(기능완)
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/rsc/stc"
						class="sidebar-link"><span class="hide-menu"> 자재 재고 조회(기능완)
						</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}"
						class="sidebar-link"><span class="hide-menu"> 자재 LOT별
								재고 관리 </span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}"
						class="sidebar-link"><span class="hide-menu"> 자재 LOT별
								재고 조회 </span></a></li>
				</ul></li>
			<li class="sidebar-item"><a class="sidebar-link has-arrow"
				href="javascript:void(0)" aria-expanded="false"><i
					data-feather="box" class="feather-icon"></i><span class="hide-menu">
						생산관리 </span></a>
				<ul aria-expanded="false"
					class="collapse  first-level base-level-line">
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/prod/prodPlanMng"
						class="sidebar-link"><span class="hide-menu"> 생산계획 관리 </span></a>
					</li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/prod/prodPlanList"
						class="sidebar-link"><span class="hide-menu"> 생산계획 조회 </span></a>
					</li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/prod/indicaMng"
						class="sidebar-link"><span class="hide-menu"> 생산지시 관리 </span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/prod/indicaList"
						class="sidebar-link"><span class="hide-menu"> 생산지시 조회</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/prcs/prcsprog"
						class="sidebar-link"><span class="hide-menu"> 공정 진행 관리
						</span></a></li>

					<li class="sidebar-item"><a href="ui-list-media.html"
						class="sidebar-link"><span class="hide-menu"> 공정 실적 관리
						</span></a></li>
					<li class="sidebar-item"><a href="ui-grid.html"
						class="sidebar-link"><span class="hide-menu"> 공정 실적 조회
						</span></a></li>

				</ul></li>
			<li class="sidebar-item"><a class="sidebar-link has-arrow"
				href="javascript:void(0)" aria-expanded="false"><i
					data-feather="box" class="feather-icon"></i><span class="hide-menu">
						설비관리 </span></a>
				<ul aria-expanded="false"
					class="collapse  first-level base-level-line">
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/eqm/eqmMng"
						class="sidebar-link"><span class="hide-menu"> 설비 관리</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/eqm/nonMovingMng"
						class="sidebar-link"><span class="hide-menu"> 설비 비가동
								관리(NY)</span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/eqm/nonMovingList"
						class="sidebar-link"><span class="hide-menu">설비 비가동
								조회(NY)</span></a></li>
				</ul></li>
			<li class="sidebar-item"><a class="sidebar-link has-arrow"
				href="javascript:void(0)" aria-expanded="false"><i
					data-feather="box" class="feather-icon"></i><span class="hide-menu">
						품질관리 </span></a>
				<ul aria-expanded="false"
					class="collapse  first-level base-level-line">
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}/rsc/insp"
						class="sidebar-link"><span class="hide-menu"> 자재 검수 관리(기능완) </span></a></li>
					<li class="sidebar-item"><a href="${pageContext.request.contextPath}"
						class="sidebar-link"><span class="hide-menu"> 자재 검수 조회 </span></a></li>
					<li class="sidebar-item"><a href="ui-breadcrumb.html"
						class="sidebar-link"><span class="hide-menu"> 제품 생산 조회(추적?)</span></a></li>
					<li class="sidebar-item"><a href="ui-breadcrumb.html"
						class="sidebar-link"><span class="hide-menu"> LOT별 생산이력 조회</span></a></li>
				</ul></li>
		</ul>
	</nav>
</div>