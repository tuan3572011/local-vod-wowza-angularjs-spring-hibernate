package vn.edu.hcmuaf.security;

import java.util.Map;

public class UserTransfer {
	
	private final String email;

	private final Map<String, Boolean> roles;

	public UserTransfer(String userName, Map<String, Boolean> roles) {
		this.email = userName;
		this.roles = roles;
		
	}

	public String getEmail() {
		return this.email;
	}

	public Map<String, Boolean> getRoles() {
		return this.roles;
	}

	public boolean getIsAdmin() {
		if (roles.containsKey("ROLE_ADMIN"))
			return roles.get("ROLE_ADMIN");
		else
			return false;
	}

	public boolean getIsUser() {
		if (roles.containsKey("ROLE_USER"))
			return roles.get("ROLE_USER");
		else
			return false;
	}

}