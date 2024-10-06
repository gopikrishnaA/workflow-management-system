package com.tasks.backend.resources;

import java.util.List;

public class ProgramWithUserResource {

	private long id;
	private String name;
	private String description;
	private long admin;
	private String startTime;
	private String endTime;
	private List<Long> users;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public long getAdmin() {
		return admin;
	}

	public void setAdmin(long admin) {
		this.admin = admin;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public List<Long> getUsers() {
		return users;
	}

	public void setUsers(List<Long> users) {
		this.users = users;
	}

}
