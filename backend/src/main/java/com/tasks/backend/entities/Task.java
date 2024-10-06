package com.tasks.backend.entities;

import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import org.springframework.stereotype.Component;
import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Component
public class Task {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	private String name;

	private long createdBy;

	private long managerId;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime createdTime;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime startTime;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime deadline;

	private long modifiedBy;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime modifiedTime;

	private String status;

	@Column(length = 65450, columnDefinition = "text")
	private String description;

//	public Task(Task task) {
//		this.id = task.getId();
//		this.name = task.getName();
//		this.description = task.getDescription();
//		this.startTime = task.getStartTime();
//		this.createdTime = task.getCreatedTime();
//		this.deadline = task.getDeadline();
//		this.modifiedTime = task.getModifiedTime();
//		this.createdBy = task.getCreatedBy();
//		this.modifiedBy = task.getModifiedBy();
//		this.managerId = task.getManagerId();
//		this.status = task.getStatus();
//	}

	public long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public long getCreatedBy() {
		return createdBy;
	}

	public LocalDateTime getCreatedTime() {
		return createdTime;
	}

	public LocalDateTime getStartTime() {
		return startTime;
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

//  public void setProgram(long program) {
//    this.program = program;
//  }

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
}
