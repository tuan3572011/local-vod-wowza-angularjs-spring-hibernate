<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="datatables"
	uri="http://github.com/dandelion/datatables"%>

<section>
	<article>
		<div class="cell auto-size padding20 bg-white">
			<h1 class="text-light">Quản lý thẻ nạp</h1>
			<hr class="thin bg-grayLighter">
			<a class="button primary" class="login-window"><span
				class="mif-plus"></span>Tạo thẻ nạp mới</a> <a class="button warning"
				href="#/card"> <span class="mif-loop2"></span> Làm mới
			</a>
			<hr class="thin bg-grayLighter">
			<datatables:table id="vets" data="${cards }" cdn="true" row="card"
				cssClass="display" data-role="datatable">
				<datatables:column title="Seri" property="seri">
					<c:out value="${card.seri }"></c:out>
				</datatables:column>
				<datatables:column title="Giá trị thẻ nạp" property="value">
					<c:out value="${card.value }"></c:out>
				</datatables:column>
				<datatables:column title="Đã sử dụng" property="isUsed">
					<c:out value="${card.isUsed }"></c:out>
				</datatables:column>
			</datatables:table>
		</div>
	</article>
	<script type="text/javascript">
		
	</script>
</section>