<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="container" style="margin: auto;">
	<div class="row">
		<div class="col-lg-7">
			<form class="form-horizontal" data-toggle="validator"
				data-ng-submit="RegisterUser(user)">
				<legend>
					<h2>ĐĂNG KÝ</h2>
				</legend>
				<h4>Thông tin tài khoản:</h4>
				<div class="well">
					<div class="form-group">
						<label for="username" class="col-sm-3 control-label">Email
							(*):</label>
						<div class="col-sm-5">
							<input type="text" class=" form-control" id="username"
								data-ng-model="user.email" placeholder="Username"
								name="username" value="" required="required"
								data-error="Trường email không được để trống">
							<div class="help-block with-errors">${errNa }</div>
						</div>
					</div>
					<div class="form-group">
						<label for="password" class="col-sm-3 control-label">Password
							(*)</label>
						<div class="col-sm-4">
							<input type="password" class="form-control" id="password"
								data-ng-model="user.password" name="password"
								placeholder="Password" required
								data-error="Trường password không được để trống">
						</div>
						<div class="col-sm-4">
							<input type="password" class="form-control" id="password2"
								data-match="#password"
								data-match-error="Trường nhập lại không giống"
								placeholder="Nhập lại password" required
								data-error="Trường nhập lại password không được để trống">
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label for="fullname" class="col-sm-3 control-label">Tên
							hiển thị:</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="fullname"
								data-ng-model="user.userName" placeholder="Họ và tên"
								name="fullname" value="">
							<p class="help-block"></p>
						</div>
					</div>
					<div class="form-group">
						<label for="phone" class="col-sm-3 control-label">Số Điện
							Thoại:</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="phone"
								data-ng-model="user.phone" placeholder="Số Điện Thoại"
								name="phoneNumber" value="">
							<p class="help-block"></p>
						</div>
					</div>
					<div class="form-group">
						<label for="address" class="col-sm-3 control-label">Địa
							chỉ:</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="address"
								data-ng-model="user.address" placeholder="Địa chỉ"
								name="address" value="">
							<p class="help-block"></p>
						</div>
					</div>
					<div class="form-group">
						<label for="gend" class="col-sm-3 control-label">Giới
							Tính:</label>
						<div class="col-sm-6" id="gend">
							<label class="radio-inline"> <input type="radio"
								data-ng-model="user.gender" value="Male" name="gender"
								required="required" data-error="Hãy chọn giới tính!">
								Nam
							</label> <label class="radio-inline"> <input type="radio"
								data-ng-model="user.gender" value="Female" name="gender"
								required="required"> Nữ
							</label>
							<div class="help-block with-errors"></div>
						</div>
					</div>
				</div>

				<div class="form-group">
					<div class="col-md-2 col-sm-offset-3">
						<input class="btn btn-success" type="submit" class="form-control"
							data-ng-click="submitted=true" value="Đăng Ký">
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- /.container -->



<!-- Bootstrap core JavaScript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="<c:url value="/resources/front_end/js/jquery-1.10.2.js"/>"></script>
<script src="<c:url value="/resources/front_end/js/bootstrap.js"/>"></script>
<script src="<c:url value="/resources/front_end/js/holder.js"/>"></script>
<script src="<c:url value="/resources/front_end/js/validator.js"/>"></script>



