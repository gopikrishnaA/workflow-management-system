package com.tasks.backend.repositories;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.tasks.backend.entities.Invites;

@Repository
public interface InvitesRepository extends JpaRepository<Invites, Long> {

	Boolean existsByUid(long uid);

	@Query("SELECT i.pid FROM Invites i WHERE i.uid=:uid")
	long getPidByUid(@Param("uid") long uid);

	@Query("SELECT i.pid FROM Invites i WHERE i.uid=:uid")
	List<Long> findByUid(long uid);
	
	List<Invites> findByPid(long pid);

	@Modifying
	@Transactional
	@Query("DELETE FROM Invites i WHERE i.pid = :pid")
	void deleteByPid(long pid);
}
