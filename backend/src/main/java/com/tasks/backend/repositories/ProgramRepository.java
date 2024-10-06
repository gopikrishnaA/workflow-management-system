package com.tasks.backend.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.tasks.backend.entities.Program;

@Repository
public interface ProgramRepository extends JpaRepository<Program, Long> {

	List<Program> findByAdmin(long admin);

	Optional<Program> findById(long id);

	@Query("SELECT i FROM Program i WHERE i.id IN :pids")
	List<Program> findByPidIn(@Param("pids") List<Long> pids);
}