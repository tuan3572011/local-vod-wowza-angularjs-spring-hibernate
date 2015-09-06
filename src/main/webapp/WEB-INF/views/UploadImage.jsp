<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link href="/hcmuaf/resources/MetroUIBootstrap/css/metro-icons.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="/hcmuaf/resources/MetroUIBootstrap/css/metro.css" />

</head>
<body>
	<div class="grid">
		<c:url var="action" value="Save" />
		<div style="margin-left: 25%; margin-right: 25%; margin-top: 2%">
			<form action="${action}" method="POST" enctype="multipart/form-data">
				<div class="row">
					<label>Nơi chứa ảnh</label><input id="fileUpload" type="file"
						name="image" accept="image/x-png, image/gif, image/jpeg">
				</div>
				<input type="submit" class="button primary" value="SAVE">
			</form>
		</div>
	</div>
	<c:if test="${!empty message }">
		<label>url</label>
		<br>
		<p id="url">${message }</p>
	</c:if>
</body>

<script type="text/javascript">
	var url = document.getElementById("url").innerHTML;
	if (url != '') {
		var opener = window.opener;
		opener.document.getElementById("avatar").value = url;
		window.close();
	}
</script>
</html>