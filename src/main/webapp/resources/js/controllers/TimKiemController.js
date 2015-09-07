/**
 * 
 */
var TimKiemController = function($scope, $http, $location, $rootScope) {

	$rootScope.SearchFilm = function(dataSearch) {
		var req = {
			method : 'GET',
			url : 'TimKiemController/Search/' + dataSearch,
			headers : {
				"Content-Type" : "application/json"
			},
		};
		$http(req).success(function(data) {
			$rootScope.dataSearch = dataSearch;
			$rootScope.result = data.length;
			$rootScope.movies = data;
			$location.path("/TimKiem");
		}).error(function(error) {
			console.error(error);
		});
	};

};
