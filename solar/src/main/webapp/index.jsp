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
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/extra-libs/taskboard/js/jquery-ui.min.js"></script>
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
      <a href="#" id="logoutWd" class="nav-link">
      <i class="fas fa-sign-out-alt"></i>
             <span >logout</span></a>
        <a class="nav-link" href="#" id="loginWd" >
          <i class="fas fa-sign-in-alt"></i>
          <span >login</span>
        </a>
      </li>
       <!-- Notifications Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#" id ="noticeNav">
          <i class="far fa-bell"></i>
          <span class="badge badge-warning navbar-badge"></span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
        </div>
      </li>

    </ul>
   
  </nav>
  <!-- /.navbar -->
   <div id="msgStack"></div>
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
       <%--    <li class="nav-item">
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
                <a href="${pageContext.request.contextPath}/uss/umt/EgovMberManage.do" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>멤버추가</p>
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
                <a href="${pageContext.request.contextPath}/common/mng/cmmndata" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>공통코드 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/mng/rscinfo" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>자재정보 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/mng/prdtbom" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>제품 BOM 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/mng/fair" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>공정 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/mng/emp" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>사원 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/mng/uoprcd" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>비가동코드 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/mng/prdtinfer" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>제품 불량코드 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/common/mng/rscinfer" class="nav-link">
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
                <a href="${pageContext.request.contextPath}/sales/ref/order" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>주문서 참조</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/sales/mng/prdt_inout_mng" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>입출고 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/sales/ref/prdt_inout_ref" class="nav-link">
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
                <a href="${pageContext.request.contextPath}/rsc/ref/inferGraph" class="nav-link">
               <i class="fas fa-search nav-icon"></i>
                  <p>불량률(임시)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/mng/ordradmin" class="nav-link">
  <i class="fas fa-file-signature nav-icon"></i>                  <p>자재 발주 관리(ㅇ)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/ref/ordr" class="nav-link">
                   <i class="fas fa-search nav-icon"></i>
                  <p>자재 발주 참조(ㅇ)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/mng/inadmin" class="nav-link">
                    <i class="fas fa-file-signature nav-icon"></i>
                  <p>자재 입고 관리(ㅇ)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/ref/in" class="nav-link">
                   <i class="fas fa-search nav-icon"></i>
                  <p>자재 입고 조회(ㅇ) </p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/ref/out" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>자재 출고 조회</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/ref/rt" class="nav-link">
                   <i class="fas fa-search nav-icon"></i>
                  <p> 자재 반품 조회(ㅇ) </p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/ref/stc" class="nav-link">
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
                <a href="${pageContext.request.contextPath}/prod/mng/prodPlanMng" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>생산계획 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/prod/ref/prodPlanList" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>생산계획 조회</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/prod/mng/indicaMng" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>생산지시 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/prod/ref/indicaList" class="nav-link">
                  <i class="fas fa-search nav-icon"></i>
                  <p>생산지시 조회</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/prcs/mng/prcsprog" class="nav-link">
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
                <a href="${pageContext.request.contextPath}/eqm/mng/eqmMng" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>설비 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/eqm/mng/nonMovingMng" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>설비 비가동 관리(NY)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/eqm/ref/nonMovingList" class="nav-link">
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
                <a href="${pageContext.request.contextPath}/rsc/mng/inspadmin" class="nav-link">
                  <i class="fas fa-file-signature nav-icon"></i>
                  <p>자재 검수 관리(ㅇ)</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath}/rsc/ref/insp" class="nav-link">
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
          </li>--%>
         
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
        <h2 class="display-4" id="needLog" style="display:none"> 로그인 해주세요</h2>
        <img id="afterLog" src="${pageContext.request.contextPath}/resources/mainScreen.png" style="width:2000px; height: 880px;">
        	<div id="dialog-login" title="로그인"></div>
      </div>
      <div class="tab-loading">
        <div>
          <h2 class="display-4">로딩중입니다 <i class="fa fa-sync fa-spin"></i></h2>
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
let idK;



$(function(){

	if("${loginVO.uniqId}"==""){
		$("#logoutWd").css("display","none");
		$("#loginWd").css("display","block");
		$("#needLog").css("display","block");
		$("#afterLog").css("display","none");
		$("#usna").remove();
	}else{
		$("#loginWd").css("display","none");
		$("#logoutWd").css("display","block");
		$("#needLog").css("display","none");
		$("#afterLog").css("display","block");
		idK="${loginVO.id}";
		$(".ml-auto").prepend(`<span id="usna" style="padding-top:8px; padding-right:10px;">${loginVO.id}</span>`);
		$.ajax({
			url:"${pageContext.request.contextPath}/ajax/MenuList",
			method:"get",
			data: {"uniqId": "${loginVO.uniqId}" },
			contentType: 'application/json; charset=utf-8',
			async: false,
			dataType:'json'
		}).done((res)=>{
			for(let g of res.menu){
				if(g.upperMenuNo==0){
					$(".nav-sidebar").append(`<li class="nav-item">
				            <a href="#" class="nav-link">
				              <i class="nav-icon `+g.relateImagePath+`"></i>
				              <p>`+g.menuNm+`
				                <i class="fas fa-angle-left right"></i>
				              </p>
				            </a>
				            <ul class="nav nav-treeview `+g.menuNo+`">`);
				}else{
					$("."+g.upperMenuNo).append(`
							<li class="nav-item">
			                <a href="${pageContext.request.contextPath}`+g.chkUrl+`" class="nav-link">
			                  <i class="`+g.relateImagePath+` nav-icon"></i>
			                  <p>`+g.menuNm+`</p>
			                </a>
			              </li>
							`)
				}
			}
		});
		$.ajax({
			url : "${pageContext.request.contextPath}/ajax/webcount",
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			data : {userId : "${loginVO.id}"}
		}).done((ev)=>{
			if(ev.count=='0'){
				 $(".navbar-badge").html('');
			}else{
			 $(".navbar-badge").html(ev.count);
			}
		})
	}
	
 $(document).on('click','.nav-treeview',function(){
		$("iframe").attr("name","child");
		setTimeout(()=>{
		for(var i =0; i <document.getElementsByName("child").length;i++){
			document.getElementsByName("child")[i].contentWindow.postMessage("${loginVO.id}",'*');	
		}
		},2000);
 })
 
 
 
 
})
window.addEventListener( 'message', receiveMsgFromChild );

// 자식으로부터 메시지 수신
function receiveMsgFromChild( e ) {
    console.log( '자식으로부터 받은 메시지 ', e.data );
    $(".navbar-badge").html(e.data);
}

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

let dialog00 = $("#dialog-login").dialog({
	autoOpen : false,
	modal : false,
	width : 700,
	height : 700
});

$("#loginWd").on("click",function(){

	dialog00.dialog("open");
	$("#dialog-login").load("${pageContext.request.contextPath}/uat/uia/egovLoginUsr.do",function() {
		

				})
		
})
$("#logoutWd").on("click",function(){

	$.ajax({
		url:'${pageContext.request.contextPath}/uat/uia/actionLogout.do',
	}).done(()=>{
		window.location.assign("${pageContext.request.contextPath}");
	})
		
})

$("#noticeNav").on("click",function(){
	
	console.log(idK);
	$.ajax({
		url : '${pageContext.request.contextPath}/ajax/webcontent',
		dataType: 'json',
		contentType: 'application/json; charset=utf-8',
		data : {userId : idK
				}
	}).done((ev)=>{
		$(".dropdown-menu").empty();
		$('.dropdown-header').remove();
		$('.appendmenu').remove();
		$(".dropdown-menu").append(
		` <span class="dropdown-item dropdown-header">`+ev.main.length+` 건의 알림</span>
         <div class="dropdown-divider" ></div> `
         );
		for(var con of ev.main){
			if(con.readYn=='NY'){
				if((new Date().getTime()-new Date(con.msDt).getTime())/(1000*60*60*24)>=1){
			$(".dropdown-menu").append(
					`<a href="#" onclick="findHref('`+con.msContent+`')" class="dropdown-item appendmenu nav-link">
            <i class="fas fa-envelope mr-2"></i>`+ con.msTitle+`
            <span class="float-right text-muted text-sm">`+con.msDt+`</span>
          </a>`)}
				else{
					$(".dropdown-menu").append(
							`<a href="#" onclick="findHref('`+con.msContent+`')" class="dropdown-item appendmenu nav-link">
		            <i class="fas fa-envelope mr-2"></i>`+ con.msTitle+`
		            <span class="float-right text-muted text-sm"> 오늘 </span>
		          </a>`)
				}
			}
			else{
				if((new Date().getTime()-new Date(con.msDt).getTime())/(1000*60*60*24)>=1){
				$(".dropdown-menu").append(
						`<a href="#" onclick="findHref('`+con.msContent+`')" class="dropdown-item appendmenu nav-link">
						<i class="fas fa-envelope-open mr-2"></i>`+ con.msTitle+`
	            <span class="float-right text-muted text-sm">`+con.msDt+`</span>
	          </a>`)
			}else{
				$(".dropdown-menu").append(
						`<a href="#" onclick="findHref('`+con.msContent+`')" class="dropdown-item appendmenu nav-link">
						<i class="fas fa-envelope-open mr-2"></i>`+ con.msTitle+`
	            <span class="float-right text-muted text-sm"> 오늘 </span>
	          </a>`)
			}
			}
			
		}
		$(".dropdown-menu").append(
		`<a href="#" onclick="removeMessage(`+idK+`)" class="dropdown-item dropdown-footer">모든 메세지 삭제</a>`
		)
			
	})
		
		
		
		
		
		
		
		 $(".navbar-badge").html('');
	})
	


function findHref(link){
	$("a[href$='"+link+"']").trigger("click");
}

function removeMessage(id){
	console.log(id);
	$.ajax({
		url : '${pageContext.request.contextPath}/ajax/webdelete',
		dataType: 'json',
		contentType: 'application/json; charset=utf-8',
		data : {userId : id
				}
	}).done((ev)=>{
		$("#noticeNav").trigger("click");
	});
}



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

