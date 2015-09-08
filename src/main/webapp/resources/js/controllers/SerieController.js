/**
 * 
 */
var SerieController = function($scope, $rootScope, $http, $location, $modal,
		RegisService, FilmUtilityService, SerieService) {
	var firstEpisode = null;
	var allStarring = [];

	$scope.showMovieDetail = function(movieId) {
		var req3 = {
			method : 'GET',
			url : 'EpisodeController/episodes/' + movieId,
			headers : {
				"Content-Type" : "application/json"
			}
		};

		$http(req3).success(function(data3) {
			$scope.episodes = data3;
			if (data3.length > 0) {
				firstEpisode = data3[0];
			}
			sessionStorage.setItem("episodes", data3);
		}).error(function(error) {
			console.error(error);
		});

		FilmUtilityService.getComments(movieId).success(function(data2) {
			$rootScope.comments = data2;
			sessionStorage.setItem("comments", data2);
		}).error(function(error) {
			console.error(error);
		});

		SerieService.getSerie(movieId).success(function(data) {
			$rootScope.movie = data.serie;
			$rootScope.movieInfo = data.serie.info;
			allStarring = data.serie.starrings;
			$scope.nextStarring();

			// Check regisFilm
			RegisService.checkRegis(data.serie).success(function(dataRegis) {
				$scope.hasBought = dataRegis;
				sessionStorage.setItem("hasBought", dataRegis);
				if (dataRegis == "OK") {

				}
			}).error(function(error) {
				console.error(error);
			});

		}).error(function(error) {
			console.error(error);
		});
	};

	var movieId = sessionStorage.getItem("phimBoId");

	$scope.showMovieDetail(movieId);

	$scope.showSerie = function(movieId) {
		sessionStorage.removeItem("phimBoId");
		sessionStorage.setItem("phimBoId", movieId);
		$scope.showMovieDetail(movieId);
	};

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
	$scope.allRelativeMovies = [];
	var loadRelativeMovie = function(movieId) {
		FilmUtilityService.loadRelativeMovie(movieId).success(function(data) {
			$scope.allRelativeMovies = data;
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
		if (currentRelativeMoviesIndex >= $scope.allRelativeMovies.length) {
			currentRelativeMoviesIndex = 0;
		}
		var i = 0;
		for (i = currentRelativeMoviesIndex; i < currentRelativeMoviesIndex + 5; i++) {
			relativeMovies.push($scope.allRelativeMovies[i]);
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
	$scope.playMovie = function(episode) {
		FilmUtilityService.playMovie(episode).success(function() {
			sessionStorage.setItem("source", "CamOnViTatCa.mp4");
			// sessionStorage.setItem("source", episode.name);
			// Distinguish between movie and episode in player controller
			// if this is movie, movieType will be movie
			// and remove serieId in sessionStorage
			sessionStorage.setItem("movieId", episode.id);
			sessionStorage.setItem("movieType", "episode");
			sessionStorage.setItem("serieId", movieId);
			$location.path('/PlayVideo');
		}).error(function(error) {
			console.error(error);
		});
	};

	// Check user have bought episode
	$scope.CheckRegisterEpisode = function(episode) {
		if ($scope.hasBought == "OK") {
			console.log("Da dang ki ca bo. Xem Phim");
			$scope.playMovie(episode);
		} else {
			RegisService.checkRegis(episode).success(function(data) {
				if (data == "OK") {
					$scope.playMovie(episode);
				} else {
					$scope.openRegisterDialog(episode);
				}
			}).error(function(error) {
				console.error(error);
			});
		}
	};

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

			modalInstance.result.then(function(film) {
				RegisService.RegisFilm(film).success(
						function(data) {
							if (data == "OK") {
								console.log("Giao dich thanh cong");
								if (firstEpisode != null
										|| angular.isDefined(firstEpisode)) {
									$scope.playMovie(firstEpisode);
								}
							} else {
								console.log("Giao dich khong thanh cong");
							}
						}).error(function(error) {
					console.error(error);
				});
			}, function() {

			});
		} else {
			console.log("Please login");
			$location.path("/Login");
		}
		;
	};
};

var ModalInstanceCtrl = function($scope, $modalInstance, film) {

	$scope.film = film;

	$scope.ok = function() {
		console.log("OK");
		$modalInstance.close(film);
	};

	$scope.cancel = function() {
		console.log("Cancel");
		$modalInstance.dismiss('cancel');
	};
};