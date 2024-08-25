package com.karanpaul.springsecurity.config;

import com.karanpaul.springsecurity.exceptionHandling.CustomAuthenticationEntryPoint;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.authentication.password.CompromisedPasswordChecker;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.password.HaveIBeenPwnedRestApiPasswordChecker;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@Profile("!prod") // other than prod for all profile this will be used
public class SecurityConfig {
    @Bean
    SecurityFilterChain defaultSecurityFilterChain(HttpSecurity http) throws Exception {
//        http.requiresChannel(rcf->rcf.anyRequest().requiresSecure()) //will allow only https hit
        http.csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests((requests) -> requests
                .requestMatchers("/myAccount","/myCard","/myBalance","/myLoans").authenticated()
                .requestMatchers("/notices","/contacts","/welcome").permitAll());
        http.formLogin(withDefaults());
        http.httpBasic(hfc -> hfc.authenticationEntryPoint(new CustomAuthenticationEntryPoint())); //for
        // invoking the custom authentication entry point for basic auth.

        //for global exception handling, we can use this as well and this will handle all global exception which we write within the class.
        //http.exceptionHandling(ehc->ehc.authenticationEntryPoint(new CustomAuthenticationEntryPoint()));
        return http.build();
    }

//    //using the JDBCUserDetailsManager to authenticate the users from DB
//    @Bean
//    public UserDetailsService userDetailsService(DataSource dataSource){
//        return new JdbcUserDetailsManager(dataSource);
//    }

    @Bean
    PasswordEncoder passwordEncoder(){
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

    @Bean
    CompromisedPasswordChecker compromisedPasswordChecker(){
        return new HaveIBeenPwnedRestApiPasswordChecker();
    }
}
