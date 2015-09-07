/**
 * 
 */
var StarringController = function($scope, $http, $rootScope, $route,
		StarringService) {
	function starringDetail() {
		var starringId = sessionStorage.getItem("starringId");
		StarringService.getStarringDetail(starringId).success(
				function(starring) {
					$scope.starring = starring;
				}).error(function(error) {
			console.error(error);
		});
	}
	starringDetail();

};