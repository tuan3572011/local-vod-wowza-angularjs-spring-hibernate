/**
 * 
 */
var PhimBoController = function($scope, $location, $rootScope, $http) {
	$scope.page = 1;

	function loadAllSerieMovies() {
		var req = {
			method : 'GET',
			url : 'PhimBoController/FilterBy/1/13/0/13/1',
			headers : {
				"Content-Type" : "application/json"
			},
		};
		$http(req).success(function(data) {
			$rootScope.movies = data;
			getTotalPageNum();
			doPaging($scope.page, $scope.totalPage);
		});
	}
	loadAllSerieMovies();

	function getTotalPageNum() {
		var req = {
			method : 'GET',
			url : 'PhimBoController/GetTotalFilterPage/1/13/0/13/1',
			headers : {
				"Content-Type" : "application/json"
			},
		};
		$http(req).success(function(data) {
			$scope.totalPage = data;
		});
	}

	// ----------Paging-----------------------

	function doPaging(page, totalPage) {
		if (page >= totalPage) {
			$scope.isDisableFirst = false;
			$scope.isDisablePrev = false;
			$scope.isDisableLast = true;
			$scope.isDisableNext = true;
		}
		if (page <= 1) {
			$scope.isDisableFirst = true;
			$scope.isDisablePrev = true;
			$scope.isDisableLast = false;
			$scope.isDisableNext = false;
		}
		if (page == totalPage == 1) {
			$scope.isDisableNext = true;
			$scope.isDisablePrev = true;
			$scope.isDisableLast = true;
			$scope.isDisableFirst = true;
		}
	}

	$scope.paging = function(btn) {
		if (btn == 'NEXT') {
			$scope.page = $scope.page + 1;
		} else if (btn == 'PREV') {
			$scope.page = $scope.page - 1;
		} else if (btn == 'FIRST') {
			$scope.page = 1;
		} else if (btn == 'LAST') {
			$scope.page = $scope.totalPage;
		} else {
			$scope.page = btn;
		}
		if ($scope.page > $scope.totalPage) {
			$scope.page = $scope.totalPage;
		}
		if ($scope.page < $scope.totalPage) {
			$scope.page = 1;
		}
		$scope.filterFilm();
	}

	$scope.filterFilm = function() {
		var cateId = $scope.category.id;
		var countryId = $scope.country.id;
		var sortId = $scope.sort.id;
		var year = $scope.publishYear.id;
		var page = 1;
		var req = {
			method : 'GET',
			url : 'PhimBoController/FilterBy/' + sortId + "/" + cateId + "/"
					+ year + "/" + countryId + "/" + page,
			headers : {
				"Content-Type" : "application/json"
			},
		};
		$http(req).success(function(data) {
			$rootScope.movies = data;
			getTotalFilterPage();
			doPaging($scope.page, $scope.totalPage);
		});
	};

	function getTotalFilterPage() {
		var cateId = $scope.category.id;
		var countryId = $scope.country.id;
		var sortId = $scope.sort.id;
		var year = $scope.publishYear.id;
		var page = $scope.page;
		var req = {
			method : 'GET',
			url : 'PhimBoController/GetTotalFilterPage/' + sortId + "/"
					+ cateId + "/" + year + "/" + countryId + "/" + page,
			headers : {
				"Content-Type" : "application/json"
			},
		};
		$http(req).success(function(data) {
			$scope.totalPage = data;
		});
	}

	$scope.SerieDetail = function(movieId) {
		$rootScope.phimBoId = movieId;
		sessionStorage.setItem("phimBoId", movieId);
		$location.path('/SerieDetail');
	};

	$scope.readJsonSearch = function() {
		var req = {
			method : 'GET',
			url : 'PhimBoController/jsonsearch',
			headers : {
				"Content-Type" : "application/json"
			}
		};

		$http(req).success(function(data) {
			$rootScope.jsonSearch = data;
		}).error(function(response) {
			console.error(response);
		});
	};

	$scope.readJsonSearch();

};