package vn.edu.hcmuaf.controller;

import java.util.Map;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created with IntelliJ IDEA. User: xvit`coder Date: 12/20/12 Time: 5:27 PM
 */
@Controller
@RequestMapping("/")
public class IndexController {

	@RequestMapping
	public String getIndexPage(Map<String, Object> map) {
		Authentication authentication = SecurityContextHolder.getContext()
				.getAuthentication();
		String username = null;
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) authentication
					.getPrincipal();
			username = userDetail.getUsername();
		}
		if (username != null) {
			map.put("username", username);
		}
		return "index";
	}
}
