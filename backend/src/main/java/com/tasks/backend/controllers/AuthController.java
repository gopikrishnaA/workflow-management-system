package com.tasks.backend.controllers;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tasks.backend.entities.Role;
import com.tasks.backend.entities.RoleName;
import com.tasks.backend.entities.User;
import com.tasks.backend.message.request.LoginForm;
import com.tasks.backend.message.request.SignUpForm;
import com.tasks.backend.message.response.JwtResponse;
import com.tasks.backend.repositories.RoleRepository;
import com.tasks.backend.repositories.UserRepository;
import com.tasks.backend.security.jwt.JwtProvider;
import com.tasks.backend.utils.Client;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/auth")
public class AuthController {

	final String clientUrl = Client.clientUrl;

	@Autowired
	AuthenticationManager authenticationManager;

	@Autowired
	UserRepository userRepository;

	@Autowired
	RoleRepository roleRepository;

	@Autowired
	PasswordEncoder encoder;

	@Autowired
	JwtProvider jwtProvider;

	@PostMapping("/signin")
	@CrossOrigin(origins = clientUrl)
	public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginForm loginRequest) {

		Authentication authentication = authenticationManager.authenticate(
				new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));

		SecurityContextHolder.getContext().setAuthentication(authentication);

		String jwt = jwtProvider.generateJwtToken(authentication);
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		Optional<User> user = userRepository.findByUsername(userDetails.getUsername());
		JwtResponse jwtRes = new JwtResponse(jwt, userDetails.getUsername(), userDetails.getAuthorities(),
				user.get().getId(), user.get().getEmail());
		return ResponseEntity.ok(jwtRes);
	}

	@PostMapping("/signup")
	@CrossOrigin(origins = clientUrl)
	public ResponseEntity<?> registerUser(@Valid @RequestBody SignUpForm signUpRequest) {

		if (userRepository.existsByUsername(signUpRequest.getUsername())) {
			return new ResponseEntity<>("Username already exists", HttpStatus.BAD_REQUEST);
		}

		if (userRepository.existsByEmail(signUpRequest.getEmail())) {
			return new ResponseEntity<>("Email already exists", HttpStatus.BAD_REQUEST);
		}

		User user = new User(signUpRequest.getName(), signUpRequest.getUsername(), signUpRequest.getEmail(),
				encoder.encode(signUpRequest.getPassword()));

		Set<Role> roles = new HashSet<>();

		if (signUpRequest.getUser().equalsIgnoreCase("EMPLOYEE")) {
			Role userRole = roleRepository.findByName(RoleName.ROLE_EMPLOYEE)
					.orElseThrow(() -> new RuntimeException("Fail! -> Cause: User Role not find."));
			roles.add(userRole);

		} else if (signUpRequest.getUser().equalsIgnoreCase("MANAGER")) {
			Role adminRole = roleRepository.findByName(RoleName.ROLE_MANAGER)
					.orElseThrow(() -> new RuntimeException("Fail! -> Cause: User Role not find."));
			roles.add(adminRole);
		}

		user.setRoles(roles);
		userRepository.save(user);
		return new ResponseEntity<>("User created successfully", HttpStatus.OK);
	}
}