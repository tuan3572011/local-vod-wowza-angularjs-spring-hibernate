<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div ng-controller="ThemPhimController">

	<section style="width: 80%; margin: auto" class="thumbnail">

		<ul class="nav nav-tabs nav-justified" role="tablist"
			style="padding: 10px">
			<li role="presentation" class="active"><a href=""
				aria-controls="movieSerie" role="tab" name="searchBy"
				data-toggle="tab" ng-click="loadPage('movieSerie')">Thêm phim bộ</a></li>
			<li role="presentation"><a href="" aria-controls="episode"
				role="tab" data-toggle="tab" ng-click="loadPage('episode')"
				name="searchBy">Thêm tập phim</a></li>
			<li role="presentation"><a href="" aria-controls="movie"
				role="tab" data-toggle="tab" name="searchBy"
				ng-click="loadPage('movie')">Thêm phim lẻ</a></li>
		</ul>

		<div class="animate-switch-container" ng-switch on="selection"
			style="padding: 20px">
			<div class="animate-switch" ng-switch-when="movieSerie">
				<div ng-include src="'ThemPhimController/ThemMovieSerie/Layout'"></div>
			</div>
			<div class="animate-switch" ng-switch-when="episode">
				<div ng-include src="'ThemPhimController/ThemEpisode/Layout'"></div>
			</div>

			<div class="animate-switch" ng-switch-when="movie">
				<div ng-include src="'ThemPhimController/ThemMovie/Layout'"></div>
			</div>
		</div>
	</section>
</div>

<link rel="stylesheet" href="resources/trumbo/trumbowyg.min.css">
<link rel="stylesheet" href="resources/trumbo/trumbowyg.colors.min.css">
<script src="resources/trumbo/highlight.js"></script>
<script src="resources/trumbo/main.js"></script>
<script src="resources/trumbo/modernizr-2.6.4-respond-1.1.0.min.js"></script>
<script src="resources/trumbo/trumbowyg.min.js"></script>
<script src="resources/trumbo/trumbowyg.base64.min.js"></script>
<script src="resources/trumbo/trumbowyg.colors.min.js"></script>
<script src="resources/trumbo/trumbowyg.upload.min.js"></script>
<!-- Trong khi do -->
