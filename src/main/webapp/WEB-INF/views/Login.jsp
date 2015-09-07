<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
<!--
.control-label {
	color: black;
}
-->
</style>

<div class="container">
	<form role="form" data-toggle="validator" class="form-signin"
		name="loginForm" data-ng-submit="login(login)">
		<div class="form-group">
			<label for="inputSuccess2" class="control-label">Email:</label> <input
				name="username" id="inputSuccess2" type="text" class="form-control"
				required data-ng-model="login.email" />
			<div class="help-block with-errors" style="color: red"></div>
		</div>
		<div class="form-group">
			<label for="password" class="control-label">Password:</label> <input
				type="password" name="password" class="form-control" required
				data-ng-model="login.password" />
			<div class="help-block with-errors" style="color: red"></div>
		</div>
		<div class="form-group">
			<input class="form-control btn btn-success" type="submit"
				data-ng-click="submitted=true" value="Đăng Nhập">
		</div>
		<div class="form-group" style="margin-top: -10px;">
			<a href="#/DangKy" class="form-control btn btn-primary">Đăng
				Ký</a>
		</div>
		<div class="form-group">
			<a style="font-size: 18px;" href="resetPass">Quên mật khẩu?</a>
		</div>

	</form>
</div>






