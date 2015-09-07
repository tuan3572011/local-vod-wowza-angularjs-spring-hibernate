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
		<form action="${action }" method="POST" enctype="multipart/form-data">
			<div class="row">
				<input id="fileUpload" type="file" name="trailer"
					accept="application/octet-stream">
			</div>
			<input type="submit" class="button primary" value="SAVE">

		</form>
	</div>
	<!-- <script type="text/javascript">
		function setTrailerName() {
			var filePath = document.getElementById("fileUpload").value;
			document.getElementById("newTrailerName").value = filePath;
		}
	</script> -->
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
		opener.document.getElementById("trailer").value = url;
		window.close();
	}
</script>
</html>