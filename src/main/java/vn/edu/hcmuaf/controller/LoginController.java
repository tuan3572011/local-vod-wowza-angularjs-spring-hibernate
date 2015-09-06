package vn.edu.hcmuaf.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.http.client.HttpResponseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import vn.edu.hcmuaf.service.LoginServiceImpl;
import vn.edu.hcmuaf.util.TokenUtils;

import com.vod.model.User;

@Controller
@RequestMapping("/LoginController")
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	@Autowired
	@Qualifier("authenticationManager")
	private AuthenticationManager authManager;
	@Autowired
	private UserDetailsService userDetailsService;
	@Autowired
	private LoginServiceImpl userService;

	@RequestMapping(value = "/layout")
	public String loginPage() {
		return "Login";
	}

	@RequestMapping(value = "/GetUser", method = RequestMethod.POST)
	public @ResponseBody User getUser() throws HttpResponseException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Object principal = authentication.getPrincipal();
		if (principal instanceof String && ((String) principal).equals("anonymousUser")) {
			System.out.println("anymous user");
			throw new HttpResponseException(401, "You are not loggin");
		}
		UserDetails userDetails = (UserDetails) principal;
		User user = userService.getUser(userDetails.getUsername());
		user.setPassword("xxxxxxxxxxxxxxx");
		return user;
	}

	@RequestMapping(value = "/authenticate", method = RequestMethod.POST)
	public @ResponseBody String authenticate(@RequestParam(value = "email") String email,
			@RequestParam(value = "password") String password) {
		logger.info(email + password);
		UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(email,
				password);
		logger.info("begin authenticate");
		Authentication authentication = this.authManager.authenticate(authenticationToken);
		logger.info("end authenticate");
		SecurityContextHolder.getContext().setAuthentication(authentication);

		/*
		 * Reload user as password of authentication principal will be null
		 * after authorization and password is needed for token generation
		 */
		UserDetails userDetails = this.userDetailsService.loadUserByUsername(email);
		return TokenUtils.createToken(userDetails);

	}

	@SuppressWarnings("unused")
	private Map<String, Boolean> createRoleMap(UserDetails userDetails) {
		Map<String, Boolean> roles = new HashMap<String, Boolean>();
		for (GrantedAuthority authority : userDetails.getAuthorities()) {
			roles.put(authority.getAuthority(), Boolean.TRUE);
		}
		return roles;
	}

}
