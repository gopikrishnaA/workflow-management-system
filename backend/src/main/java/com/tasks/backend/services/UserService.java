package com.tasks.backend.services;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tasks.backend.entities.User;
import com.tasks.backend.repositories.InvitesRepository;
import com.tasks.backend.repositories.ProgramRepository;
import com.tasks.backend.repositories.UserRepository;
import com.tasks.backend.resources.ProgramResource;
import com.tasks.backend.resources.UserResource;

@Service
public class UserService {
  @Autowired
  private ProgramRepository programRepository;
  @Autowired
  private InvitesRepository invitesRepository;
  @Autowired
  private UserRepository userRepository;
 
  public List<UserResource> getAllUser() {
    return (List<UserResource>) userRepository.findAll()
                                .stream()
                                .map(user -> new UserResource(user))
                                .collect(Collectors.toList());
  }
  
  public List<UserResource> getUsersByRole(Long roleId) {
	    return (List<UserResource>) userRepository.findUsersByRoleId(roleId)
	                                .stream()
	                                .map(user -> new UserResource(user))
	                                .collect(Collectors.toList());
	  }
  
  public List<UserResource> getAllUserByProgram(long programId) {
    List<UserResource> users = programRepository.findById(programId)
                                .get()
                                .getUsers()
                                .stream()
                                .map(user -> new UserResource(user))
                                .collect(Collectors.toList());
    return users;
  }
  
  public List<ProgramResource> getAllProgramByUser(long uid) {
	  List<Long> pids = invitesRepository.findByUid(uid);
	  if (pids.isEmpty()) {
		  return new ArrayList<ProgramResource>();
	  }
	  return programRepository.findByPidIn(pids).stream().map(program -> new ProgramResource(program))
                                .collect(Collectors.toList());
	  
  }
  
  public User getUser(long id) {
    return userRepository.findById(id).get();
  }
}
