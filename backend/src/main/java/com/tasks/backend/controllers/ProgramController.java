package com.tasks.backend.controllers;

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

import com.tasks.backend.dto.NewProgramDTO;
import com.tasks.backend.resources.ProgramListResource;
import com.tasks.backend.resources.ProgramWithUserResource;
import com.tasks.backend.services.ProgramService;
import com.tasks.backend.services.UserService;
import com.tasks.backend.utils.Client;

@RestController
public class ProgramController {
	final String clientUrl = Client.clientUrl;

	@Autowired
	private ProgramService service;

	@Autowired
	private UserService userService;

	@PostMapping("/createSchedule/{uid}")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	public ResponseEntity<Boolean> createProgram(@PathVariable("uid") Long uid,
			@RequestBody NewProgramDTO newProgramDto) {
		service.createProgram(newProgramDto, uid);
		return new ResponseEntity<Boolean>(true, HttpStatus.OK);
	}
	
	@PostMapping("/updateSchedule/{uid}/{pid}")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	public ResponseEntity<Boolean> updateSchedule(@PathVariable("uid") Long uid, @PathVariable("pid") Long pid,
			@RequestBody NewProgramDTO newProgramDto) {
		service.updateProgram(newProgramDto, uid, pid);
		return new ResponseEntity<Boolean>(true, HttpStatus.OK);
	}

	@GetMapping("/getAllProgram")
	@PreAuthorize("hasRole('EMPLOYEE') or hasRole('ADMIN')")
	@CrossOrigin(origins = clientUrl)
	public ResponseEntity<ProgramListResource> getAllProgram() {
		return new ResponseEntity<ProgramListResource>(service.getAll(), HttpStatus.OK);
	}

	@GetMapping("/getAllProgramByAdmin/{id}")
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	@CrossOrigin(origins = clientUrl)
	public ResponseEntity<ProgramListResource> getAllProgramByAdmin(@PathVariable("id") Long id) {
		ProgramListResource dto = service.getAllByAdmin(id);
		return new ResponseEntity<ProgramListResource>(dto, HttpStatus.OK);
	}

	@GetMapping("/getProgramByAdmin/{id}/{pid}")
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	@CrossOrigin(origins = clientUrl)
	public ResponseEntity<ProgramWithUserResource> getProgramByAdmin(@PathVariable("id") Long id,
			@PathVariable("pid") Long pid) {
		ProgramWithUserResource dto = service.getProgramByAdmin(id, pid);
		return new ResponseEntity<ProgramWithUserResource>(dto, HttpStatus.OK);
	}

	@GetMapping("/getAllProgramByUser/{uid}")
	@PreAuthorize("hasRole('EMPLOYEE') or hasRole('ADMIN')")
	@CrossOrigin(origins = clientUrl)
	public ResponseEntity<ProgramListResource> getAllProgramByUser(@PathVariable("uid") Long uid) {
		ProgramListResource dto = new ProgramListResource();
		dto.setProgramList(userService.getAllProgramByUser(uid));
		return new ResponseEntity<ProgramListResource>(dto, HttpStatus.OK);
	}
}
