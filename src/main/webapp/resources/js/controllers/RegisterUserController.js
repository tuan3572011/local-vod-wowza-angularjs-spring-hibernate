/**
 * 
 */
var RegisterUserController = function($rootScope, $scope, $http, $location) {

	$scope.RegisterUser = function(user) {
		var req = {
			method : 'POST',
			url : 'RegisterUserController/RegisterUser',
			headers : {
				"Content-Type" : "application/json"
			},
			data : user
		};
		$http(req).success(function(data) {
			if (data == "OK") {
				console.log("Đăng ký thành công!");
				$location.path("/Login");
			} else {
				console.log("Lỗi!");
			}
		}).error(function(error) {
			console.error(error);
		});
	};

};