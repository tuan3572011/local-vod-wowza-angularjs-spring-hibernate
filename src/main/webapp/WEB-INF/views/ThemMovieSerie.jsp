<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form name="movieSerieForm" data-ng-submit="addSerieMovie(serie)">
	<div class="row">
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<div class="form-group">
					<label for="avatar">Poster <font color="red">*</font></label><label
						onclick="uploadImage();" class="add">Thêm</label> <input
						type="text" class="form-control form-fix" name="avatar"
						id="avatar" required="required" />
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<div class="form-group">
					<label for="engName">Tên tiếng Anh <font color="red">*</font></label>
					<input class="form-control form-fix"
						data-ng-model="serie.serie.engName" id="engName" name="engName"
						required="required" />
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Tên tiếng Việt <font color="red">*</font></label> <input
					class="form-control form-fix" data-ng-model="serie.serie.vnName"
					name="vnName" required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Điểm IMDB <font color="red">*</font></label> <input
					class="form-control form-fix" data-ng-model="serie.serie.imdb"
					name="imdb" required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Trailer <font color="red">*</font></label><label
					onclick="uploadTrailer();" class="add">Thêm</label> <input
					class="form-control form-fix" name="trailer" id="trailer"
					required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Giá <font color="red">*</font></label> <input
					class="form-control form-fix" data-ng-model="serie.serie.price"
					name="price" required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Năm phát hành <font color="red">*</font></label> <input
					class="form-control form-fix"
					data-ng-model="serie.serie.publishedYear" name="publishedYear"
					required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Tổng số tập <font color="red">*</font></label> <input
					class="form-control form-fix"
					data-ng-model="serie.serie.numEpisodes" name="numEpisodes"
					required="required" />
			</div>
		</div>
		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Đạo diễn <font color="red">*</font></label><label
					onclick="addDirector();" class="add">Thêm</label>
				<div data-ng-click="shouldUpdateDirectorsJson()">
					<select class="js-example-placeholder-single form-control form-fix"
						data-ng-model="serie.serie.director" name="director"
						data-ng-options="director.name  for director in directorsS"
						required="required">
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
					<select multiple="multiple" data-ng-model="serie.serie.starrings"
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
					<select multiple="multiple" data-ng-model="serie.serie.countries"
						name="countries"
						data-ng-options="country.name  for country in countriesS"
						required="required"
						class="js-example-basic-multiple form-control form-fix">
					</select>
				</div>
			</div>
		</div>

		<div class="col-xs-12 col-sm-6 col-lg-6">
			<div class="form-group">
				<label>Thể loại <font color="red">*</font></label>
				<div data-role="select" data-multiple="true"
					data-placeholder="Select a state">
					<select multiple="multiple" data-ng-model="serie.serie.categories"
						name="categories"
						data-ng-options="category.name  for category in categoriesS"
						required="required"
						class="js-example-basic-multiple form-control form-fix">
					</select>
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-sm-12 col-lg-12">
			<div class="form-group">
				<label>Tóm tắt nội dung <font color="red">*</font></label>
				<textarea id="trumbowyg-demo" name="info" required="required"></textarea>
			</div>
		</div>
		<div class="col-xs-12 col-sm-12 col-lg-12">
			<div class="form-group">
				<button type="submit" class="btn btn-primary" style="width: 160px;"
					data-ng-click="submitted=true" onclick="abc();">Save</button>
			</div>
		</div>
	</div>
</form>
<script>
	$('select').select2();

	sessionStorage.removeItem("info");
	sessionStorage.removeItem("image");
	sessionStorage.removeItem("trailer");
	function abc() {
		var info = document.getElementById("trumbowyg-demo").value;
		var image = document.getElementById("avatar").value;
		var trailer = document.getElementById("trailer").value;

		sessionStorage.setItem("info", info);
		sessionStorage.setItem("image", image);
		sessionStorage.setItem("trailer", trailer);
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





