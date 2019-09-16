package com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.entity.Role;

@Repository
public class RoleDao {
	@Autowired
	SqlSessionFactory sqlSessionFactory;
	
	public List<Role> selectAllRoles(){
		SqlSession sqlSession = sqlSessionFactory.openSession();
		List<Role> list = sqlSession.selectList("role.selectAllRoles");
		sqlSession.close();
		return list;
	}
	
	public Role loginChecked(String role_name) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		Role role = sqlSession.selectOne("role.loginChecked",role_name);
		sqlSession.close();
		return role;
	}
	
	public int  addRole(Role role) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		int fact = sqlSession.insert("role.addRole", role);
		sqlSession.close();
		return fact;
	}
	
	public int updateRole(Role role) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		int fact = sqlSession.update("role.updateRole", role);
		sqlSession.close();
		return fact;
	}
	
	public int deleteRole(int id) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		int fact = sqlSession.update("role.deleteRole", id);
		sqlSession.close();
		return fact;
	}
}
