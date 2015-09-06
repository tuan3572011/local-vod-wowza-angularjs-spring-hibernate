<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div>
	<table style="width: 70%;">
		<tr>
			<td><label style="color: #A78613;">Email</label><br> <label>
					{{user.email}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Số dư tài khoản</label><br>
				<label>{{user.accountAmount}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Số điện thoại</label><br>
				<label>{{user.phone}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Giới tính</label><br> <label>
					{{user.gender}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Địa chỉ</label><br> <label>
					{{user.address}}</label></td>
		</tr>
		<tr>
			<td><label style="color: #A78613;">Ngày sinh</label><br> <label>
					{{user.birthDay}}</label></td>
		</tr>

	</table>
</div>