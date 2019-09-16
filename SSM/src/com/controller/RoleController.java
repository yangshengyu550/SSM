package com.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.entity.Role;
import com.service.RoleService;
import com.util.ResponseUtil;

@Controller
@ContextConfiguration(locations ={"classpath:applicationContext.xml"})
public class RoleController {
	
	private Logger log = Logger.getLogger(this.getClass());
	@Autowired
	RoleService roleService;
	
	@RequestMapping(value= {"/login","/"})
	public String loginpage() {
		return "/login";
	}
	
	@RequestMapping(value="/logincheck",method = RequestMethod.POST)
	public String loginSystem(HttpServletRequest request,String role_name,String role_pwd) throws Exception{
		Role role = roleService.loginChecked(role_name);
		String msg = "";
		if(role!=null && role_pwd.equals(role.getRole_pwd())&&role.getRole_status()==1) {
			request.setAttribute("role", role);
			return "/main";
		}else if(role==null||!role_pwd.equals(role.getRole_pwd())) {
			msg = "用户名或密码不正确！";
			request.setAttribute("msg",msg);
			return "/login";
		}else if(role.getRole_status()!=1){
			msg = "你已被禁止登录！";
			request.setAttribute("msg",msg);
			return "/login";
		}else {
			msg = "非法访问！";
			request.setAttribute("msg",msg);
			return "/login";
		}
	}
	
	public String charsetUTF8(String s) throws UnsupportedEncodingException {
		return new String(s.getBytes("ISO-8859-1"),"UTF-8");
	}
	
	@RequestMapping(value="/addRole",method= RequestMethod.POST)
	public String addRole(HttpServletRequest request,String username,String password) {
		Role role = new Role();
		role.setRole_name(username);
		role.setRole_pwd(password);
		role.setRole_identity("user");
		role.setRole_status(1);
		roleService.addRole(role);
		request.setAttribute("msg","注册成功!");
		return "/login";
	}
	
	@RequestMapping(value= "/main")
	public String loadMainPage() {
		return "redirect:/login";
	}
	/*
	 * 获取管理员人员信息
	 */
	@RequestMapping(value="/getRoleList")
	@ResponseBody
	public Map<String, Object> showAllRoles(@RequestParam Map<String, String> map) throws Exception {
	    Map<String, Object> map1 = new HashMap<>();
	    List<Map<String, String>> list = new ArrayList<>();
	    List<Role> roles = roleService.selectAllRoles();
	    Role role = null;
	    for (int i = 0; i < roles.size(); i++) {
	    	role = roles.get(i);
	        map = new HashMap<>();
	        map.put("role_id", String.valueOf(role.getRole_id()));
	        map.put("role_name", role.getRole_name());
	        map.put("role_pwd",role.getRole_pwd());
	        map.put("role_identity", role.getRole_identity());
	        map.put("role_status", String.valueOf(role.getRole_status()));
	        list.add(map);
	    }
	    map1.put("rows", list);
	    map1.put("total", roles.size());
	    return map1;
	}
	
	@RequestMapping(value="/saveRole")
	@ResponseBody
	public String updateRole(Role role,HttpServletResponse response) {
		System.out.println(role.toString());
		int fact = 0;
		if(role.getRole_id()==0) {
			fact = roleService.addRole(role);
		}else {
			fact = roleService.updateRole(role);
		}
		return null;
	}
	
	@RequestMapping(value="/deleteRole")
	@ResponseBody
	public String deleteRole(@RequestParam(value="ids")String ids,HttpServletResponse response){
		try {
			Map<String, Object> map = new HashMap<>();
			String[] idsStr = ids.split(",");
			for (int i = 0; i < idsStr.length; i++) {
				int n = roleService.deleteRole(Integer.parseInt(idsStr[i]));
				System.out.println(n);
			}
			map.put("success", true);
			ResponseUtil.write(response, map);
			log.info("删除用户,ids:" + ids);
		} catch (Exception e) {
			e.getMessage();
		}finally {
			System.out.print(ids);
		}
		return null;
	}
}
