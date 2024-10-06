package com.tasks.backend.services;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tasks.backend.dto.NewProgramDTO;
import com.tasks.backend.entities.Invites;
import com.tasks.backend.entities.Program;
import com.tasks.backend.entities.User;
import com.tasks.backend.repositories.InvitesRepository;
import com.tasks.backend.repositories.ProgramRepository;
import com.tasks.backend.repositories.UserRepository;
import com.tasks.backend.resources.ProgramListResource;
import com.tasks.backend.resources.ProgramResource;
import com.tasks.backend.resources.ProgramWithUserResource;

@Service
public class ProgramService {

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private ProgramRepository programRepository;
	@Autowired
	private InvitesRepository invitesRepository;

	public long createProgram(NewProgramDTO newProgramDto, long admin) {
		Program program = new Program();
		program.setId(newProgramDto.getId());
		program.setName(newProgramDto.getName());
		program.setDescription(newProgramDto.getDescription());
		program.setStartTime(newProgramDto.getStartTime());
		program.setEndTime(newProgramDto.getEndTime());
		program.setAdmin(admin);
		User user = userRepository.findById(admin).get();
		List<User> userList = new ArrayList<User>();
		userList.add(user);
		program.setUsers(userList);
		Program savedProgram = programRepository.save(program);

		long[] users = newProgramDto.getUsers();
		inviteUsers(users, savedProgram.getId());

		return savedProgram.getId();
	}

	public long updateProgram(NewProgramDTO newProgramDto, long admin, long pid) {
		Program program = programRepository.findById(pid)
				.orElseThrow(() -> new RuntimeException("Program not found with id: " + pid));

		program.setName(newProgramDto.getName());
		program.setDescription(newProgramDto.getDescription());
		program.setStartTime(newProgramDto.getStartTime());
		program.setEndTime(newProgramDto.getEndTime());

		program.setAdmin(admin);

		User adminUser = userRepository.findById(admin)
				.orElseThrow(() -> new RuntimeException("Admin not found with id: " + admin));

		List<User> userList = new ArrayList<>();
		userList.add(adminUser);
		program.setUsers(userList);

		Program updatedProgram = programRepository.save(program);

		long[] users = newProgramDto.getUsers();
		invitesRepository.deleteByPid(pid);
		inviteUsers(users, updatedProgram.getId());

		return updatedProgram.getId(); // Return the id of the updated program
	}

	public void inviteUsers(long[] users, long pid) {

		for (long uid : users) {
			Invites invites = new Invites();
			invites.setPid(pid);
			invites.setUid(uid);
			invitesRepository.save(invites);
		}
	}

	public ProgramListResource getAll() {
		ProgramListResource list = new ProgramListResource();
		list.setProgramList((List<ProgramResource>) programRepository.findAll().stream()
				.map(p -> new ProgramResource(p)).collect(Collectors.toList()));
		return list;
	}

	public ProgramListResource getAllByAdmin(long id) {
		ProgramListResource list = new ProgramListResource();
		list.setProgramList((List<ProgramResource>) programRepository.findByAdmin(id).stream()
				.map(p -> new ProgramResource(p)).collect(Collectors.toList()));
		return list;
	}

	public ProgramWithUserResource getProgramByAdmin(long id, long pid) {
		Program program = programRepository.findById(pid)
				.orElseThrow(() -> new RuntimeException("Program not found with id: " + pid));
		
		ProgramWithUserResource programWithUserResource = new ProgramWithUserResource();
		programWithUserResource.setAdmin(program.getAdmin());
		programWithUserResource.setName(program.getName());
		programWithUserResource.setDescription(program.getDescription());
		programWithUserResource.setStartTime(program.getStartTime().toString());
		programWithUserResource.setEndTime(program.getEndTime().toString());
		programWithUserResource.setId(program.getId());
		List<Invites> invites = invitesRepository.findByPid(pid);
		List<Long> uids = invites.stream().map(Invites::getUid).collect(Collectors.toList());
		programWithUserResource.setUsers(uids);
		return programWithUserResource;
	}
}
