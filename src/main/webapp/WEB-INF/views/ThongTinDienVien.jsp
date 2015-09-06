<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div>
	<table style="width: 70%;">
		<tr>
			<td><label style="color: #A78613;">Tên diễn viên</label><br>
				<label> {{starring.name}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Ngày sinh</label><br> <label>{{starring.birthDay}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Nghề nghiệp</label><br>
				<label>{{starring.job}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Quốc gia</label><br> <label>
					{{starring.country}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Chiều cao</label><br> <label>
					{{starring.height}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Cân nặng</label><br> <label>
					{{starring.weight}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Sở thích</label><br> <label>
					{{starring.hobby}}</label></td>
		</tr>
	</table>

	<button ng-click="SearchFilm(starring.name)">Cac phim da
		tham gia</button>
</div>