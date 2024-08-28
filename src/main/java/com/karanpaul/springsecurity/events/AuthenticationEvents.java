package com.karanpaul.springsecurity.events;

import lombok.extern.log4j.Log4j2;
import org.springframework.context.event.EventListener;
import org.springframework.security.authentication.event.AbstractAuthenticationEvent;
import org.springframework.security.authentication.event.AuthenticationSuccessEvent;
import org.springframework.stereotype.Component;

@Component
@Log4j2
public class AuthenticationEvents {
    @EventListener
    public void onSuccess(AuthenticationSuccessEvent successEvent){
        log.info("Login was successful for user {}: ",successEvent.getAuthentication().getName());
    }

    @EventListener
    public void onFailure(AbstractAuthenticationEvent failureEvent){
        log.error("Login failed for the user : {} due to : {}", failureEvent.getAuthentication().getName(),
                failureEvent.getAuthentication().getDetails());
    }
}
