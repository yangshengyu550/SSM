package com.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.entity.Employee;
import com.entity.Role;
import com.service.EmployeeService;
import com.service.RoleService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class testColumn {

	@Autowired
	RoleService roleService;
	EmployeeService employeeService;
	@Test
	public void deleteRolesTest() {
		Role role = new Role();
		int fact = roleService.deleteRole(8);
		System.out.print(fact);
	}
	
	@Test
	public void getEmpolyeesTest() {
		List<Employee> list;
		try {
			list = employeeService.allEmployees();
			for(Employee r:list) {
				System.out.println(r.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
