package com.tasks.backend.dto;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

public class NewProgramDTO {
	private long id;
	private String name;
	private String description;
	private long[] users;
	private long admin;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime startTime;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime endTime;

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

	public long[] getUsers() {
		return users;
	}

	public void setUsers(long[] users) {
		this.users = users;
	}

	public long getAdmin() {
		return admin;
	}

	public void setAdmin(long admin) {
		this.admin = admin;
	}

	public LocalDateTime getStartTime() {
		return startTime;
	}

	public void setStartTime(LocalDateTime startTime) {
		this.startTime = startTime;
	}

	public LocalDateTime getEndTime() {
		return endTime;
	}

	public void setEndTime(LocalDateTime endTime) {
		this.endTime = endTime;
	}

}
