<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form name="episodeForm" data-ng-submit="addEpisode(episode)">
	<div class="row">
		<input class="form-control form-fix" type="hidden" name="key" id="key"
			data-ng-model="episode.episode.movie_key" />
		<div class="col-xs-12 col-sm-6 col-lg-12 ">
			<label>Tên phim <font color="red">*</font></label>
			<!-- <div class="form-control form-control form-fix" data-role="select"
				data-multiple="false" data-placeholder="Select a movie serie">
				<select data-ng-model="episode.movieSerie" required="required"
					data-ng-options="movieSerie.vnName  for movieSerie in movieSeriesS">
				</select>
			</div> -->
			<select class="js-select form-control form-fix"
				data-ng-model="episode.episode.movieSerie" required="required"
				data-ng-options="movieSerie.vnName  for movieSerie in movieSeriesS">
			</select>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-12 ">
			<div class="form-group">
				<label for="episode">Tập <font color="red">*</font></label> <input
					class="form-control form-fix"
					data-ng-model="episode.episode.noEpisode" id="episode"
					required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-12 ">
			<div class="form-group">

				<label for="name">Upload Phim <font color="red">*</font></label> <input
					class="form-control form-fix" name="name" id="name"
					data-ng-model="episode.episode.name" onclick="uploadPhim();"
					required="required" />
			</div>

		</div>
		<div class="col-xs-12 col-sm-6 col-lg-12 ">
			<div class="form-group">
				<button type="submit" class="btn btn-primary" style="width: 160px;"
					data-ng-click="submitted=true" onclick="abc();">Save</button>
			</div>
		</div>
	</div>
</form>


<script>
	sessionStorage.removeItem("key");
	sessionStorage.removeItem("name");
	function abc() {
		var key = document.getElementById("key").value;
		var name = document.getElementById("name").value;

		sessionStorage.setItem("key", key);
		sessionStorage.setItem("name", name);
	}
	function uploadPhim() {
		window.open('UploadController/Film/Layout');
		return false;
	}
</script>

