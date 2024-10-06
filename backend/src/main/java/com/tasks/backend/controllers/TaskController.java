package com.tasks.backend.controllers;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.tasks.backend.dto.EditTaskDTO;
import com.tasks.backend.dto.NewTaskDTO;
import com.tasks.backend.dto.UpdateTaskDTO;
import com.tasks.backend.entities.Task;
import com.tasks.backend.resources.TaskListResource;
import com.tasks.backend.resources.TaskRecordListResource;
import com.tasks.backend.services.TaskService;
import com.tasks.backend.utils.Client;

@RestController
public class TaskController {

	final String clientUrl = Client.clientUrl;

	@Autowired
	private TaskService service;

	@PostMapping("/createTask")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	public ResponseEntity<Boolean> createTask(@RequestBody NewTaskDTO newTaskDto) {
		Task task = new Task();
		BeanUtils.copyProperties(newTaskDto.getTask(), task);
		service.createTask(task, newTaskDto.getUser(), newTaskDto.getManagerId());
		return new ResponseEntity<Boolean>(true, HttpStatus.OK);
	}

	@PostMapping("/updateTask")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	public ResponseEntity<?> updateTask(@RequestBody EditTaskDTO taskDTO) {
		service.updateTask(taskDTO);
		return new ResponseEntity<Boolean>(true, HttpStatus.OK);
	}

	@GetMapping("/getTask/{id}")
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	@CrossOrigin(origins = clientUrl)
	public ResponseEntity<EditTaskDTO> getTask(@PathVariable("id") Long id) {
		EditTaskDTO dto = service.getTask(id);
		return new ResponseEntity<EditTaskDTO>(dto, HttpStatus.OK);
	}

	@GetMapping("/getTaskByEmployee/{uid}/{id}")
	@PreAuthorize("hasRole('EMPLOYEE') or hasRole('ADMIN')")
	@CrossOrigin(origins = clientUrl)
	public ResponseEntity<EditTaskDTO> getTaskByEmployee(@PathVariable("uid") Long uid, @PathVariable("id") Long id) {
		EditTaskDTO dto = service.getTaskByEmployee(uid, id);
		return new ResponseEntity<EditTaskDTO>(dto, HttpStatus.OK);
	}

	@GetMapping("/getAllTaskRecord")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('ADMIN')")
	public ResponseEntity<TaskRecordListResource> getAllTaskRecord() {
		// service call
		TaskRecordListResource trlr = service.getAllTaskRecord();
		return new ResponseEntity<TaskRecordListResource>(trlr, HttpStatus.OK);
	}

	@GetMapping("/getAllTaskByManager/{uid}")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	public ResponseEntity<TaskListResource> getAllTaskByManager(@PathVariable("uid") Long uid) {
		// service call
		TaskListResource tlr = service.getAllTaskByManager(uid);
		return new ResponseEntity<TaskListResource>(tlr, HttpStatus.OK);
	}

	@GetMapping("/getAllTaskByUser/{uid}")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('EMPLOYEE') or hasRole('ADMIN')")
	public ResponseEntity<TaskListResource> getAllTaskByUser(@PathVariable("uid") Long uid) {
		// service call
		TaskListResource tlr = service.getAllTaskByUser(uid);
		return new ResponseEntity<TaskListResource>(tlr, HttpStatus.OK);
	}

	@PostMapping("/updateTaskStatus")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('EMPLOYEE') or hasRole('ADMIN')")
	public ResponseEntity<Boolean> updateTaskStatus(@RequestBody UpdateTaskDTO taskDTO) {
		service.setTaskStatus(taskDTO);
		return new ResponseEntity<>(true, HttpStatus.OK);
	}

}
