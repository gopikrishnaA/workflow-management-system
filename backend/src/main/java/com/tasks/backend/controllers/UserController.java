package com.tasks.backend.controllers;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.tasks.backend.resources.UserListResource;
import com.tasks.backend.resources.UserResource;
import com.tasks.backend.services.UserService;
import com.tasks.backend.utils.Client;

@RestController
public class UserController {

	@Autowired
	private UserService service;

	final String clientUrl = Client.clientUrl;

	@GetMapping("/getAllUser")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	public ResponseEntity<UserListResource> getAllUser() {
		UserListResource ulr = new UserListResource();
		ulr.setUserList(service.getAllUser());
		return new ResponseEntity<UserListResource>(ulr, HttpStatus.OK);
	}

	@GetMapping("/getUsersByRole/{roleId}")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	public ResponseEntity<UserListResource> getUsersByRole(@PathVariable("roleId") Long roleId) {
		UserListResource ulr = new UserListResource();
		ulr.setUserList(service.getUsersByRole(roleId));
		return new ResponseEntity<UserListResource>(ulr, HttpStatus.OK);
	}

	@GetMapping("/getAllUser/{pid}")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	public ResponseEntity<UserListResource> getAllUser(@PathVariable("pid") Long pid) {
		UserListResource ulr = new UserListResource();
		ulr.setUserList(service.getAllUserByProgram(pid));
		return new ResponseEntity<UserListResource>(ulr, HttpStatus.OK);
	}

	@GetMapping("/getUser/{uid}")
	@CrossOrigin(origins = clientUrl)
	@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
	public ResponseEntity<UserResource> getUserById(@PathVariable("uid") Long uid) {
		UserResource ur = new UserResource();
		BeanUtils.copyProperties(service.getUser(uid), ur);
		return new ResponseEntity<UserResource>(ur, HttpStatus.OK);
	}
}
