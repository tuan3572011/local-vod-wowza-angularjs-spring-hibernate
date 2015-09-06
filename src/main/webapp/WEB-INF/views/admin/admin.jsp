<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!doctype html>
<html lang="en" data-ng-app="AngularSpringApp">
<head>
<meta charset="utf-8"></meta>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Page</title>

<!-- Datatables  -->
<script src="resources/MetroUIBootstrap/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet"
	href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css">
<link rel="stylesheet"
	href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery.address/1.6/jquery.address.min.js"></script>

<!-- Metro Boostrap -->
<link rel="stylesheet" href="resources/MetroUIBootstrap/css/metro.css" />
<link rel="stylesheet"
	href="resources/MetroUIBootstrap/css/metro-icons.css" />
<script src="resources/MetroUIBootstrap/js/jquery-2.1.3.min.js"></script>
<script src="resources/MetroUIBootstrap/js/metro.js"></script>
<script src="resources/MetroUIBootstrap/js/select2.min.js"></script>
<!-- Login Box -->
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<link rel="stylesheet" href="resources/admin/css/loginbox.css" />
<style>
header {
	color: white;
	text-align: center;
	padding: 5px;
}

nav {
	line-height: 20px;
	background-color: #ffffff;
	width: 20%;
	float: left;
	padding: 1%;
}

section .article {
	width: 80%;
	float: left;
	padding: 2px;
	overflow: auto;
	height: 420px;
}

footer {
	background-color: none;
	color: none;
	clear: both;
	text-align: right;
	padding: 5px;
}

.login-form {
	width: 25rem;
	height: 18.75rem;
	position: fixed;
	top: 50%;
	margin-top: -9.375rem;
	left: 50%;
	margin-left: -12.5rem;
	background-color: #ffffff;
	opacity: 0;
	-webkit-transform: scale(.8);
	transform: scale(.8);
}
</style>
</head>
<body>
	<header style="margin-left: 0%">
		<div class="app-bar darcula" data-role="appbar">
			<span class="app-bar-divider"></span> <a
				class="app-bar-element branding" href="#/home">Phim c3.net</a> <span
				class="app-bar-divider"></span>

			<ul class="app-bar-menu">
				<li><a href="#" class="dropdown-toggle">Project</a>
					<ul class="d-menu" data-role="dropdown">
						<li><a href="#/PhimBo">Phim Bo</a></li>
						<li class="divider"></li>
						<li><a href="#/PhimBo">Phim Bo</a></li>
					</ul></li>
				<li><a href="#/card">Card</a></li>
				<li><a href="#/user">User</a></li>
			</ul>
			<c:if test="${!empty username }">
				<ul class="app-bar-menu" style="float: right;">
					<li><c:url var="logoutUrl" value="j_spring_security_logout" />
						<form action="${logoutUrl}" method="post">
							<input type="submit" value="Hi! ${username } - Logout" /> <input
								type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form></li>
				</ul>
			</c:if>
			<c:if test="${empty username }">
				<ul class="app-bar-menu" style="float: right;">
					<li><a href="#login-box" class="login-window">Đăng Nhập</a></li>
				</ul>
			</c:if>
			<ul class="app-bar-menu" style="float: right;">
				<li><a href="#login-box" class="login-window">Đăng Nhập</a></li>
			</ul>
		</div>
	</header>
	<div data-ng-view=''></div>

	<c:url value="/login" var="action" />
	<div id="login-box" class="login-popup">
		<a href="#" class="close"><img
			src="resources/admin/images/close_pop.png" class="btn_close"
			title="Close Window" alt="Close" /></a>
		<form method="post" class="signin" action="${action }"
			data-role="validator" data-show-required-state="false"
			data-hint-mode="line" data-hint-background="bg-red"
			data-hint-color="fg-white" data-hide-error="5000">
			<fieldset class="textbox">
				<span>Email</span> <input class="input-control text full-size"
					data-validate-func="required"
					data-validate-hint="This field can not be empty" type="text"
					id="name" name="email" placeholder="Enter Name"> <span>Password</span>
				<input class="input-control text full-size" id="password"
					name="password" value="" type="password" placeholder="Password">

				<input id="submit" class="input-control text full-size"
					class="submit button" type="submit" value="Login">

				<p>
					<a class="forgot" href="#">Forgot your password?</a>
				</p>

			</fieldset>
		</form>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			$('a.login-window').click(function() {

				//Getting the variable's value from a link 
				var loginBox = $(this).attr('href');

				//Fade in the Popup
				$(loginBox).fadeIn(300);

				//Set the center alignment padding + border see css style
				var popMargTop = ($(loginBox).height() + 24) / 2;
				var popMargLeft = ($(loginBox).width() + 24) / 2;

				$(loginBox).css({
					'margin-top' : -popMargTop,
					'margin-left' : -popMargLeft
				});

				// Add the mask to body
				$('body').append('<div id="mask"></div>');
				$('#mask').fadeIn(300);

				return false;
			});

			// When clicking on the button close or the mask layer the popup closed
			$('a.close, #mask').live('click', function() {
				$('#mask , .login-popup').fadeOut(300, function() {
					$('#mask').remove();
				});
				return false;
			});
		});
	</script>
	<script src="resources/js/lib/angular/angular.js"></script>
	<script src="resources/admin/js/admin.js"></script>
	<script src="resources/admin/js/services.js"></script>
	<script src="resources/admin/js/filters.js"></script>
	<script src="resources/admin/js/directives.js"></script>
</body>
</html>