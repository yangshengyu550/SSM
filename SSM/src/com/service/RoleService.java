package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.RoleDao;
import com.entity.Role;

@Service
public class RoleService {
	@Autowired
	RoleDao roleDao;
	
	public List<Role> selectAllRoles(){
		return roleDao.selectAllRoles();
	}
	
	public Role loginChecked(String role_name) throws Exception {
		return roleDao.loginChecked(role_name);
	}
	
	public int addRole(Role role) {
		return roleDao.addRole(role);
	}
	
	public int updateRole(Role role) {
		return roleDao.updateRole(role);
	}
	
	public int deleteRole(int id) {
		return roleDao.deleteRole(id);
	}
}
