package com.tasks.backend.dto;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;

import com.fasterxml.jackson.annotation.JsonFormat;

public class EditTaskDTO {
	private long id;

	private String name;

	private long createdBy;

	private long modifiedBy;

	private long managerId;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime createdTime;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime startTime;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime deadline;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime modifiedTime;

	private String status;

	@Column(length = 65450, columnDefinition = "text")
	private String description;

	private List<Long> users;

	public long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public long getCreatedBy() {
		return createdBy;
	}

	public LocalDateTime getStartTime() {
		return startTime;
	}

	public LocalDateTime getCreatedTime() {
		return createdTime;
	}

	public LocalDateTime getDeadline() {
		return deadline;
	}

	public long getModifiedBy() {
		return modifiedBy;
	}

	public LocalDateTime getModifiedTime() {
		return modifiedTime;
	}

	public String getStatus() {
		return status;
	}

	public String getDescription() {
		return description;
	}

	public void setId(long id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setCreatedBy(long createdBy) {
		this.createdBy = createdBy;
	}

	public void setCreatedTime(LocalDateTime createdTime) {
		this.createdTime = createdTime;
	}

	public void setStartTime(LocalDateTime startTime) {
		this.startTime = startTime;
	}

	public void setDeadline(LocalDateTime deadline) {
		this.deadline = deadline;
	}

	public void setModifiedBy(long modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public void setModifiedTime(LocalDateTime modifiedTime) {
		this.modifiedTime = modifiedTime;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public long getManagerId() {
		return managerId;
	}

	public void setManagerId(long managerId) {
		this.managerId = managerId;
	}

	public List<Long> getUsers() {
		return users;
	}

	public void setUsers(List<Long> user) {
		this.users = user;
	}
}
