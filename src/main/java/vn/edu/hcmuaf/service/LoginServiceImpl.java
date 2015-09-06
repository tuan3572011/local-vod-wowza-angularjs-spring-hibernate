package vn.edu.hcmuaf.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import vn.edu.hcmuaf.util.LinkService;

import com.vod.model.Role;
import com.vod.model.User;

@Service("loginService")
public class LoginServiceImpl implements UserDetailsService {

	@Override
	public UserDetails loadUserByUsername(String email)
			throws UsernameNotFoundException {
		User user = getUser(email);
		System.out.println(user.getEmail() + "--" + user.getRoles().size());
		List<GrantedAuthority> authorities = buildUserAuthority(user.getRoles());
		UserDetails userDetails = buildUserForAuthentication(user, authorities);
		return userDetails;
	}

	private org.springframework.security.core.userdetails.User buildUserForAuthentication(
			User user, List<GrantedAuthority> authorities) {
		return new org.springframework.security.core.userdetails.User(
				user.getEmail(), user.getPassword(), true, true, true, true,
				buildUserAuthority(user.getRoles()));
	}

	private List<GrantedAuthority> buildUserAuthority(Set<Role> userRoles) {
		Set<GrantedAuthority> setAuths = new HashSet<GrantedAuthority>();
		for (Role r : userRoles) {
			setAuths.add(new SimpleGrantedAuthority(r.getRole()));
		}
		List<GrantedAuthority> result = new ArrayList<GrantedAuthority>(
				setAuths);
		return result;
	}

	public User getUser(String email) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("email", email);
		RestTemplate restTemplate = new RestTemplate();
		User user = restTemplate.getForObject(LinkService.USER_GETBY_EMAIL,
				User.class, params);
		return user;
	}

}
