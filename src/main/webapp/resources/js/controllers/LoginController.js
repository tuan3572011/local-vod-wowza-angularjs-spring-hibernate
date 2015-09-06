'use strict';

/**
 * CarController
 * 
 * @constructor
 */
var LoginController = function($rootScope, $scope, $http, $location,
		$cookieStore) {

	$scope.login = function(login) {
		var reqAuthenticate = {
			method : 'POST',
			url : 'LoginController/authenticate',
			params : {
				'email' : login.email,
				'password' : login.password
			},
			headers : {
				'Content-Type' : 'application/x-www-form-urlencoded'
			}
		};

		$http(reqAuthenticate).success(function(data) {
			var authToken = data;
			$rootScope.authToken = authToken;
			sessionStorage.setItem('authToken', authToken);
			var originalPath = sessionStorage.getItem("originalPath");
			if (originalPath) {
				$location.path(originalPath);
			}
			// $cookieStore.put('authToken', authToken);

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
				$location.path("/PhimBo");
			}).error(function(response) {
				console.error(response);
			});
		}).error(function(response) {
			console.error(response);
		});

	};

};