package com.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.entity.Employee;

@Repository
public class EmployeeDao {
	@Autowired
	SqlSessionFactory sqlSessionFactory;

	public List<Employee> allEmployees() throws Exception {//获取所有员工信息
		SqlSession sqlSession = sqlSessionFactory.openSession();
		List<Employee> employees = sqlSession.selectList("employee.allEmployees");
		sqlSession.close();
		return employees;
	}
	
	public List<Employee> getMapByDept(String department) throws Exception {//获取部门员工信息
		SqlSession sqlSession = sqlSessionFactory.openSession();
		List<Employee> employees = sqlSession.selectList("employee.getMapByDept",department);
		sqlSession.close();
		return employees;
	}
	
	public int addEmployee(Employee e) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		int fact = sqlSession.insert("addEmployee", e);
		sqlSession.close();
		return fact;
	}
	
	public int updateEmployee(Employee e) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		int fact = sqlSession.update("updateEmployee", e);
		sqlSession.close();
		return fact;
	}
	
	public int delete(int id) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		int fact = sqlSession.delete("deleteById", id);
		sqlSession.close();
		return fact;
	}
}
