<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
<!--
.fix {
	width: 250px;
	height: 300px;
	background-color: white;
	box-shadow: 0px 7px 10px -7px #000;
	-webkit-box-shadow: 0px 7px 10px -7px #000;
	border-radius: 0px;
}

.fixImg {
	width: 245px;
	height: 291px;
}

.stt {
	position: absolute;
	right: 32px;
	bottom: 40px;
	color: #ffd71a;
	font-size: 20px;
}

.input-fix {
	width: 100%;
	border-color: #FF6222
}

label {
	color: white;
}

.thumb-fix {
	border-top-right-radius: 4px;
	border-top-left-radius: 4px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
	margin-bottom: 0;
	padding: 6px;
	padding-bottom: 20px;
	background-color: #FF6222;
}

.thumb-fix2 {
	border-radius: 0;
	padding-top: 20px;
	padding-left: 20px;
	/* 	background: none;
 */
	border: none;
}

.bad-fix{
	background-color: #FFD614;
	color:black;
	text-shadow:0 1px 0 #F4E6A6;
	border-radius:0;
	left:0;
	bottom:22px;
	font-weight: bolder;
	
}
.bad-fix2{
	background-color: #DD1E35;
	color: white;
	text-shadow:0 1px 0 #F4E6A6;
	border-radius:0;
	bottom:22px;
	left:-4px;
}
-->
</style>

<section>
	<div class="container" style="width: 100%">
		<div class="thumbnail thumb-fix">
			<form action="#" method="get">
				<!--  OrderBy -->
				<div class="row">
					<div class="col-xs-12 col-sm-6 col-lg-3">
						<div class="input-control input-fix">
							<label><spring:message code="film.OrderBy" /></label> <select
								 name="orderBy">
								<option><spring:message code="film.View" /></option>
								<option><spring:message code="film.Rate" /></option>
								<option><spring:message code="film.Comment" /></option>
								<option selected="selected"><spring:message
										code="film.All" /></option>
							</select>
						</div>
					</div>

					<!--  Category -->
					<div class="col-xs-12 col-sm-6 col-lg-3">
						<div class="input-control input-fix">
							<label><spring:message code="film.Category" /></label> <select
								 name="category">
							</select>
						</div>
					</div>
					<!--  Publish Date -->
					<div class="col-xs-12 col-sm-6 col-lg-3">
						<div class="input-control input-fix">
							<label><spring:message code="film.PublishDate" /></label> <select
								 name="searchByYear">
								<option value="2015">2015</option>
								<option value="2014">2014</option>
								<option value="2013">2013</option>
								<option value="2012">2012</option>
								<option value="2011">2011 về trước</option>
								<option selected="selected"><spring:message
										code="film.All" /></option>
							</select>
						</div>
					</div>
					<!--  Country -->
					<div class="col-xs-12 col-sm-6 col-lg-3">
						<div class="input-control input-fix">
							<label><spring:message code="film.Country" /></label> <select
								 name="country">
								<option value="VN" <spring:message code="film.Country.VN" /> />
								<option selected="selected"><spring:message
										code="film.All" /></option>
							</select>
						</div>
					</div>
				</div>
			</form>
		</div>
		<div class="thumbnail thumb-fix2">
			<div class="row">
				<div class="clg-lg-12">
					<article ng-controller="FilmRedirectController">
						<div class="row" style="margin-left: 10px">
							<c:forEach items="${movies }" var="t">
								<div class="col-xs-12 col-sm-6 col-lg-2"
									style="margin-right: 80px">
									<div class="thumbnail fix">
										<div class="caption">
											<header>${t.engName}<span>${t.vnName}</span>
											</header>
											<footer>
												<button class="button success">Trailer</button>
												<a class="button info"
													data-ng-click="ChiTiet('${t.id }')">Chi tiết</a>
											</footer>
											<!-- /.modal-content -->
										</div>
										<div>
											<img class="fixImg" alt="..." src="${t.image}">
											<span class="badge bad-fix">IMDb: 7.3</span>
											<span class="badge bad-fix2">2015</span>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<script type="text/javascript">
							$('.fix').hover(function() {
								$(this).find('.caption').slideDown(250); // .fadeIn(250)
							}, function() {
								$(this).find('.caption').slideUp(250); // .fadeOut(205)
							});
						</script>
						<div style="padding-left: 30%;">
							<form>
								<input type="submit" name="home" value="&lt;&lt;"
									class="button rounded" /><input type="submit" name="prev"
									value="&lt;" class="button rounded" /> <input
									class="input-control text small-size" type="text" name="page"
									style="width: 50px;" />&nbsp; of <span>11 &nbsp;</span> <input
									class="button rounded" type="submit" name="next" value="&gt;" /><input
									class="button rounded" type="submit" name="home"
									value="&gt;&gt;" />
							</form>
						</div>
						<div data-role="dialog" id="dialog" class="padding10"
							data-close-button="true" data-type="success">
							<div
								style="height: 300px; width: 418px; overflow: auto; word-wrap: break-word;"
								id="containVideo">

								<h1 id="titleDialog">Simple dialog</h1>
								<button onclick="" class="button primary">Detail</button>
								<video width="400" controls="controls" id="videoDialog"
									class="video-js vjs-default-skin">
									<!-- onmouseleave="pauseVideo(this)"
						onmouseenter="playVideo(this)" -->
									<source src="http://video-js.zencoder.com/oceans-clip.mp4"
										type="video/mp4" id="videoSource" />
								</video>
								<p id="contentDialog"></p>
							</div>
						</div>
						<script>
							var player = videojs('videoDialog');
							function pauseVideo(video) {
								player.pause();
							}

							function playVideo(video) {
								player.play();
							}
							function showDialog(id, name) {
								$(document)
										.ready(
												function() {
													player.dispose();
													var title = $("#titleDialog");
													var content = $("#contentDialog");
													title.text("I am " + name);
													content
															.text("I am content asdfsfda"
																	+ name);

													$("#videoDialog").remove();
													var source = '<video width="400" controls="controls"  id="videoDialog" class="video-js vjs-default-skin" onmouseleave="pauseVideo(this)"	onmouseenter="playVideo(this)">';
													source = source
															+ '<source src="http://video-js.zencoder.com/oceans-clip.mp4" type="video/mp4" id="videoSource" > </source> </video>';
													/* resources/Microsoft.mp4 
													
													 */

													source = source + "";
													source = source.replace(
															"Microsoft", name);
													$("#containVideo").append(
															source);
													player = videojs('videoDialog');

													var dialog = $("#dialog")
															.data('dialog');
													dialog.open();
													$("#containVideo").animate(
															{
																scrollTop : 0
															}, 800);

												});
							}
						</script>
					</article>
				</div>
			</div>
		</div>
	</div>
</section>

