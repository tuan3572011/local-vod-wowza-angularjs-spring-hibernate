<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div>
	<table style="width: 70%;">
		<tr>
			<td><label style="color: #A78613;">Tên đạo diễn</label><br>
				<label> {{director.name}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Ngày sinh</label><br> <label>{{director.birthday}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Quốc gia</label><br> <label>
					{{director.country}}</label></td>
		</tr>
	</table>

	<button>Cac phim da tham gia</button>
</div>