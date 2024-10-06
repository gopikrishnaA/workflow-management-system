package com.tasks.backend.repositories;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.tasks.backend.entities.TaskRecord;

@Repository
public interface TaskRecordRepository extends JpaRepository<TaskRecord, Long> {

	@Query("SELECT t FROM TaskRecord t WHERE t.user=:id")
	List<TaskRecord> getTaskRecordByUser(@Param("id") long user);

	@Modifying
	@Transactional
	@Query("DELETE FROM TaskRecord i WHERE i.task = :task")
	void deleteByTask(long task);

	List<TaskRecord> findByTask(long task);

	@Query("SELECT t FROM TaskRecord t WHERE t.task = :task AND t.user = :user")
	List<TaskRecord> findByTaskAndUser(@Param("task") long l, @Param("user") Long uid);

	@Query("SELECT i.task FROM TaskRecord i WHERE i.user=:uid")
	List<Long> findByUser(long uid);
}
