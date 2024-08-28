package com.karanpaul.springsecurity.repository;

import com.karanpaul.springsecurity.model.Notice;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NoticeRepository extends CrudRepository<Notice, Long> {
	
	@Query(value = "from Notice n where CURDATE() BETWEEN noticBegDt AND noticEndDt") //JPQL Query
	List<Notice> findAllActiveNotices();

}
