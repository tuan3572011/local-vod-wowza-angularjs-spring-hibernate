<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div ng-controller="CaNhanController">

	<section style="width: 80%; margin: auto" class="thumbnail">

		<ul class="nav nav-tabs nav-justified" role="tablist"
			style="padding: 10px">
			<li role="presentation" class="active"><a href=""
				aria-controls="canhan" role="tab" name="searchBy" data-toggle="tab"
				ng-click="loadPage('canhan')">Thông tin cá nhân</a></li>
			<li role="presentation"><a href="" aria-controls="recharge"
				role="tab" data-toggle="tab" ng-click="loadPage('recharge')"
				name="searchBy">Nạp thẻ</a></li>
			<li role="presentation"><a href="" aria-controls="history"
				role="tab" data-toggle="tab" name="searchBy"
				ng-click="loadPage('history')">Lịch sử giao dịch</a></li>
		</ul>

		<div class="animate-switch-container" ng-switch on="selection"
			style="padding: 20px">
			<div class="animate-switch" ng-switch-when="canhan">
				<div ng-include src="'CaNhanController/thongtin/layout'"></div>
			</div>
			<div class="animate-switch" ng-switch-when="recharge">
				<div ng-include src="'CaNhanController/recharge/layout'"></div>
			</div>

			<div class="animate-switch" ng-switch-when="history">
				<div ng-include src="'CaNhanController/history/layout'"></div>
			</div>
		</div>
	</section>
</div>
