package com.shiro;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.realm.Realm;

public class SuperAdminRealm implements Realm{
	@Override
	public String getName() {
		return "SuperAdminRealm";
	}

	@Override
	public boolean supports(AuthenticationToken token) {
		return token instanceof UsernamePasswordToken;
	}

	@Override
	public AuthenticationInfo getAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String username = String.valueOf(token.getPrincipal());
		String password = new String((char[])token.getCredentials());
		if(!"zhang".equals(username)) {
			throw new UnknownAccountException();
		}
		if(!"123".equals(password)) {
			throw new UnknownAccountException();
		}
		return new SimpleAuthenticationInfo(username,password,getName());
	}
}
