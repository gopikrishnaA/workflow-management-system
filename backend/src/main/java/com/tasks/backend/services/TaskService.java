package com.tasks.backend.services;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tasks.backend.dto.EditTaskDTO;
import com.tasks.backend.dto.UpdateTaskDTO;
import com.tasks.backend.entities.Task;
import com.tasks.backend.entities.TaskRecord;
import com.tasks.backend.repositories.TaskRecordRepository;
import com.tasks.backend.repositories.TaskRespository;
import com.tasks.backend.resources.TaskListResource;
import com.tasks.backend.resources.TaskRecordListResource;

@Service
public class TaskService {
	@Autowired
	private TaskRespository taskRepository;
	@Autowired
	private TaskRecordRepository taskRecordRepository;

	public void createTask(Task task, List<Long> users, long managerId) {
		task.setCreatedTime(LocalDateTime.now());
		task.setManagerId(managerId);
		Task savedTask = taskRepository.save(task);
		this.initTaskRecords(users, savedTask.getId(), managerId);
	}

	public void initTaskRecords(List<Long> trainees, long taskId, long managerId) {
		for (long id : trainees) {
			TaskRecord taskRecord = new TaskRecord();
			taskRecord.setUser(id);
			taskRecord.setTask(taskId);
			taskRecord.setManager(managerId);
			taskRecord.setStatus("OPEN");
			taskRecordRepository.save(taskRecord);
		}
	}

	public List<Task> getTasksFromTaskRecord(List<TaskRecord> taskRecordList) {
		List<Task> tasks = new ArrayList<Task>();
		for (TaskRecord taskRecord : taskRecordList) {
			tasks.add(taskRepository.findById(taskRecord.getTask()).get());
		}
		return tasks;
	}

	public TaskListResource getAllTask() {
		List<Task> taskList = (List<Task>) taskRepository.findAll();
		TaskListResource tlr = new TaskListResource();
		tlr.setTaskList(taskList);
		return tlr;
	}

	public TaskRecordListResource getAllTaskRecord() {
		TaskRecordListResource trlr = new TaskRecordListResource();
		trlr.setTaskRecordList((List<TaskRecord>) taskRecordRepository.findAll());
		return trlr;
	}

	public TaskListResource getAllTaskByManager(long uid) {
		List<Task> taskList = (List<Task>) taskRepository.findByManagerId(uid);
		TaskListResource tlr = new TaskListResource();
		tlr.setTaskList(taskList);
		return tlr;
	}

	public TaskListResource getAllTaskByUser(long uid) {
		List<Long> taskIds = taskRecordRepository.findByUser(uid);
		TaskListResource listResource = new TaskListResource();
		if (taskIds.isEmpty()) {
			listResource.setTaskList(new ArrayList<>());
			return listResource;
		}
		List<Task> tasksList = taskRepository.findByTaskIdsIn(taskIds);
		listResource.setTaskList(tasksList);
		return listResource;
	}

	public void updateTask(EditTaskDTO taskDTO) {
		Task task = taskRepository.findById(taskDTO.getId())
				.orElseThrow(() -> new RuntimeException("Task not found with id: " + taskDTO.getId()));
		task.setName(taskDTO.getName());
		task.setDescription(taskDTO.getDescription());
		task.setStartTime(taskDTO.getStartTime());
		task.setDeadline(taskDTO.getDeadline());
		task.setModifiedTime(LocalDateTime.now());
		task.setModifiedBy(task.getManagerId());
		task.setStatus("UPDATE");
		Task updatedTask = taskRepository.save(task);

		List<Long> users = taskDTO.getUsers();
		taskRecordRepository.deleteByTask(task.getId());
		this.initTaskRecords(users, updatedTask.getId(), task.getManagerId());
	}

	public EditTaskDTO getTask(Long id) {
		Task task = taskRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Task not found with id: " + id));
		EditTaskDTO dto = new EditTaskDTO();
		dto.setId(task.getId());
		dto.setName(task.getName());
		dto.setDescription(task.getDescription());
		dto.setCreatedBy(task.getCreatedBy());
		dto.setCreatedTime(task.getCreatedTime());
		dto.setDeadline(task.getDeadline());
		dto.setModifiedBy(task.getModifiedBy());
		dto.setModifiedTime(task.getModifiedTime());
		dto.setManagerId(task.getManagerId());
		dto.setStartTime(task.getStartTime());
		dto.setStatus(task.getStatus());

		List<TaskRecord> taskRecords = taskRecordRepository.findByTask(task.getId());
		List<Long> uids = taskRecords.stream().map(TaskRecord::getUser).collect(Collectors.toList());
		dto.setUsers(uids);
		return dto;
	}

	public EditTaskDTO getTaskByEmployee(Long uid, Long id) {
		Task task = taskRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Task not found with id: " + id));
		EditTaskDTO dto = new EditTaskDTO();
		dto.setId(task.getId());
		dto.setName(task.getName());
		dto.setDescription(task.getDescription());
		dto.setCreatedBy(task.getCreatedBy());
		dto.setCreatedTime(task.getCreatedTime());
		dto.setDeadline(task.getDeadline());
		dto.setModifiedBy(task.getModifiedBy());
		dto.setModifiedTime(task.getModifiedTime());
		dto.setManagerId(task.getManagerId());
		dto.setStartTime(task.getStartTime());

		List<TaskRecord> taskRecords = taskRecordRepository.findByTaskAndUser(task.getId(), uid);
		if (!taskRecords.isEmpty()) {
			dto.setStatus(taskRecords.get(0).getStatus());
		}
		dto.setUsers(null);
		return dto;
	}

	public void setTaskStatus(UpdateTaskDTO taskDTO) {

		List<TaskRecord> taskRecords = taskRecordRepository.findByTaskAndUser(taskDTO.getId(), taskDTO.getUid());
		if (!taskRecords.isEmpty()) {
			for (TaskRecord taskRecord : taskRecords) {
				taskRecord.setStatus(taskDTO.getStatus());
				taskRecordRepository.save(taskRecord);
			}
		}

	}
}
