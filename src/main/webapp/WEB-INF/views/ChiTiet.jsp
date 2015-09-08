<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<style>
.col2-fix {
	margin-right: 25px
}

.col1-fix {
	height: 200px;
	width: 50px;
}

p.wrapBlock {
	width: 330px;
}
</style>

<section>
	<div>
		<!-- Chi tiết -->
		<article class="thumbnail thumb-fix2" style="margin-bottom: 0">
			<div class="row">
				<div class="col-xs-12 col-md-6 col-lg-4">
					<img alt="anh 1" src="{{movie.image}}" border="1px"
						style="width: 100%; max-width: 325px; height: 370px;" />
					<!-- User comment -->
				</div>
				<div class="col-xs-12 col-md-6 col-lg-8">
					<div style="height: 355px">
						<p>
							<a href='{{movie.trailer }}' data-toggle="lightbox"
								data-gallery="youtubevideos" class="btn btn-success">
								Trailer</a>
							<button ng-if="hasBought == 'FAIL'"
								data-ng-click="openRegisterDialog(movie)"
								class="btn btn-primary">Mua</button>
							<button ng-if="hasBought == 'OK'" class="btn btn-primary"
								data-ng-click="playMovie(movie)">Play</button>
						</p>
						<div>
							<h3 style="text-transform: uppercase;">{{movie.vnName}}</h3>
							<h4 style="text-transform: uppercase;">{{movie.engName}}</h4>
						</div>
						<table cellpadding="3" style="width: 70%;">
							<tr>
								<td><label style="color: #A78613;">Giá</label><br> <label>{{movie.price}}
										vnd</label></td>
								<td><label style="color: #A78613;">Thời lượng</label><br>
									<label>50 phút</label></td>
							</tr>
							<tr>
								<td><label style="color: #A78613;">Điểm IMDB</label><br>
									<label>{{movie.imdb}}</label></td>
								<td><label style="color: #A78613;">Số tập</label><br>
									<label>1</label></td>
							</tr>
							<tr>
								<td><label style="color: #A78613;">Quốc gia</label><br>
									<label ng-repeat="country in movie.countries">{{country.name}},
								</label></td>
								<td><label style="color: #A78613;">Năm sản xuất</label><br>
									<label>{{movie.publishedYear}}</label></td>
							</tr>
							<tr>
								<td><label style="color: #A78613;">Thể loại</label><br>
									<label ng-repeat="category in movie.categories">{{category.name}},
								</label></td>
								<td><label style="color: #A78613;">Đạo diễn</label><br>
									<label>{{movie.director.name}}</label></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</article>
		<!-- end chi tiết -->

		<!-- Bình luận & Nội dung -->
		<article class="thumbnail thumb-fix2">
			<hr>
			<div class="row">
				<div class="col-xs-12 col-md-6 col-lg-5">
					<label style="font-size: 30px">Bình Luận</label>

					<table class="table table-hover">
						<tr ng-repeat="comment in comments ">
							<td><img class="img-circle images" alt="Chèn ảnh"
								src="resources/images/img3.jpg" width="54px" height="54px"></td>
							<td style="color: black;"><label style="color: black"><strong><a
										href="#/canhan"><label><font color="#777777">{{comment.user.email}}</font>
												{{comment.time}}</label></a></strong></label>
								<p class="wrapBlock">
									<wbr>
									{{comment.content}}
									<wbr>
								</p></td>
						</tr>
					</table>
				</div>
				<div class="col-xs-12 col-md-6 col-lg-7">
					<label style="font-size: 18px; color: #440000;">Danh sách
						diễn viên</label> <br /> <br />
					<div style="margin: auto;">
						<div class="row">
							<div class="col-lg-2" ng-repeat="starring in starrings "
								style="margin-right: 10px">
								<div class="image-container"
									data-ng-click="showStarringDetail(starring)">
									<div class="capt-fix-act">
										<div class="caption"
											style="width: 110px; height: 110px; left: 15px;">
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
									$('.capt-fix-act').hover(
											function() {
												$(this).find('.caption')
														.slideDown(250); // .fadeIn(250)
											},
											function() {
												$(this).find('.caption')
														.slideUp(250); // .fadeOut(205)
											});
								</script>
							</div>
							<div class="col-xs-12 col-md-6  col-lg-1" style="height: 100px">
								<a class="right carousel-control" href=""
									style="background-image: none; padding-right: 70px"
									ng-click="nextStarring()" role="button" data-slide="next">
									<span class="glyphicon glyphicon-chevron-right config-carousel"
									aria-hidden="true"></span> <span class="sr-only">Next</span>
								</a>
							</div>
						</div>
					</div>
					<hr />

					<label>Nội dung:</label>
					<div data-ng-bind-html="movieInfo">
						<p></p>
					</div>
				</div>
			</div>
		</article>
		<!-- end bình luận -->

		<!-- Phim Liên Quan -->
		<article>
			<div class="thumbnail thumb-fix2">
				<fieldset>
					<legend>
						<label style="font-size: 30px">Phim Liên Quan</label>
					</legend>
					<div class="row">
						<div class="col-lg-2 col2-fix"
							ng-repeat="movie in relativeMovies track by movie.id">
							<div class="image-container"
								data-ng-click="showMovieDetail(movie.id)">
								<div class="capt-fix-act2">
									<div class="caption img-detail">
										<h4>{{movie.vnName}}</h4>
										<!-- /.modal-content -->
									</div>
									<div>
										<img alt="anh 1" ng-src="{{movie.image}}" class="img-detail" />
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
								style="background-image: none; padding-right: 60px"
								ng-click="nextRelativeMovies()" role="button" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right config-carousel"
								aria-hidden="true" style="font-size: 40px"></span> <span
								class="sr-only">Next</span>
							</a>
						</div>
					</div>
				</fieldset>
			</div>
		</article>
		<!-- end Phim Liên Quan -->

		<!-- Phim hot -->
		<article ng-controller="FilmRedirectController">
			<div class="thumbnail thumb-fix2">
				<fieldset>
					<legend>
						<label style="font-size: 30px">Phim Hot</label>
					</legend>
					<div class="row">
						<div class="col-lg-2 col2-fix"
							ng-repeat="movie in hotMovies track by movie.id">
							<div class="image-container">
								<div class="capt-fix-act2">
									<div style="cursor: pointer;" class="caption img-detail"
										ng-click="Redirect(movie.id,movie.type)">
										<h4>{{movie.vnName}}</h4>
										<!-- /.modal-content -->
									</div>
									<div>
										<img alt="anh 1" ng-src="{{movie.image}}" class="img-detail" />
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
								style="background-image: none; padding-right: 60px"
								ng-click="nextHotMovies()" role="button" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right config-carousel"
								aria-hidden="true" style="font-size: 40px"></span> <span
								class="sr-only">Next</span>
							</a>
						</div>
					</div>
				</fieldset>
			</div>
		</article>
		<!-- end Phim hot -->

	</div>
	<script type="text/javascript">
		var $el, $ps, $up, totalHeight;

		$(".sidebar-box .button").click(function() {

			totalHeight = 0;

			$el = $(this);
			$p = $el.parent();
			$up = $p.parent();
			$ps = $up.find("p:not('.read-more')");

			// measure how tall inside should be by adding together heights of all inside paragraphs (except read-more paragraph)
			$ps.each(function() {
				totalHeight += $(this).outerHeight();
			});

			$up.css({
				// Set height to prevent instant jumpdown when max height is removed
				"height" : $up.height(),
				"max-height" : 9999
			}).animate({
				"height" : totalHeight
			});

			// fade out read-more
			$p.fadeOut();

			// prevent jump-down
			return false;

		});
	</script>
	<script type="text/ng-template" id="myModalContent.html">
        <div class="modal-header">
            <h4>Đăng ký phim</h4>
        </div>
        <div class="modal-body">
            Bạn có muốn đăng kí phim {{film.vnName}} với giá {{film.price}}vnd ?
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary" ng-click="ok()">OK</button>
            <button class="btn btn-warning" ng-click="cancel()">Cancel</button>
        </div>
    </script>
</section>

