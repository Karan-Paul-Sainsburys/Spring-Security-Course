package com.karanpaul.springsecurity.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SpringSecurityController {

    @GetMapping("/welcome")
    public String greetings(){
        return "Welcome to spring project with security";
    }
}
