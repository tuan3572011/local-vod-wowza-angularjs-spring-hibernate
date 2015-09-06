<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!doctype html>
<html lang="en" data-ng-app="AngularSpringApp">
<head>
<meta charset="utf-8"></meta>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Service App</title>
<!-- detail film -->
<script src="resources/MetroUIBootstrap/js/jquery-2.1.3.min.js"></script>

<!-- detail film -->
<!-- BOOTSTRAP -->
<link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="resources/bootstrap/css/formsignin.css" />
<script src="resources/bootstrap/js/bootstrap.min.js"></script>

<!-- Custom -->
<link rel="stylesheet" href="resources/bootstrap/css/animate.min.css" />
<link rel="stylesheet" href="resources/bootstrap/css/creative.css" />
<link rel="stylesheet" href="resources/dialog-video/lightbox.css" />
<link rel="stylesheet" href="resources/select2/select2.min.css">
<link rel="stylesheet" href="resources/bootstrap/css/style.css" />
<link rel="stylesheet" href="resources/bootstrap/css/search.css" />
<link rel="stylesheet" href="resources/bootstrap/css/rating.min.css" />
<link rel="stylesheet"
	href="resources/navigation-css/sticky-navigation.css" />


<!-- Plugin JavaScript -->
<script src="resources/dialog-video/lightbox.js"></script>
<script src="resources/dialog-video/custom-modal.js"></script>
<script src="resources/select2/select2.min.js"></script>
<script src="resources/bootstrap/js/validator.js"></script>
<script src="resources/bootstrap/js/rating.js"></script>


<!-- Custom Fonts -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link
	href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet">

<!-- Video js -->
<script src="resources/hls/videojs-media-sources.js"></script>
<script src="resources/hls/videojs.hls.min.js"></script>
<link href="resources/hls/video-js.css" rel="stylesheet">
<script src="resources/hls/video.js"></script>

<!-- Slider -->
<script src="resources/slide/jssor.slider.mini.js"></script>

<script src="resources/js/lib/angular/angular-1.2.3.js"></script>
<script src="resources/js/lib/angular/angular-route-1.2.3.js"></script>
<script src="resources/js/lib/angular/angular-cookies-1.2.3.js"></script>
<script src="resources/js/lib/angular/angular-resource-1.2.3.js"></script>
<script src="resources/js/lib/angular/angular-sanitize.min.js"></script>
<script src="resources/js/config.js"></script>
<script src="resources/js/app.js"></script>
<script src="resources/js/controllers/ThemPhimController.js"></script>
<script src="resources/js/controllers/PhimLeController.js"></script>
<script src="resources/js/controllers/ChiTietController.js"></script>
<script src="resources/js/controllers/TimKiemController.js"></script>
<script src="resources/js/controllers/LoginController.js"></script>
<script src="resources/js/controllers/PhimBoController.js"></script>
<script src="resources/js/controllers/SerieController.js"></script>
<script src="resources/js/controllers/FilmRedirectController.js"></script>
<script src="resources/js/controllers/PlayerController.js"></script>
<script src="resources/js/controllers/RegisFilmController.js"></script>
<script src="resources/js/controllers/CaNhanController.js"></script>
<script src="resources/js/controllers/RegisterUserController.js"></script>
<script src="resources/js/controllers/StarringController.js"></script>

<script
	src="http://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.10.0.js"></script>


<style type="text/css">
body {
	margin-top: 20px;
	font: 16px sans-serif;
	font-weight: normal;
	background-image: url("resources/images/background/body.png");
}

.update-hidden {
	display: none !important;
}
</style>
</head>
<body>
	<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand page-scroll" style="color: #f05f40" href="#">C3.net</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a class="page-scroll" href="#/PhimLe">Phim Lẻ</a></li>
					<li><a class="page-scroll" href="#/PhimBo">Phim Bộ</a></li>
					<li><a class="page-scroll" href="#/XemNhieu">Xem Nhiều</a></li>
					<!-- <li><a class="page-scroll" href="#/TimKiem">Tìm Kiếm</a></li> -->
					<li ng-if="user.isAdmin == true"><a class="page-scroll"
						href="#/ThemPhim">Them Phim</a></li>
					<li ng-if="user != null" role="presentation" class="dropdown"><a
						class="dropdown-toggle" data-toggle="dropdown" href="#/canhan"
						role="button" aria-haspopup="true" aria-expanded="false">
							{{user.userName}} <span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="#/canhan" class="page-scroll"> Trang cá
									nhân</a></li>
							<li><a data-ng-click="logout()" class="page-scroll">Thoát</a></li>
						</ul></li>
					<li ng-if="user == null"><a href="#/Login" class="page-scroll"
						class="login-window">Đăng Nhập</a></li>

				</ul>
				<ul class="nav navbar-nav navbar-right"
					ng-controller="TimKiemController">
					<li style="padding-top: 9px">
						<div class="input-group" style="width: 300px">
							<input type="text" class="form-control" id="search" name="Search"
								ng-model="dataSearch" onkeyup='searchAutoComplete();'
								placeholder="Tìm kiếm phim, đạo diễn, diễn viên..."
								aria-describedby="basic-addon2" style="border-right: none">
							<a class="input-group-addon" href="javascript:;"
								ng-click="SearchFilm(dataSearch)"> <span
								class="glyphicon glyphicon-search"></span>
							</a>
						</div>
						<div id="suggestbox" class="popup-search update-hidden">
							<div class="popup-search-in">
								<span class="icon-searchpolygon"></span>
								<div id="update" class="update-hidden"></div>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div class="container">
		<div data-ng-view=''></div>
	</div>
	<!-- FOOTER -->

	<footer class="footer-distributed">
		<div class="container">
			<div class="footer-left menufooter row">
				<h3>
					Company<span>logo</span>
				</h3>
				<h4>Thể loại</h4>
				<ul class="nav nav-pills nav-stacked menufooter">
					<li>
						<div class="col-xs-12 col-sm-6 col-lg-8">
							<p>
								<a href="#">Phim bộ mới nhất</a>
							</p>
						</div>
						<div class="clearfix visible-xs"></div>
					</li>
					<li>
						<div class="col-xs-12 col-sm-6 col-lg-8">
							<p>
								<a href="#">Phim mới cập nhật</a>
							</p>
						</div>
						<div class="clearfix visible-xs"></div>
					</li>
					<li>
						<div class="col-xs-12 col-sm-6 col-lg-8">
							<p>
								<a href="#">Phim mới cập nhật</a>
							</p>
						</div>
						<div class="clearfix visible-xs"></div>
					</li>
				</ul>
				<div class="clearfix visible-xs"></div>
			</div>
			<div class="footer-center">
				<div>
					<span class="glyphicon glyphicon-map-marker style"
						aria-hidden="true"></span>
					<p>
						<span>Quốc lộ 1A</span> Tp.HCM, Việt Nam
					</p>
				</div>
				<div>
					<span class="glyphicon glyphicon-earphone style" aria-hidden="true"></span>
					<p>+84 913 569 028</p>
				</div>
				<div>
					<span class="glyphicon glyphicon-envelope style" aria-hidden="true"></span>
					<p>
						<a href="mailto:tuancoho@gmail.com">tuancoho@gmail.com</a>
					</p>
				</div>
			</div>
			<div class="footer-right">
				<p class="footer-company-about">
					<span>About Us</span> Website chuyên cung cấp các sản phẩm phim độc
					quyền. Với tiêu chí TIỀN là trên hết.
				</p>
				<div class="footer-icons">
					<a href="https://www.facebook.com/tuan.nguyenvan.180"
						target="_blank"><i class="fa fa-facebook style"></i></a> <a
						href="#"><i class="fa fa-twitter style"></i></a> <a href="#"><i
						class="fa fa-linkedin style"></i></a> <a href="#"><i
						class="fa fa-github style"></i></a>
				</div>
			</div>
		</div>
		<div class="navbar navbar-default navbar-fixed-bottom"
			style="padding: 15px 30px 0 30px;">
			<div class="pull-right" id="back-top">
				<a href="javascript:;">Back to Top</a>
			</div>
			<div>
				<p>
					&copy; 2015 Company, Inc. &middot; <a href="#">Privacy</a> &middot;
					<a href="#">Terms</a>
				</p>
			</div>
		</div>
	</footer>
	<script type="text/javascript">
		// Assuming jQuery.noConflict(); has been called
		jQuery(function() {
			jQuery(document).ready(function() {
				jQuery("#back-top").hide();
				jQuery(function() {
					jQuery(window).scroll(function() {
						if (jQuery(this).scrollTop() > 200) {
							jQuery('#back-top').fadeIn('slow');
						} else {
							jQuery('#back-top').fadeOut('slow');
						}
					});
					jQuery('#back-top').click(function() {
						jQuery('body,html').animate({
							scrollTop : 0
						}, 1300);
						return false;
					});
				});
			});
		});
	</script>
	<script>
		function RedirectFunc(movieId, type) {
			sessionStorage.setItem("isFromSearch", "OK");
			sessionStorage.setItem("type", type);
			if (type == "movie") {
				sessionStorage.setItem("movieId", movieId);
			} else {
				sessionStorage.setItem("phimBoId", movieId);
			}
			window.location.pathname = "./FilmRedirect";
		}
	</script>
	<script type="text/javascript">
		function searchAutoComplete() {
			/* var searchBy = $('input[name="typeSearch"]:checked').val(); */
			var searchField = $("#search").val();
			if (searchField.length) {
				var myExp = new RegExp(searchField, "i");
				var found = 0;
				var max = 0;
				$
						.getJSON(
								'PhimBoController/jsonsearch',
								function(data) {
									var output = '<ul class="suggestsearch cf">';
									$
											.each(
													data,
													function(key, val) {
														if (max >= 5) {
															return;
														}
														if (val.engName
																.search(myExp) !== -1
																|| val.vnName
																		.search(myExp) !== -1
																|| val.director.name
																		.search(myExp) !== -1) {
															console.log(val);
															found = 1;
															output += '<li style="border-bottom: 1px solid #5d5b5b;">';
															output += "<a onclick=RedirectFunc('"
																	+ val.id
																	+ "','"
																	+ val.type
																	+ "')>";
															output += '<span>';
															output += '<img style="width:45px" alt="Image" src="'+ val.image +'" /></span>';
															output += '<span class="ttl-moviesearch">'
																	+ val.engName
																	+ '<span>';
															output += val.vnName
																	+ '</span></span></a>';
															output += '</li>';
															max = max + 1;
														}
														if (found != 1) {
															max = 0;
															$
																	.each(
																			val.starrings,
																			function(
																					key1,
																					val1) {
																				if (val1.name
																						.search(myExp) !== -1) {
																					found = 1;
																					output += '<li style="border-bottom: 1px solid #5d5b5b;">';
																					output += '<a ng-click=Redirect('
																							+ val.id
																							+ ','
																							+ val.type
																							+ ') target="_blank">';
																					output += '<span>';
																					output += '<img style="width:45px" alt="Image" src="'+ val.image +'" /></span>';
																					output += '<span class="ttl-moviesearch">'
																							+ val.engName
																							+ '<span>';
																					output += val.vnName
																							+ '</span></span></a>';
																					output += '</li>';
																					max = max + 1;
																				}
																			});
														}
													});
									if (found == 1) {
										output += '<li><a href="javascript:;" class="searchall"  ng-click="SearchFilm(dataSearch)">Tìm tất cả kết quả theo từ khóa</a></li>';
										output += '</ul>';
										$('#update').removeClass(
												'update-hidden');
										$('#suggestbox').removeClass(
												'update-hidden');
										$('#update').html(output);
									} else {
										output += '<li><a class="searchall">Không tìm thấy yêu cầu</a></li>';
										output += '</ul>';
										$('#update').html(output);
									}

								});
			} else {
				$('#update').addClass('update-hidden');
				$('#suggestbox').addClass('update-hidden');
			}
		}
	</script>
	<script type="text/javascript">
		$(document).mouseup(function(e) {
			var container = $(".form-control");
			var container2 = $(".popup-search-in");

			if (!container.is(e.target) // if the target of the click isn't the container...
					&& container.has(e.target).length === 0) // ... nor a descendant of the container
			{
				container2.hide();
			} else {
				container2.show();
			}
		});
	</script>
</body>

</html>