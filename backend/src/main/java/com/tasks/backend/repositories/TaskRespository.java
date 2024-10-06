package com.tasks.backend.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.tasks.backend.entities.Task;

@Repository
public interface TaskRespository extends JpaRepository<Task, Long> {
	List<Task> findByManagerId(long managerId);
	
	@Query("SELECT i FROM Task i WHERE i.id IN :taskIds")
	List<Task> findByTaskIdsIn(@Param("taskIds") List<Long> taskIds);
}
