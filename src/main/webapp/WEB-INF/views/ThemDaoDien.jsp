<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Them dao dien</title>
<link rel="stylesheet"
	href="/hcmuaf/resources/MetroUIBootstrap/css/metro.css" />

</head>
<body>
	<section style="width: 60%; margin: auto;">
		<form:form action="save" method="post" modelAttribute="director">
			<div class="grid">
				<div class="row">

					<label style="text-align: right;">Chọn ảnh</label>
					<div class="input-control text full-size" onclick="uploadImage()">
						<form:input path="avatar" />
					</div>
				</div>
				<div class="row">
					<label>Tên đạo diễn</label>
					<div class="input-control text full-size">
						<form:input path="name" />
					</div>
				</div>
				<div class="row">
					<label>Ngày sinh</label>
					<div class="input-control text full-size">
						<form:input path="birthday" />
					</div>
				</div>
				<div class="row">
					<label>Quốc gia</label>
					<div class="input-control text full-size">
						<form:input path="country" />
					</div>
				</div>
			</div>
			<button class="button primary">Save</button>
		</form:form>

		<p id="isOK">${message}</p>

		<script type="text/javascript">
			var message = document.getElementById("isOK").innerHTML;
			if (message != '') {
				localStorage.setItem('shouldUpdateDirectorsJson', true);
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