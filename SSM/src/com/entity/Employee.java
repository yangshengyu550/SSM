package com.entity;

public class Employee {
	private int id;
	private String name;
	private String sex;
	private int age;
	private String department;
	private String email;
	private String tel;
	public Employee(String name, String sex, int age, String department, String email, String tel) {
		super();
		this.name = name;
		this.sex = sex;
		this.age = age;
		this.department = department;
		this.email = email;
		this.tel = tel;
	}
	public Employee() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	@Override
	public String toString() {
		return "Employee [id=" + id + ", name=" + name + ", sex=" + sex + ", age=" + age + ", department=" + department
				+ ", email=" + email + ", tel=" + tel + "]";
	}
	
}
