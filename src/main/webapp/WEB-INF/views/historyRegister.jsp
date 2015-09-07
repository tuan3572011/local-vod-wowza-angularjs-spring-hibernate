<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div>
	<table style="width: 100%; border: 1px solid; min-height: 200px;">
		<thead style="text-align: center; background: #99FFCC;">
			<tr>
				<th>STT</th>
				<th>Tên Phim</th>
				<th>Ngày Đăng Ký</th>
				<th>Thời Gian Còn Lại</th>
			</tr>
		</thead>
		<tbody ng-repeat="regis in registers">
			<tr>
				<td></td>
				<td>{{regis.movieName}}</td>
				<td>{{regis.regisDate}}</td>
				<td>{{regis.minutesLeft}} phút</td>
			</tr>
		</tbody>
	</table>
</div>