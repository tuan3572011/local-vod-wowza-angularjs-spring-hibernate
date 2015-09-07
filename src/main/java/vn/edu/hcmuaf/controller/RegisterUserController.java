package vn.edu.hcmuaf.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import vn.edu.hcmuaf.util.LinkService;

import com.vod.model.User;

@Controller
@RequestMapping("/RegisterUserController")
public class RegisterUserController {
	private static final Logger logger = LoggerFactory.getLogger(RegisterUserController.class);

	@RequestMapping(value = "/layout")
	public String doGetLayoutPage() {
		return "register";
	}

	@RequestMapping(value = "/RegisterUser", method = RequestMethod.POST, consumes = "application/json")
	public @ResponseBody String doRegisterUser(@RequestBody User user) {
		String result = "FAIL";
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
		ResponseEntity<Void> entity = restTemplate.postForEntity(LinkService.USER_ADD, user, Void.class);
		if (entity.getStatusCode().equals(HttpStatus.OK)) {
			result = "OK";
		}
		logger.info("register user " + user.getUserName() + "  " + result);
		return result;
	}
}
