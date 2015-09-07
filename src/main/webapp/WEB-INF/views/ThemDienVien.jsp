<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Them dien vien</title>
<link rel="stylesheet"
	href="/hcmuaf/resources/MetroUIBootstrap/css/metro.css" />

</head>
<body>
	<section style="width: 60%; margin: auto;">
		<form:form action="save" method="post" modelAttribute="starring">
			<div class="grid">
				<div class="row">

					<label style="text-align: right;">Chọn ảnh</label>
					<div class="input-control text full-size" onclick="uploadImage()">
						<form:input path="avatar" />
					</div>
				</div>
				<div class="row">
					<label>Tên diễn viên</label>
					<div class="input-control text full-size">
						<form:input path="name" />
					</div>
				</div>
				<div class="row">
					<label>Ngày sinh</label>
					<div class="input-control text full-size">
						<form:input path="birthDay" />
					</div>
				</div>
				<div class="row">
					<label>Nghề nghiệp</label>
					<div class="input-control text full-size">
						<form:input path="job" />
					</div>
				</div>
				<div class="row">
					<label>Quốc gia</label>
					<div class="input-control text full-size">
						<form:input path="country" />
					</div>
				</div>
				<div class="row ">
					<label>Chiều cao</label>
					<div class="input-control text full-size">
						<form:input path="height" />
					</div>
				</div>
				<div class="row ">
					<label>Cân nặng</label>
					<div class="input-control text full-size">
						<form:input path="weight" />
					</div>
				</div>
				<div class="row">
					<label>Sở thích</label>
					<div class="input-control text full-size">
						<form:input path="hobby" />
					</div>
				</div>
			</div>
			<button class="button primary">Save</button>
		</form:form>

		<p id="isOK">${message}</p>

		<script type="text/javascript">
			var message = document.getElementById("isOK").innerHTML;
			if (message != '') {
				localStorage.setItem('shouldUpdateStarringsJson', true);
				window.close();
			}
			function uploadImage() {
				window.open('/hcmuaf/UploadController/Image/Layout');
				return false;
			}
		</script>
	</section>
</body>
</html>