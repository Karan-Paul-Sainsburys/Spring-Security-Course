package com.karanpaul.springsecurity.filter;

import com.karanpaul.springsecurity.constants.ApplicationsConstant;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.core.env.Environment;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.crypto.SecretKey;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public class JWTTokenValidatorFilter extends OncePerRequestFilter {
    /**
     * @param request
     * @param response
     * @param filterChain
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String jwtToken = request.getHeader(ApplicationsConstant.JWT_HEADER);
        Environment environment = getEnvironment();
        if(null!=environment){
            String secret = environment.getProperty(ApplicationsConstant.JWT_SECRET_KEY,ApplicationsConstant.JWT_SECRET_DEFAULT_VALUE);
            SecretKey secretKey = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
            Claims claims = Jwts.parser().verifyWith(secretKey)
                    .build()
                    .parseSignedClaims(jwtToken).getPayload();

            String username = String.valueOf(claims.get("username"));
            String authorities = String.valueOf(claims.get("authorities"));

            //creating the authentication object via UsernamePasswordAuthenticationToken which sets the authentication
            //as true.so the basic authentication filter will be skipped now
            Authentication authentication = new UsernamePasswordAuthenticationToken(username,null,
                    Arrays.stream(authorities.split(",")).map(SimpleGrantedAuthority::new).toList());
            //saving in the security context
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
        filterChain.doFilter(request,response);
    }
    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
        return request.getServletPath().equals("/user");
    }
}
