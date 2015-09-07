<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<style>
		.td-fix{
			width:150px;
			
		}
		
		.borderless tbody tr td, .borderless thead tr th, .borderless tfoot tr td{
			border: none;
		}
	</style>
	
	
<div class="thumbnail" style="width: 1000px; margin:0 auto; margin-bottom:15px">
	<div class="row">
		<div class="col-xs-12 col-md-5">
			<img alt="anh 1" src="{{starring.avatar}}" border="1px"
				style="width: 100%; max-width: 325px; height: 370px;" />

		</div>
		<div class="col-xs-12 col-md-7">
			<table class="table table-striped borderless" style="border-color:white;">
				<thead>
					<tr>
						<th colspan="2"><h3>
								<label style="color: #dacb46;"> {{starring.name}}</label>
							</h3></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="td-fix">Ngày sinh</td>
						<td>{{starring.birthDay}}</td>
					</tr>
					<tr>
						<td>Nghề nghiệp</td>
						<td>{{starring.job}}</td>
					</tr>
					<tr>
						<td>Quốc gia</td>
						<td>{{starring.country}}</td>
					</tr>
					<tr>
						<td>Chiều cao</td>
						<td>{{starring.height}}</td>
					</tr>
					<tr>
						<td>Cân nặng</td>
						<td>{{starring.weight}}</td>
					</tr>
					<tr>
						<td>Sở thích</td>
						<td>{{starring.hobby}}</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td>
							<button class="btn btn-success"
								ng-click="SearchFilm(starring.name)">Các phim đã tham
								gia</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>


</div>