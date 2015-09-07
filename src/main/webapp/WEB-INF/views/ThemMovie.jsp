<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form name="movieForm" data-ng-submit="addMovie(movie)">
	<div class="row">
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label for="name">Upload Phim <font color="red">*</font></label> <input
					class="form-control form-fix" name="name" id="name"
					onclick="uploadPhim();" readonly="readonly" required="required"
					data-ng-model="movie.movie.name" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Tên tiếng Anh <font color="red">*</font></label> <input
					class="form-control form-fix" data-ng-model="movie.movie.engName"
					name="engName" required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">

				<label>Tên tiếng Việt <font color="red">*</font></label> <input
					class="form-control form-fix" data-ng-model="movie.movie.vnName"
					name="vnName" required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Điểm IMDB <font color="red">*</font></label> <input
					class="form-control form-fix" data-ng-model="movie.movie.imdb"
					name="imdb" required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Trailer <font color="red">*</font></label><label
					onclick="uploadTrailer();" class="add">Thêm</label><input
					class="form-control form-fix" name="trailer"
					data-ng-model="movie.movie.trailer" id="trailer" required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Giá <font color="red">*</font></label> <input
					class="form-control form-fix" data-ng-model="movie.movie.price"
					name="price" required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Năm phát hành <font color="red">*</font></label> <input
					class="form-control form-fix" data-ng-model="movie.movie.publishedYear"
					name="publishedYear" required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">

				<label>Poster <font color="red">*</font></label><label
					onclick="uploadImage();" class="add">Thêm</label> <input
					class="form-control form-fix" name="avatar"
					data-ng-model="movie.movie.image" id="avatar" required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Đạo diễn <font color="red">*</font></label><label
					onclick="addDirector();" class="add">Thêm</label>
				<div data-ng-click="shouldUpdateDirectorsJson()">
					<select class="js-example-placeholder-single form-control form-fix"
						data-ng-model="movie.movie.director" name="director"
						data-ng-options="director.name  for director in directorsS">
					</select>
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Ngôi sao <font color="red">*</font></label> <label
					onclick="addStarring();" class="add">Thêm</label>
				<div data-role="select" data-multiple="true"
					data-ng-click="shouldUpdateStarringsJson()">
					<select multiple="multiple" data-ng-model="movie.movie.starrings"
						name="starrings"
						class="js-example-basic-multiple form-control form-fix"
						data-ng-options="starring.name  for starring in starringsS"
						required="required">
					</select>
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Quốc gia <font color="red">*</font></label>
				<div data-role="select" data-multiple="true"
					data-placeholder="Select a state">
					<select multiple="multiple" data-ng-model="movie.movie.countries"
						required="required" name="countries"
						class="js-example-basic-multiple form-control form-fix"
						data-ng-options="country.name  for country in countriesS">
					</select>
				</div>
			</div>
		</div>

		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Thể loại <font color="red">*</font></label>
				<div data-role="select" data-multiple="true"
					data-placeholder="Select a state">
					<select multiple="multiple" data-ng-model="movie.movie.categories"
						name="categories" required="required"
						class="js-example-basic-multiple form-control form-fix"
						data-ng-options="category.name  for category in categoriesS">
					</select>
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-sm-12 col-lg-12">
			<div class="form-group">
				<label>Tóm tắt nội dung <font color="red">*</font></label>
				<textarea id="trumbowyg-demo" required="required" name="info"></textarea>
			</div>
		</div>

		<div class="col-xs-12 col-sm-12 col-lg-12">
			<button type="submit" class="btn btn-primary" style="width: 160px;"
				data-ng-click="submitted=true" onclick="abc();">Save</button>
		</div>
		<input class="form-control form-fix" type="hidden" name="key" id="key"
			data-ng-model="movie.movie.movie_key" />
	</div>
</form>




<script type="text/javascript">
	$('select').select2();
	sessionStorage.removeItem("info");
	sessionStorage.removeItem("key");
	sessionStorage.removeItem("image");
	sessionStorage.removeItem("trailer");
	sessionStorage.removeItem("name");
	function abc() {
		var info = document.getElementById("trumbowyg-demo").value;
		var key = document.getElementById("key").value;
		var image = document.getElementById("avatar").value;
		var trailer = document.getElementById("trailer").value;
		var name = document.getElementById("name").value;

		sessionStorage.setItem("info", info);
		sessionStorage.setItem("key", key);
		sessionStorage.setItem("image", image);
		sessionStorage.setItem("trailer", trailer);
		sessionStorage.setItem("name", name);
	}

	function uploadImage() {
		window.open('UploadController/Image/Layout');
		return false;
	}
	function addStarring() {
		window.open('DienVienController/layout');
		return false;
	}
	function addDirector() {
		window.open('DaoDienController/layout');
		return false;
	}
	function uploadPhim() {
		window.open('UploadController/Film/Layout');
		return false;
	}

	function uploadTrailer() {
		window.open('UploadController/Trailer/Layout');
		return false;
	}
</script>


<script type="text/javascript">
	$('#trumbowyg-demo').trumbowyg(
			{
				btnsDef : {
					// Customizables dropdowns
					image : {
						dropdown : [ 'insertImage', 'upload', 'base64' ],
						ico : 'insertImage'
					}
				},
				btns : [ 'viewHTML', '|', 'formatting', '|', 'btnGrp-design',
						'|', 'link', '|', 'image', '|', 'btnGrp-justify', '|',
						'btnGrp-lists', '|', 'foreColor', 'backColor', '|',
						'horizontalRule' ]
			});
</script>




