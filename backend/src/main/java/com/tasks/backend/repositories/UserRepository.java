package com.tasks.backend.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.tasks.backend.entities.Program;
import com.tasks.backend.entities.User;
import com.tasks.backend.resources.UserResource;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUsername(String username);
    
    Boolean existsByUsername(String username);
    
    Boolean existsByEmail(String email);
    
    @Query("SELECT u.id FROM User u WHERE u.username=:username")
    long getIdByUsername(@ Param("username") String username);

    @Query("SELECT u.program FROM User u WHERE u.id=:id")
    List<Program> findProgramById(long id);
    
    public static final String FIND_USER = "SELECT id, name, username, email, password FROM users";

    @Query(value = FIND_USER, nativeQuery = true)
    public List<UserResource> findAllUsers();
    
    @Query(value = "SELECT * FROM users u INNER JOIN user_roles ur ON u.id = ur.user_id WHERE ur.role_id = :roleId", nativeQuery = true)
    List<User> findUsersByRoleId(@Param("roleId") Long roleId);
}