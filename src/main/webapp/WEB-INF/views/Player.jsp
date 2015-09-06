<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="resources/videojs/video.js"></script>
<script src="resources/videojs/videojs-hls.js"></script>
<link href="resources/videojs/video-js.css" rel="stylesheet">
<script>
	videojs.options.flash.swf = "resources/videojs/video-js.swf";
</script>
<!-- Media Sources plugin -->
<script src="resources/videojs/videojs-media-sources.js"></script>

<!-- HLS plugin -->

<!-- segment handling -->
<script src="resources/videojs/segment/xhr.js"></script>
<script src="resources/videojs/segment/flv-tag.js"></script>
<script src="resources/videojs/segment/stream.js"></script>
<script src="resources/videojs/segment/exp-golomb.js"></script>
<script src="resources/videojs/segment/h264-stream.js"></script>
<script src="resources/videojs/segment/aac-stream.js"></script>
<script src="resources/videojs/segment/metadata-stream.js"></script>
<script src="resources/videojs/segment/segment-parser.js"></script>

<!-- m3u8 handling -->
<script src="resources/videojs/segment/m3u8/m3u8-parser.js"></script>
<script src="resources/videojs/segment/playlist-loader.js"></script>

<script src="resources/videojs/pkcs7.unpad.js"></script>
<script src="resources/videojs/segment/decrypter.js"></script>

<script src="resources/videojs/segment/bin-utils.js"></script>



<style>
<!--
label {
	font-size: 14px;
	color: #a78613;
}

p {
	font-size: 16px;
}

.btn-fix {
	width: 75px;
	margin-bottom: 5px;
	margin-right: 5px;
}

.images {
	box-shadow: 1.5px 1.5px 6px #888888;
	background: #BADA55;
	padding: 2px;
	display: inline;
	width: 54px;
	height: 54px
}

.container {
	width: 960px;
}

.col2-fix {
	margin-right: 15px
}

.col1-fix {
	height: 150px
}

p.wrapBlock {
	width: 650px;
}
-->
</style>

<style>
.vjs-quality-button {
	padding: 0 0.6em !important;
	width: auto !important;
}

.vjs-quality-button div {
	width: auto !important;
	background: none !important;
}
</style>

<section>
	<!-- 	<div ng-controller="SerieController"> -->
	<article>
		<!-- Header -->
		<header id="top" class="header">
			<div class="text-vertical-center" id="containVideo"></div>
		</header>
	</article>
	<article>
		<label>Chất lượng phim: </label> <select name=“quality”>
			<option onclick="reloadVideo('.smil');">Auto</option>
			<option onclick="reloadVideo('_480.mp4');">480p</option>
			<option onclick="reloadVideo('.mp4');">720p</option>
		</select>
	</article>
	<article>
		<section id="service" class="service bg-primary"
			style="padding: 10px; background-color: #1a1917">
			<div class="container">
				<div class="row">
					<div class="col-xs-12 col-md-6  col-lg-12">
						<a class="btn btn-warning"> <span
							class="glyphicon glyphicon-warning-sign"></span> Báo phim lỗi
						</a> <a class="btn btn-primary"> <span
							class="glyphicon glyphicon-off"></span> Tắt đèn
						</a>
					</div>
				</div>
				<!-- /.row -->
			</div>
			<!-- /.container -->
		</section>
	</article>
	<!-- About -->
	<article id="about" class="about bg-primary"
		style="padding: 10px; background-color: #1a1917">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-md-6   col-lg-3">
					<img alt="Chèn ảnh" src="{{movie.image}}"
						style="width: 210px; height: 326px">
					<div>
						<label>Đánh giá phim:</label><br> <input id="input-id"
							data-min="0" data-max="5" data-step="1" data-size="xs">
					</div>
				</div>
				<div class="col-xs-12 col-md-6  col-lg-9">
					<h3 style="color: #f5cc2a">{{movie.engName}}</h3>
					<h3 style="color: #f5cc2a">{{movie.vnName}}</h3>
					<label>Thể loại:</label>
					<p>
						<label ng-repeat="category in movie.categories">{{category.name}},
						</label>
					</p>

					<label style="font-size: 18px;">Danh sách diễn viên</label> <br />
					<br />
					<div class="row">
						<div class="col-xs-12 col-md-6  col-lg-2"
							ng-repeat="starring in starrings " style="margin-right: 5px">
							<div class="image-container"
								data-ng-click="showStarringDetail(starring.id)">
								<div class="capt-fix-act">
									<div class="caption" style="width: 110px; height: 110px">
										<h4>{{starring.name}}</h4>
										<!-- /.modal-content -->
									</div>
									<div class="frame">
										<img alt="anh 1" ng-src="{{starring.avatar}}"
											style="height: 110px; width: 110px" />
									</div>

								</div>

							</div>
							<script type="text/javascript">
								$('.capt-fix-act').hover(function() {
									$(this).find('.caption').slideDown(250); // .fadeIn(250)
								}, function() {
									$(this).find('.caption').slideUp(250); // .fadeOut(205)
								});
							</script>
						</div>
						<div class="col-xs-12 col-md-6  col-lg-1" style="height: 100px">
							<a class="right carousel-control" href=""
								style="background-image: none; padding-right: 70px"
								ng-click="nextStarring()" role="button" data-slide="next"> <span
								class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
								<span class="sr-only">Next</span>
							</a>
						</div>
					</div>
					<br>
					<div>
						<label>Nội dung:</label>
						<div data-ng-bind-html="movieInfo"></div>
					</div>
				</div>
			</div>
		</div>
	</article>

	<!-- BÌNH LUẬN -->
	<article id="about" class="about"
		style="background-color: white; padding-bottom: 0;">
		<div class="container" style="width: 930px">
			<div class="row">
				<div class="col-xs-12 col-md-6  col-lg-12 text-left">
					<fieldset>
						<legend style="font-size: 30px">Bình Luận</legend>
						<form action="">
							<div class="input-control textarea">
								<textarea ng-model="commentContent" class="form-control"
									name="_txtComment" id="_txtComment" rows="3"
									style="width: 900px" spellcheck="false" maxlength="900px"
									placeholder="Hãy chia sẻ cảm nhận của bạn về bộ phim."
									class="comment-textarea"></textarea>

							</div>
							<button class="btn btn-success"
								ng-click="addComment(commentContent);">Bình luận</button>
						</form>
					</fieldset>
				</div>
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container -->
	</article>


	<article id="about" class="about thumbnail">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-md-6  col-lg-12"
					style="width: 100%; overflow: auto; max-width: 920px; max-height: 350px;">
					<div style="word-wrap: break-word;">
						<table class="table table-hover" style="width: 900px">
							<tr ng-repeat="comment in comments ">
								<td style="width: 100px"><img class="img-circle images"
									alt="Chèn ảnh" src="resources/images/img3.jpg" width="54px"
									height="54px"></td>
								<td style="width: 650px"><label style="color: black"><strong><a
											href="#/canhan"><label><font color="#777777">{{comment.user.email}}</font></label></a></strong></label>
									<p class="wrapBlock">
										<wbr>
										{{comment.content}}
										<wbr>
									</p></td>
								<td>{{comment.time}}</td>
							</tr>
						</table>

					</div>
				</div>
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container -->
	</article>
	<!-- END Bình Luận -->

	<!-- Phim Liên Quan -->
	<article id="about" class="thumbnail thumb-fix2">
		<fieldset>
			<legend>
				<label style="font-size: 30px">Phim Liên Quan</label>
			</legend>
			<div class="row">
				<div class="col-xs-12 col-md-6  col-lg-2 col2-fix"
					ng-repeat="movie in relativeMovies">
					<div class="image-container"
						data-ng-click="showMovieDetail(movie.id)">
						<div class="capt-fix-act2">
							<div class="caption img-detailmovie" style="left: 15px;">
								<h4>{{movie.vnName}}</h4>
								<!-- /.modal-content -->
							</div>
							<div>
								<img alt="anh 1" ng-src="{{movie.image}}"
									class="img-detailmovie" />
							</div>

						</div>
					</div>
					<script type="text/javascript">
						$('.capt-fix-act2').hover(function() {
							$(this).find('.caption').slideDown(250); // .fadeIn(250)
						}, function() {
							$(this).find('.caption').slideUp(250); // .fadeOut(205)
						});
					</script>
				</div>
				<div class="col-xs-12 col-md-6  col-lg-1 col1-fix">
					<a class="right carousel-control" href=""
						style="background-image: none; padding-right: 100px"
						ng-click="nextRelativeMovies()" role="button" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right config-carousel"
						aria-hidden="true" style="font-size: 40px"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</fieldset>
	</article>
	<!-- end Phim Liên Quan -->

	<!-- Phim hot -->
	<article id="about" class="thumbnail thumb-fix2">
		<fieldset>
			<legend>
				<label style="font-size: 30px">Phim Hot</label>
			</legend>
			<div class="row">
				<div class="col-xs-12 col-md-6  col-lg-2 col2-fix"
					ng-repeat="movie in hotMovies">
					<div class="image-container"
						data-ng-click="showMovieDetail(movie.id)">
						<div class="capt-fix-act2">
							<div class="caption img-detailmovie">
								<h4>{{movie.vnName}}</h4>
								<!-- /.modal-content -->
							</div>
							<div>
								<img alt="anh 1" ng-src="{{movie.image}}"
									class="img-detailmovie" />
							</div>

						</div>
					</div>
					<script type="text/javascript">
						$('.capt-fix-act2').hover(function() {
							$(this).find('.caption').slideDown(250); // .fadeIn(250)
						}, function() {
							$(this).find('.caption').slideUp(250); // .fadeOut(205)
						});
					</script>
				</div>
				<div class="col-xs-12 col-md-6  col-lg-1 col1-fix">
					<a class="right carousel-control" href=""
						style="background-image: none; padding-right: 100px"
						ng-click="nextHotMovies()" role="button" data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right config-carousel"
						aria-hidden="true" style="font-size: 40px"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</fieldset>
	</article>
	<!-- end Phim hot -->
</section>
<!-- 
      -- Now, initialize your player. That's it! 
      -->
<script type="text/javascript">
	$("#input-id").rating({
		starCaptions : {
			1 : "Very Poor",
			2 : "Poor",
			3 : "Ok",
			4 : "Good",
			5 : "Very Good"
		},
		starCaptionClasses : {
			1 : "label label-danger",
			2 : "label label-warning",
			3 : "label label-info",
			4 : "label label-primary",
			5 : "label label-success"
		},
	});
</script>
<script>
	var player;
	function playVideo(videoShortType) {
		$(document)
				.ready(
						function() {
							var source = '<video width="930" height="500" controls  id="video" class="video-js vjs-default-skin" preload="none" >';
							source = source
									+ '<source src="http://54.255.224.27:1935/vod-project/Microsoft/playlist.m3u" type="application/x-mpegurl" id="videoSource" /> </video>';
							source = source + " ";
							var videoName = sessionStorage.getItem("source");
							source = source.replace("Microsoft", videoName);
							source = source.replace(".mp4", videoShortType);
							$("#containVideo").append(source);

							player = videojs('video');
						});
	}
	function reloadVideo(videoShortType) {
		$(document)
				.ready(
						function() {
							if ((player !== undefined) && (player !== null)) {
								player.dispose();
								$("#video").remove();
							}

							var source = '<video width="930" height="500" controls  id="video" class="video-js vjs-default-skin" preload="none" >';
							source = source
									+ '<source src="http://54.255.224.27:1935/vod-project/Microsoft/playlist.m3u"  type="application/x-mpegurl" id="videoSource" /> </video>';
							source = source + " ";
							var videoName = sessionStorage.getItem("source");
							source = source.replace("Microsoft", videoName);
							source = source.replace(".mp4", videoShortType);
							$("#containVideo").append(source);

							player = videojs('video');
						});
	}
	playVideo(".smil");
</script>

