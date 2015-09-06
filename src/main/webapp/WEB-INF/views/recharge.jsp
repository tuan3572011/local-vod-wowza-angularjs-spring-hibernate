<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div>
	<table style="width: 70%;">
		<tr>
			<td><label style="font-size: 18px; color: #A78613;">Nhập
					mã số card</label></td>
		</tr>
		<tr>
			<td><input ng-model="seri" type="text" class="form-control"
				required />
				<br></td>
		</tr>
		<tr>
			<td><input class="form-control btn btn-success" type="submit"
				data-ng-click="addCard(seri)" value="Nạp Card"></td>
		</tr>
	</table>
</div>