package com.karanpaul.springsecurity;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

/*
* If the entity and the repository classes are written outside the main package.
* then we can include the below annotations
* */
//@EnableJpaRepositories("com/lazy")
//@EntityScan("com/entity")
@SpringBootApplication
public class SpringsecurityApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringsecurityApplication.class, args);
	}

}
