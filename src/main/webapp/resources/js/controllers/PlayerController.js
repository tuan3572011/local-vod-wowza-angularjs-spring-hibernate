'use strict';

/**
 * PlayerController
 * 
 * @constructor
 */

var PlayerController = function($scope, $http, $location, $rootScope, $route,
		$sce, MovieService, FilmUtilityService, SerieService) {

	// load movie

	var serieId = {};
	var allStarring = {};
	var movieId = sessionStorage.getItem("movieId");
	var movieType = sessionStorage.getItem("movieType");

	$scope.trustSrc = function(src) {
		return $sce.trustAsResourceUrl(src);
	};

	$scope.addComment = function(commentContent) {
		FilmUtilityService.addComment(commentContent).success(function(data) {
			$rootScope.comments = data;
			$route.reload();
		}).error(function(error) {
			console.error(error);
		});
	};

	// set movieId and go to chi tiet page
	$scope.showMovieDetail = function(movieId) {
		sessionStorage.setItem("movieId", movieId);
		$location.path("/ChiTiet");
	};

	// create function to show starrings when click next btn
	var starring = [];
	var currentStarringIndex = 0;
	$scope.nextStarring = function() {
		starring = [];
		if (currentStarringIndex >= allStarring.length) {
			currentStarringIndex = 0;
		}
		var i = 0;
		for (i = currentStarringIndex; i < currentStarringIndex + 5; i++) {
			starring.push(allStarring[i]);
		}
		currentStarringIndex += 5;
		$scope.starrings = starring;
	};

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

	// if user didn't refresh page
	if (angular.isDefined($rootScope.movie)) {
		allStarring = $rootScope.movie.starrings;
		// show starring
		$scope.nextStarring();
		// load relative movies
		$scope.nextRelativeMovies();
		// show Hot movie
		$scope.nextHotMovies();
		if (movieType == "episode") {
			// load comments for this episode
			FilmUtilityService.getComments(movieId).success(function(data2) {
				$rootScope.comments = data2;
			}).error(function(error) {
				console.error(error);
			});
		}
	} else {// user refreshed page
		movieId = sessionStorage.getItem("movieId");
		if (movieType == "episode") {
			serieId = sessionStorage.getItem("serieId");
			SerieService.getSerie(serieId).success(function(data) {
				$rootScope.movie = data.serie;
				$rootScope.movieInfo = data.serie.info;
				allStarring = data.serie.starrings;
				$scope.nextStarring();
			});
		} else {
			// get movie by id;
			MovieService.getMovie(movieId).success(function(data) {
				$rootScope.movie = data.movie;
				// to show Info with html tag
				$rootScope.movieInfo = data.movie.info;
				// sessionStorage.setItem("movieId", movieId);
				allStarring = data.movie.starrings;
				// show starring
				$scope.nextStarring();
			}).error(function(error) {
				console.error(error);
			});
		}
		// load comments
		FilmUtilityService.getComments(movieId).success(function(data2) {
			$rootScope.comments = data2;
		}).error(function(error) {
			console.error(error);
		});

		// load relative movies
		var relativeMovieId = movieId;
		if (movieType == "episode") {
			relativeMovieId = serieId;
		}
		FilmUtilityService.loadRelativeMovie(relativeMovieId).success(
				function(data) {
					$rootScope.allRelativeMovies = data;

					// load relative movies
					$scope.nextRelativeMovies();
				}).error(function(error) {
			console.error(error);
		});

		// load hot movies
		FilmUtilityService.loadHotMovie().success(function(data) {
			$rootScope.allHotMovies = data;

			// show Hot movie
			$scope.nextHotMovies();
		}).error(function(error) {
			console.error(error);
		});
	}
	;

};