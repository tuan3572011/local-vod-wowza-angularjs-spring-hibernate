/**
 * 
 */
var PhimBoController = function($scope, $location, $rootScope, $http) {
	$scope.page = 1;
	$scope.category = {
		"id" : 13,
		"name" : "Tất cả"
	};

	$scope.country = {
		"id" : 13,
		"name" : "Tất cả"
	};

	$scope.publishYear = {
		"id" : 0,
		"name" : "Tất cả"
	};

	$scope.sort = {
		"id" : 1,
		"name" : "Lượt xem"
	};

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
	};

	$scope.filterFilm = function() {
		var req = {
			method : 'GET',
			url : 'PhimBoController/FilterBy/' + $scope.sort.id + "/"
					+ $scope.category.id + "/" + $scope.publishYear.id + "/"
					+ $scope.country.id + "/" + $scope.page,
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
	$scope.filterFilm();

	function getTotalFilterPage() {
		var req = {
			method : 'GET',
			url : 'PhimBoController/GetTotalFilterPage/' + $scope.sort.id + "/"
					+ $scope.category.id + "/" + $scope.publishYear.id + "/"
					+ $scope.country.id + "/" + $scope.page,
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