package com.karanpaul.springsecurity.controller;

import com.karanpaul.springsecurity.model.Customer;
import com.karanpaul.springsecurity.repository.CustomerRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class CustomerController {
    private final CustomerRepository customerRepository;
    private final PasswordEncoder passwordEncoder;
    public ResponseEntity<String> registerCustomer(@RequestBody Customer customer){
        try{
            customer.setPwd(passwordEncoder.encode(customer.getPwd()));
            Customer savedCustomer = customerRepository.save(customer);
            if(savedCustomer!=null){
                return ResponseEntity.status(HttpStatus.ACCEPTED).body("Customer successfully registered");
            }
        }catch(Exception e){
            return ResponseEntity.internalServerError().body("Error registering the user");
        }

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("User registration Failed");
    }
}
