'use strict';

/**
 * CarController
 * 
 * @constructor
 */
var ChiTietController = function($scope, $http, $location, $modal, $rootScope,
		MovieService, FilmUtilityService, RegisService) {
	var allStarring = [];
	// load movie
	$scope.showMovieDetail = function(movieId) {
		MovieService.getMovie(movieId).success(function(data) {
			$rootScope.movie = data.movie;
			// to show Info with html tag
			$rootScope.movieInfo = data.movie.info;
			sessionStorage.setItem("movieId", movieId);
			allStarring = data.movie.starrings;
			$scope.nextStarring();
			// Check register film
			RegisService.checkRegis(data.movie).success(function(dataRegis) {
				$scope.hasBought = dataRegis;
				sessionStorage.setItem("hasBought", dataRegis);
			}).error(function(error) {
				console.error(error);
			});

		}).error(function(error) {
			console.error(error);
		});
		FilmUtilityService.getComments(movieId).success(function(data2) {
			$rootScope.comments = data2;
		}).error(function(error) {
			console.error(error);
		});

	};

	var movieId = sessionStorage.getItem("movieId");
	$scope.showMovieDetail(movieId);

	// create function to show starrings when click next btn
	var currentStarringIndex = 0;
	$scope.nextStarring = function() {
		var starringsToShow = [];
		if (allStarring.length > 5) {
			if (currentStarringIndex >= allStarring.length) {
				currentStarringIndex = 0;
			}
			var i = 0;
			var currentStarring = {};
			for (i = currentStarringIndex; i < currentStarringIndex + 5; i++) {
				currentStarring = allStarring[i];
				if (currentStarring == null) {
					currentStarring = allStarring[i - allStarring.length];
				}
				starringsToShow.push(currentStarring);
			}
			currentStarringIndex += 5;
		} else {
			for (i = 0; i < allStarring.length; i++) {
				starringsToShow.push(allStarring[i]);
			}
		}
		$scope.starrings = starringsToShow;

	};

	// load relative movies
	$rootScope.allRelativeMovies = [];
	var loadRelativeMovie = function(movieId) {
		FilmUtilityService.loadRelativeMovie(movieId).success(function(data) {
			$rootScope.allRelativeMovies = data;
			// show relative movie
			$scope.nextRelativeMovies();
		}).error(function(error) {
			console.error(error);
		});

	};
	loadRelativeMovie(movieId);

	// create function to show relative movie when click next btn
	var relativeMovies = [];
	var currentRelativeMoviesIndex = 0;
	$scope.nextRelativeMovies = function() {
		relativeMovies = [];
		if (currentRelativeMoviesIndex >= $rootScope.allRelativeMovies.length) {
			currentRelativeMoviesIndex = 0;
		}
		var i = 0;
		for (i = currentRelativeMoviesIndex; i < currentRelativeMoviesIndex + 5; i++) {
			relativeMovies.push($rootScope.allRelativeMovies[i]);
		}
		currentRelativeMoviesIndex += 5;
		$scope.relativeMovies = relativeMovies;
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

	// go the the player page
	$scope.playMovie = function(movie) {
		FilmUtilityService.playMovie(movie).success(function() {
			sessionStorage.setItem("source", movie.name);
			sessionStorage.setItem("movieId", movie.id);
			sessionStorage.setItem("movieType", "movie");
			sessionStorage.removeItem("serieId");
			$location.path('/PlayVideo');
		}).error(function(error) {
			console.error(error);
		});
	};


	// Open dialog register film
	$scope.openRegisterDialog = function(film) {
		var email = $rootScope.user.email;
		if (email != null) {
			var modalInstance = $modal.open({
				templateUrl : 'myModalContent.html',
				controller : ModalInstanceCtrl,
				resolve : {
					film : function() {
						return film;
					}
				}
			});

			modalInstance.result.then(function(movie) {
				RegisService.RegisFilm(movie).success(function(data) {
					if (data == "OK") {
						console.log("Giao dich thanh cong");
						$scope.playMovie(movie);
					} else {
						console.log("Giao dich khong thanh cong");
					}
				}).error(function(error) {
					console.error(error);
				});
			}, function() {

			});
		} else {
			$location.path("/Login");
		}
		;
	};
};

var ModalInstanceCtrl = function($scope, $modalInstance, film) {

	$scope.film = film;

	$scope.ok = function() {
		$modalInstance.close(film);
	};

	$scope.cancel = function() {
		$modalInstance.dismiss('cancel');
	};
};