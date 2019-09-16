package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.EmployeeDao;
import com.entity.Employee;

@Service
public class EmployeeService {
	@Autowired
	EmployeeDao dao;
	
	public List<Employee> allEmployees() throws Exception{
		return dao.allEmployees();
	}
	
	public List<Employee> getMapByDept(String department) throws Exception{
		return dao.getMapByDept(department);
	}
	
	public int addEmployee(Employee e) {
		return dao.addEmployee(e);
	}
	
	public int updateEmployee(Employee e) {
		return dao.updateEmployee(e);
	}
	
	public int deleteById(int id) {
		return dao.delete(id);
	}
}
