package com.entity;

public class Role {
	private int role_id;
	private String role_name;
	private String role_pwd;
	private String role_identity;
	private int role_status;
	
	public Role() {
		super();
	}
	
	public Role(String role_name, String role_pwd, String role_identity, int role_status) {
		super();
		this.role_name = role_name;
		this.role_pwd = role_pwd;
		this.role_identity = role_identity;
		this.role_status = role_status;
	}
	public int getRole_id() {
		return role_id;
	}
	public void setRole_id(int role_id) {
		this.role_id = role_id;
	}
	
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
	
	public String getRole_pwd() {
		return role_pwd;
	}
	public void setRole_pwd(String role_pwd) {
		this.role_pwd = role_pwd;
	}
	
	public String getRole_identity() {
		return role_identity;
	}
	public void setRole_identity(String role_identity) {
		this.role_identity = role_identity;
	}
	
	public int getRole_status() {
		return role_status;
	}
	public void setRole_status(int role_status) {
		this.role_status = role_status;
	}
	@Override
	public String toString() {
		return "Role [role_id=" + role_id + ", role_name=" + role_name + ", role_pwd=" + role_pwd + ", role_indentity="
				+ role_identity + "]";
	}
	
}
