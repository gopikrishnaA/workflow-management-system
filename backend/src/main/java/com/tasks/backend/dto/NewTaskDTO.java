package com.tasks.backend.dto;

import java.util.List;

public class NewTaskDTO {
	private TaskDTO task;
	private List<Long> user;
	private long managerId;

	public TaskDTO getTask() {
		return task;
	}

	public void setTask(TaskDTO task) {
		this.task = task;
	}

	public long getManagerId() {
		return managerId;
	}

	public void setManagerId(long managerId) {
		this.managerId = managerId;
	}

	public List<Long> getUser() {
		return user;
	}

	public void setUser(List<Long> user) {
		this.user = user;
	}

}