/**
 * 
 */
var TimKiemController = function($scope, $http, $location, $rootScope,
		FilmUtilityService) {

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

	// load hot movies
	var loadHotMovie = function(movie) {
		FilmUtilityService.loadHotMovie().success(function(data) {
			$rootScope.allHotMovies = data;

			// show Hot movie
			$scope.nextHotMovies();
		}).error(function(error) {
			console.error(error);
		});

	};
	loadHotMovie();

	// create function to show hot movie when click next btn
	var hotMovies = [];
	var currentHotMoviesIndex = 0;
	$scope.nextHotMovies = function() {
		hotMovies = [];
		if (currentHotMoviesIndex >= $rootScope.allHotMovies.length) {
			currentHotMoviesIndex = 0;
		}
		var i = 0;
		for (i = currentHotMoviesIndex; i < currentHotMoviesIndex + 5; i++) {
			hotMovies.push($rootScope.allHotMovies[i]);
		}
		currentHotMoviesIndex += 5;
		$scope.hotMovies = hotMovies;
	};

};
