/**
 * 
 */
var PhimLeController = function($scope, $http, $location, $rootScope) {
	$scope.page = 1;
	// ---------Load all movie---------------
	function loadAllMovies() {
		var req = {
			method : 'GET',
			url : 'PhimLeController/FilterBy/1/13/0/13/1',
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
	loadAllMovies();
	function getTotalPageNum() {
		var req = {
			method : 'GET',
			url : 'PhimLeController/GetTotalFilterPage/1/13/0/13/1',
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

	// -------------Filter film--------------------
	$scope.filterFilm = function() {

		var cateId = $scope.category.id;
		var countryId = $scope.country.id;
		var sortId = $scope.sort.id;
		var year = $scope.publishYear.id;
		var page = $scope.page;
		var req = {
			method : 'GET',
			url : 'PhimLeController/FilterBy/' + sortId + "/" + cateId + "/"
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

	// ---------Get all page-----------------
	function getTotalFilterPage() {
		var cateId = $scope.category.id;
		var countryId = $scope.country.id;
		var sortId = $scope.sort.id;
		var year = $scope.publishYear.id;
		var page = $scope.page;
		var req = {
			method : 'GET',
			url : 'PhimLeController/GetTotalFilterPage/' + sortId + "/"
					+ cateId + "/" + year + "/" + countryId + "/" + page,
			headers : {
				"Content-Type" : "application/json"
			},
		};
		$http(req).success(function(data) {
			$scope.totalPage = data;
		});
	}
	// ---------------------------------
	$scope.ChiTiet = function(movieId) {
		sessionStorage.setItem("movieId", movieId);
		$location.path('/ChiTiet');
	};

};