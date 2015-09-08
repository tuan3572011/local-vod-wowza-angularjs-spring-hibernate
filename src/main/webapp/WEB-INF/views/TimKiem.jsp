<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.col2-fix {
	margin-right: 25px
}

.col1-fix {
	height: 200px;
	width: 50px;
}
</style>

<section>
	<div class="thumbnail thumb-fix2">
		<div class="row">
			<div class="clg-lg-12">
				<h4>{{result}} KẾT QUẢ VỚI TỪ KHÓA "{{dataSearch}}"</h4>
			</div>
		</div>
	</div>
	<!-- SEARCH -->

	<div class="thumbnail thumb-fix2" ng-if="result != 0">
		<div class="row">
			<div class="clg-lg-12">
				<article ng-controller="FilmRedirectController">
					<div class="row" style="margin-left: 10px">
						<div class="col-xs-12 col-sm-6 col-lg-2"
							style="margin-right: 80px" ng-repeat="movie in movies">
							<div class="thumbnail fix">
								<div class="caption">
									<header>
										{{movie.engName}} <br> <span>{{movie.vnName}}</span>
									</header>
									<footer>
										<a href='{{movie.trailer}}' data-toggle="lightbox"
											data-gallery="youtubevideos" class="btn btn-success">
											Trailer</a><a class="btn btn-info"
											data-ng-click="Redirect(movie.id,movie.type)">Chi tiết</a>
									</footer>
									<!-- /.modal-content -->
								</div>
								<div>
									<img class="fixImg" alt="..." src="{{movie.image}}"> <span
										class="badge bad-fix">IMDb: </span> <span
										class="badge bad-fix bad-fix2">{{movie.publishedYear }}</span>
								</div>
								<script type="text/javascript">
									$('.fix').hover(
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
						</div>
					</div>
				</article>
			</div>
		</div>
	</div>
	<!-- end SEARCH -->
	<hr>
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
							ng-click="nextHotMovies()" role="button" data-slide="next"> <span
							class="glyphicon glyphicon-chevron-right config-carousel"
							aria-hidden="true" style="font-size: 40px"></span> <span
							class="sr-only">Next</span>
						</a>
					</div>
				</div>
			</fieldset>
		</div>
	</article>
	<!-- end Phim hot -->

</section>


