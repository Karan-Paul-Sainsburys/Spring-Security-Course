package com.karanpaul.springsecurity.config;

import com.karanpaul.springsecurity.model.Customer;
import com.karanpaul.springsecurity.repository.CustomerRepository;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

/*
* We will not be implementing the UserDetailsManager as it contains lots of other methods related to CRUD
* which would be unnecessary to implement.
* So in order to only load the user from the custom table of DB, we will implement the UserDetailsService class
* as below
*  */
@Service
public class CustomUserDetailsService implements UserDetailsService {
    private final CustomerRepository customerRepository;

    public CustomUserDetailsService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    /**
     * @param username
     * @return
     * @throws UsernameNotFoundException
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Customer customer = customerRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with username : "+ username));
        List<GrantedAuthority> authorityList = List.of(new SimpleGrantedAuthority(customer.getRole()));
        return new User(customer.getEmail(), customer.getPwd(), authorityList);
    }
}
