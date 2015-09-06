/**
 * 
 */
var CaNhanController = function($scope, $http, $rootScope, $route) {
	$scope.selection = 'canhan';
	var email = $rootScope.user.email;

	$scope.loadPage = function(page) {
		$scope.selection = page;
	};

	$scope.addCard = function(seri) {
		var req = {
			method : 'POST',
			url : 'RechargeController/addRecharge',
			params : {
				'email' : email,
				'seri' : seri
			},
			headers : {
				"Content-Type" : "application/json"
			},
		};
		$http(req).success(function(data) {
			alert(data);
//			window.location.reload(true);
		});
	};

	$scope.getListRegister = function(email) {
		var req = {
			method : 'GET',
			url : 'CaNhanController/history/' + email + '/regis',
			headers : {
				"Content-Type" : "application/json"
			},
		};
		$http(req).success(function(data) {
			$rootScope.registers = data;
		});
	};

	$scope.getListRegister(email);

};