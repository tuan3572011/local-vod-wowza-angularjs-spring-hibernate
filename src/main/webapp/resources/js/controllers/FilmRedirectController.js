/**
 * 
 */
var FilmRedirectController = function($scope, $location, $rootScope, $route) {
	var isFromSearchPage = sessionStorage.getItem("isFromSearch");
	
	if (isFromSearchPage == "OK") {
		sessionStorage.setItem("isFromSearch", "FAIL");
		var movieType = sessionStorage.getItem("type");
		if (movieType == "movie") {
			$location.path('/ChiTiet');
		} else {
			$location.path('/SerieDetail');
		}
	}
	
	$scope.Redirect = function(movieId, movieType) {
		if (movieType == "movie") {
			sessionStorage.setItem("movieId", movieId);
			$location.path('/ChiTiet');
			$route.reload();
		} else {
			sessionStorage.setItem("phimBoId", movieId);
			$location.path('/SerieDetail');
			$route.reload();
		}
	};
};