package com.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Employee;
import com.service.EmployeeService;
import com.util.ResponseUtil;

@Controller
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class EmployeeController {
	
	private static final Logger log = Logger.getLogger(EmployeeController.class);
	@Autowired
	private EmployeeService es;
	
	/*
	 * 获取员工列表
	 */
	@RequestMapping(value = "/getMap")
	@ResponseBody
	public Map<String, Object> showAll(@RequestParam Map<String, String> map) throws Exception {
	    Map<String, Object> map1 = new HashMap<>();
	    List<Map<String, String>> list = new ArrayList<>();
	    List<Employee> emp = es.allEmployees();
	    Employee e = null;
	    for (int i = 0; i < emp.size(); i++) {
	    	e = emp.get(i);
	        map = new HashMap<>();
	        map.put("id", String.valueOf(e.getId()));
	        map.put("name", e.getName());
	        map.put("sex",e.getSex());
	        map.put("age", String.valueOf(e.getAge()));
	        map.put("department", e.getDepartment());
	        map.put("email", e.getEmail());
	        map.put("tel", e.getTel());
	        list.add(map);
	    }
	    map1.put("rows", list);
	    map1.put("total", emp.size());
	    log.info("员工列表");
	    return map1;
	}
	
	/*
	 * 获取员工列表
	 */
	@RequestMapping(value = "/getMapByDept")
	@ResponseBody
	public Map<String, Object> getMapByDept(@RequestParam Map<String, String> map,HttpServletRequest request) throws Exception {
		String department = new String(request.getParameter("department").getBytes("ISO-8859-1"),"UTF-8");
		System.out.print(department);
	    Map<String, Object> map1 = new HashMap<>();
	    List<Map<String, String>> list = new ArrayList<>();
	    List<Employee> emp = es.getMapByDept(department);
	    Employee e = null;
	    for (int i = 0; i < emp.size(); i++) {
	    	e = emp.get(i);
	        map = new HashMap<>();
	        map.put("id", String.valueOf(e.getId()));
	        map.put("name", e.getName());
	        map.put("sex",e.getSex());
	        map.put("age", String.valueOf(e.getAge()));
	        map.put("department", e.getDepartment());
	        map.put("email", e.getEmail());
	        map.put("tel", e.getTel());
	        list.add(map);
	    }
	    map1.put("rows", list);
	    map1.put("total", emp.size());
	    log.info("员工列表");
	    return map1;
	}
	
	/*
	 * 添加或者修改员工信息
	 */
	@RequestMapping(value = "/saveEmployee")
	@ResponseBody
	public String save(Employee e,HttpServletResponse response) throws UnsupportedEncodingException {
		if(e.getId()==0) {
			int fact = es.addEmployee(e);
			log.info("添加员工："+e.toString());
		}else {
			int fact = es.updateEmployee(e);
			System.out.println("update:"+fact);
			log.info("修改信息："+e.toString());
		}
		return null;
	}
	
	/*
	 * 删除员工信息
	 */
	@RequestMapping(value = "/deleteEmployee")
	@ResponseBody
	public String delete(@RequestParam(value="ids")String ids,HttpServletResponse response) throws Exception {//删除员工信息
		Map<String, Object> map = new HashMap<>();
		String [] idsStr = ids.split(",");
		for (int i = 0; i < idsStr.length; i++) {
			int n = es.deleteById(Integer.parseInt(idsStr[i]));
			System.out.println(n);
		}
		map.put("success", true);
		ResponseUtil.write(response, map);
		log.info("删除员工,ids:"+ids);
		return null;
	}
	
	@RequestMapping("/logout")
    public String logout(HttpSession session) throws Exception {
        session.invalidate();
        log.info("退出登录");
        return "redirect:/login";
    }
}
