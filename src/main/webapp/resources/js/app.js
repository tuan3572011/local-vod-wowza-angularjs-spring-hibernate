'use strict';

var AngularSpringApp = {};

var App = angular.module('AngularSpringApp', [ 'ngRoute', 'ngCookies',
		'ngSanitize', 'ui.bootstrap' ]);

// Declare app level module which depends on filters, and services
App
		.config([
				'$routeProvider',
				'$httpProvider',
				function($routeProvider, $httpProvider) {
					$routeProvider.when('/TimKiem', {
						templateUrl : 'TimKiemController/layout',
						controller : TimKiemController
					});

					$routeProvider.when('/canhan', {
						templateUrl : 'CaNhanController/layout',
						controller : CaNhanController
					});

					$routeProvider.when('/DangKy', {
						templateUrl : 'RegisterUserController/layout',
						controller : RegisterUserController
					});

					$routeProvider.when('/SerieDetail', {
						templateUrl : 'ChiTietController/seriedetail',
						controller : SerieController
					});

					$routeProvider.when('/PhimBo', {
						templateUrl : 'PhimBoController/layout',
						controller : PhimBoController
					});
					$routeProvider.when('/PhimLe', {
						templateUrl : 'PhimLeController/layout',
						controller : PhimLeController

					});
					$routeProvider.when('/PhimXemNhieu', {
						templateUrl : 'PhimXemNhieu/layout'
					});

					$routeProvider.when('/ThemPhim', {
						templateUrl : 'ThemPhimController/layout',
						controller : ThemPhimController
					});

					$routeProvider.when('/ChiTiet', {
						templateUrl : 'ChiTietController/layout',
						controller : ChiTietController
					});
					$routeProvider.when('/Login', {
						templateUrl : 'LoginController/layout',
						controller : LoginController
					});

					$routeProvider.when('/PlayVideo', {
						templateUrl : 'PlayerAuthenticationController/layout',
						controller : PlayerController
					});

					$routeProvider.when('/Starring', {
						templateUrl : 'DienVienController/DetailLayout',
						controller : StarringController
					});

					$routeProvider.when('/FilmRedirect', {
						templateUrl : 'ChiTietController/RedirectLayout',
						controller : FilmRedirectController
					});

					$routeProvider.otherwise({
						redirectTo : '/PhimBo'
					});

					/*
					 * Register error provider that shows message on failed
					 * requests or redirects to login page on unauthenticated
					 * requests
					 */
					$httpProvider.interceptors.push(function($q, $rootScope,
							$location) {
						return {
							'responseError' : function(rejection) {
								var status = rejection.status;
								var config = rejection.config;
								var method = config.method;
								var url = config.url;

								if (status == 401) {
									sessionStorage.setItem("originalPath",
											$location.path());
									$rootScope.logout();
								} else {
									$rootScope.error = method + " on " + url
											+ " failed with status " + status;
								}

								return $q.reject(rejection);
							}
						};
					});

					/*
					 * Registers auth token interceptor, auth token is either
					 * passed by header or by query parameter as soon as there
					 * is an authenticated user
					 */
					$httpProvider.interceptors
							.push(function($q, $rootScope, $location,
									$cookieStore) {
								return {
									'request' : function(config) {
										var authToken = {};
										if (angular
												.isDefined($rootScope.authToken)) {
											authToken = $rootScope.authToken;
										} else {
											// authToken = $cookieStore
											// .get("authToken");
											authToken = sessionStorage
													.getItem("authToken");
										}
										if (authToken) {
											if (AngularSpringAppConfig.useAuthTokenHeader) {
												config.headers['X-Auth-Token'] = authToken;
											} else {
												config.url = config.url
														+ "?token=" + authToken;
											}
										}
										return config || $q.when(config);
									}
								};
							});

				} ]);

App.service('MovieService', [ '$http', function($http) {
	this.getMovie = function(movieId) {
		var req = {
			method : 'GET',
			url : 'PhimLeController/movie/' + movieId,
			headers : {
				"Content-Type" : "application/json"
			}
		};
		return $http(req);
	};
} ]);

App.service('SerieService', [ '$http', function($http) {
	this.getSerie = function(movieId) {
		var req = {
			method : 'GET',
			url : 'PhimBoController/serie/' + movieId,
			headers : {
				"Content-Type" : "application/json"
			}
		};
		return $http(req);
	};
} ]);

App.service('StarringService', [ '$http', function($http) {
	this.getStarringDetail = function(starringId) {
		var req = {
			method : 'GET',
			url : 'DienVienController/StarringDetail/' + starringId,
			headers : {
				"Content-Type" : "application/json"
			}
		};
		return $http(req);
	};
} ]);

App.service('FilmUtilityService', [ '$http', '$rootScope',
		function($http, $rootScope) {
			this.getComments = function(movieId) {
				var req2 = {
					method : 'GET',
					url : 'CommentController/getByMovieId/' + movieId,
					headers : {
						"Content-Type" : "application/json"
					}
				};
				return $http(req2);
			};
			this.loadRelativeMovie = function(movieId) {
				var req = {
					method : 'GET',
					url : 'LoadRelativeFilmController/LoadRelativeMovies',
					params : {
						'movieId' : movieId
					},
					headers : {
						"Content-Type" : "application/json"
					}
				};
				return $http(req);
			};
			this.loadHotMovie = function() {
				var req = {
					method : 'GET',
					url : 'LoadRelativeFilmController/LoadHotMovies',
					headers : {
						"Content-Type" : "application/json"
					}
				};
				return $http(req);
			};

			this.addComment = function(commentContent) {
				var userEmail = $rootScope.user.email;
				var movieId = sessionStorage.getItem("movieId");
				var req = {
					method : 'POST',
					url : 'CommentController/Save',
					params : {
						'email' : userEmail,
						'comment' : commentContent,
						'movieId' : movieId
					},
					headers : {
						"Content-Type" : "application/json"
					}
				};
				return $http(req);
			};

			this.playMovie = function(movie) {
				var movieId = movie.id;
				var email = $rootScope.user.email;
				var type = movie.type;
				var req = {
					method : 'POST',
					url : 'PlayerAuthenticationController',
					params : {
						'email' : email,
						'movieId' : movieId,
						'type' : type
					},
					headers : {
						"Content-Type" : "application/json"
					}
				};
				return $http(req);
			};

		} ]);

App.service('RegisService', [
		'$http',
		'$rootScope',
		function($http, $rootScope) {
			this.RegisFilm = function(film) {
				var email = $rootScope.user.email;
				var idFilm = film.id;
				var type = film.type;
				var req = {
					method : 'GET',
					url : 'RegisFilmController/addRegis/' + email + '/'
							+ idFilm + '/' + type,
					headers : {
						"Content-Type" : "application/json"
					},
				};
				return $http(req);
			};

			this.checkRegis = function(film) {
				var email = $rootScope.user.email;
				var idFilm = film.id;
				var req = {
					method : 'GET',
					url : 'RegisFilmController/checkRegis/' + email + '/'
							+ idFilm,
					headers : {
						"Content-Type" : "application/json"
					}
				};
				return $http(req);
			};

		} ]);
App.run(function($rootScope, $location, $cookieStore, $http) {

	/* Reset error when a new view is loaded */
	$rootScope.$on('$viewContentLoaded', function() {
		delete $rootScope.error;
	});

	// get user after user reset because $rootScope.user will be destroy after
	// refresh page
	if (!angular.isDefined($rootScope.user)) {
		var reqUser = {
			method : 'POST',
			url : 'LoginController/GetUser'
		};
		$http(reqUser).success(function(data) {
			var user = data;
			for (var i = 0; i < user.roles.length; i++) {
				if (user.roles[i].role == "ROLE_USER") {
					user.isUser = true;
				}
				if (user.roles[i].role == "ROLE_ADMIN") {
					user.isAdmin = true;
				}
			}
			$rootScope.user = user;
			// $rootScope.email = user.email;
		});
	}

	$rootScope.logout = function() {
		delete $rootScope.user;
		delete $rootScope.authToken;
		sessionStorage.removeItem('authToken');
		window.location.reload(true);
		$location.path("/Login");

	};

	$rootScope.categoriesS = [ {
		"id" : 13,
		"name" : "Tất cả"
	}, {
		"id" : 6,
		"name" : "Chiến Tranh"
	}, {
		"id" : 10,
		"name" : "Cổ Trang"
	}, {
		"id" : 8,
		"name" : "Gia Đình"
	}, {
		"id" : 2,
		"name" : "Hành Động"
	}, {
		"id" : 11,
		"name" : "Hình Sự"
	}, {
		"id" : 4,
		"name" : "Hoạt Hình"
	}, {
		"id" : 7,
		"name" : "Khoa Học Viễn Tưởng"
	}, {
		"id" : 12,
		"name" : "Kinh Dị"
	}, {
		"id" : 5,
		"name" : "Phiêu Lưu"
	}, {
		"id" : 3,
		"name" : "Tâm Lý"
	}, {
		"id" : 1,
		"name" : "Tình Cảm"
	}, {
		"id" : 9,
		"name" : "Võ Thuật"
	} ];

	$rootScope.countriesS = [ {
		"id" : 13,
		"name" : "Tất cả"
	}, {
		"id" : 9,
		"name" : "Anh"
	}, {
		"id" : 4,
		"name" : "Âu Mỹ"
	}, {
		"id" : 12,
		"name" : "Canada"
	}, {
		"id" : 3,
		"name" : "Hàn Quốc"
	}, {
		"id" : 8,
		"name" : "Hồng Kông"
	}, {
		"id" : 2,
		"name" : "Nhật Bản"
	}, {
		"id" : 10,
		"name" : "Pháp"
	}, {
		"id" : 6,
		"name" : "Thái Lan"
	}, {
		"id" : 5,
		"name" : "Trung Quốc"
	}, {
		"id" : 7,
		"name" : "Úc"
	}, {
		"id" : 1,
		"name" : "Việt Nam"
	}, {
		"id" : 11,
		"name" : "Đài Loan"
	} ];

	$rootScope.publishYears = [ {
		"id" : 0,
		"name" : "Tất cả"
	}, {
		"id" : 2015,
		"name" : "2015"
	}, {
		"id" : 2014,
		"name" : "2014"
	}, {
		"id" : 2013,
		"name" : "2013"
	}, {
		"id" : 2012,
		"name" : "2012"
	}, {
		"id" : 2011,
		"name" : "2011"
	}, {
		"id" : 2010,
		"name" : "Trước 2011"
	} ];

	$rootScope.sorts = [ {
		"id" : 1,
		"name" : "Lượt xem"
	}, {
		"id" : 2,
		"name" : "Đánh giá"
	} ];
});