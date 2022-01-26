<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>SolarSido</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
	

<!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<link
	href="${pageContext.request.contextPath}/resources/assets/libs/fullcalendar/dist/fullcalendar.min.css"
	rel="stylesheet" />
<!-- Custom CSS -->

 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/adminlte.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
 <script src="https://kit.fontawesome.com/2c1f4275fd.js" crossorigin="anonymous"></script>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/mbjs.ico">




<style>
</style>
</head>
<body>

<body class="hold-transition sidebar-mini layout-fixed" data-panel-auto-height-mode="height">
<div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      
    </ul>
 <ul class="navbar-nav ml-auto">
  

     <!-- login -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/uat/uia/egovLoginUsr.do">
          <i class="fas fa-sign-in-alt"></i>
          <span >login</span>
        </a>
      </li>
       <!-- Notifications Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-bell"></i>
          <span class="badge badge-warning navbar-badge"></span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
          <span class="dropdown-item dropdown-header">0 Notifications</span>
          <div class="dropdown-divider" ></div>
       <!--    <a href="#" class="dropdown-item" name="ddd">
            <i class="fas fa-envelope mr-2"></i><span class="float-left text-muted text-sm" name="abc"></span> 
             <span class="float-right text-muted text-sm">0 mins</span> 
          </a>
          -->
       <div id="msgStack"></div>

        </div>
      </li>

    </ul>
   
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="${pageContext.request.contextPath}" class="brand-link">
      <img src="${pageContext.request.contextPath}/resources/mbjs.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" >
      <img src="${pageContext.request.contextPath}/resources/solarsido.png" alt="AdminLTE Logo" class="dark-logo" style="opacity: .8">
      
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
  

 

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-info-circle"></i>
              <p>
               egov
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/sec/ram/EgovAuthorList.do" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>권한 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/sec/rgm/EgovAuthorGroupList.do" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>권한 그룹관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/sec/rmt/EgovRoleList.do" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>롤 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/sym/mnu/mpm/EgovMenuListSelect.do" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>메뉴리스트관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/sym/mnu/mpm/EgovMenuManageSelect.do" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>메뉴관리리스트</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/sym/mnu/mcm/EgovMenuCreatManageSelect.do" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>메뉴생성관리</p>
                </a>
              </li>
           
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-info-circle"></i>
              <p>
               기준정보관리
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/cmmndata" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>공통코드 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/rscinfo" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>자재정보 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/prdtbom" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>제품 BOM 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/fair" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>공정 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/emp" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>사원 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/uoprcd" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>비가동코드 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/prdtinfer" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>제품 불량코드 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/rscinfer" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>자재 불량코드 관리</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-chart-pie"></i>
              <p>
                영업관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/sales/order" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>주문서 참조</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/sales/prdt_inout_mng" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>입출고 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/sales/prdt_inout_ref" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>입출고 조회</p>
                </a>
              </li>
               <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>반품 관리</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-leaf"></i>
              <p>
               자재관리
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/inferGraph" class="nav-link">
               <i class="fas fa-search nav-icon"></i>
                  <p>불량률(임시)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/ordradmin" class="nav-link">
  <i class="fas fa-file-signature nav-icon"></i>                  <p>자재 발주 관리(ㅇ)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/ordr" class="nav-link">
                   <i class="fas fa-search nav-icon"></i>
                  <p>자재 발주 참조(ㅇ)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/inadmin" class="nav-link">
                    <i class="fas fa-file-signature nav-icon"></i>
                  <p>자재 입고 관리(ㅇ)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/in" class="nav-link">
                   <i class="fas fa-search nav-icon"></i>
                  <p>자재 입고 조회(ㅇ) </p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/out" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>자재 출고 조회</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/rt" class="nav-link">
                   <i class="fas fa-search nav-icon"></i>
                  <p> 자재 반품 조회(ㅇ) </p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/stc" class="nav-link">
                   <i class="fas fa-search nav-icon"></i>
                  <p>자재 재고 조회(ㅇ)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}" class="nav-link">
                   <i class="fas fa-file-signature nav-icon"></i>
                  <p> 자재 LOT별 재고 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>자재 LOT별 재고 조회</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-cogs"></i>
              <p>
                생산관리
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/prod/prodPlanMng" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>생산계획 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/prod/prodPlanList" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>생산계획 조회</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/prod/indicaMng" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>생산지시 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/prod/indicaList" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>생산지시 조회</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/prcs/prcsprog" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>공정 진행 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="pages/forms/validation.html" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>공정 실적 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="pages/forms/validation.html" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>공정 실적 조회</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-industry"></i>
              <p>
                설비 관리
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/eqm/eqmMng" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>설비 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/eqm/nonMovingMng" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>설비 비가동 관리(NY)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/eqm/nonMovingList" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>설비 비가동 조회(NY)</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-table"></i>
              <p>
                 품질 관리
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/inspadmin" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>자재 검수 관리(ㅇ)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/insp" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>자재 검수 조회</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>제품 생산 조회(추적?)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p> LOT별 생산이력 조회</p>
                </a>
              </li>
            </ul>
          </li>
         
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper iframe-mode" data-widget="iframe" data-loading-screen="750">
    <div class="nav navbar navbar-expand navbar-white navbar-light border-bottom p-0">
      <div class="nav-item dropdown" >
        <a class="nav-link dropdown-toggle" style="background-color:#fff; color:red" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Close</a>
        <div class="dropdown-menu mt-0">
          <a class="dropdown-item" href="#" data-widget="iframe-close" data-type="all">Close All</a>
          <a class="dropdown-item" href="#" data-widget="iframe-close" data-type="all-other">Close All Other</a>
        </div>
      </div>
      <a class="nav-link bg-light" href="#" data-widget="iframe-scrollleft"><i class="fas fa-angle-double-left"></i></a>
      <ul class="navbar-nav overflow-hidden" role="tablist"></ul>
      <a class="nav-link bg-light" href="#" data-widget="iframe-scrollright"><i class="fas fa-angle-double-right"></i></a>
      <a class="nav-link bg-light" href="#" data-widget="iframe-fullscreen"><i class="fas fa-expand"></i></a>
      <a class="nav-link bg-light" href="javascript:void(0);" onclick="refresh()"><i class="fas fa-sync-alt"></i></a>
    </div>
    <div class="tab-content">
      <div class="tab-empty">
        <h2 class="display-4">No tab selected!</h2>
      </div>
      <div class="tab-loading">
        <div>
          <h2 class="display-4">Tab is loading <i class="fa fa-sync fa-spin"></i></h2>
        </div>
      </div>
    </div>
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <strong>Copyright &copy; 2021- <a href="${pageContext.request.contextPath}">Solarsido</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
      <b>Version</b> 1.1.0
    </div>
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>

<script type="text/javascript">
var socket  = null;


// toast생성 및 추가
function onMessage(evt){
    var data = evt.data;
    // toast
    let toast = "<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
    toast += "<div class='toast-header'><i class='fas fa-bell mr-2'></i><strong class='mr-auto'>알림</strong>";
    toast += "<small class='text-muted'>just now</small><button type='button' class='ml-2 mb-1 close' data-dismiss='toast' aria-label='Close'>";
    toast += "<span aria-hidden='true'>&times;</span></button>";
    toast += "</div> <div class='toast-body'>" + data + "</div></div>";
    $("#msgStack").append(toast);   // msgStack div에 생성한 toast 추가
    $(".toast").toast({"animation": true, "autohide": false});
    $('.toast').toast('show');
};	
$('#notifySendBtn').click(function(e){
    let modal = $('.modal-content').has(e.target);
    let type = '70';
    let target = modal.find('.modal-body input').val();
    let content = modal.find('.modal-body textarea').val();
    let url = '${contextPath}/member/notify.do';
    // 전송한 정보를 db에 저장	
    $.ajax({
        type: 'post',
        url: '${contextPath}/member/saveNotify.do',
        dataType: 'text',
        data: {
            target: target,
            content: content,
            type: type,
            url: url
        },
        success: function(){    // db전송 성공시 실시간 알림 전송
            // 소켓에 전달되는 메시지
            // 위에 기술한 EchoHandler에서 ,(comma)를 이용하여 분리시킨다.
            socket.send("관리자,"+target+","+content+","+url);	
        }
    });
    modal.find('.modal-body textarea').val('');	// textarea 초기화
});

</script>

		<script
			src="${pageContext.request.contextPath}/resources/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
		<!-- apps -->
		<script
			src="${pageContext.request.contextPath}/resources/dist/js/app-style-switcher.js"></script>
		<script
			src="${pageContext.request.contextPath}/resources/dist/js/feather.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/resources/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/resources/dist/js/sidebarmenu.js"></script>
			<script src="${pageContext.request.contextPath}/resources/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
			
		<!--Custom JavaScript -->
		<script
			src="${pageContext.request.contextPath}/resources/dist/js/iframe-custom.js"></script>
		<script
			src="${pageContext.request.contextPath}/resources/dist/js/demo1.js"></script>
	

</body>
<script>
	function refresh(){
		let iframes = document.getElementsByTagName('iframe');
		for(let iframe of iframes){
			iframe.contentWindow.location.reload();
		}
	}
</script>
</html>

