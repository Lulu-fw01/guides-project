package com.server.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@ConfigurationProperties("jwt-properties")
@Data
@Configuration
public class JwtPropertiesConfig {
    private String token;
}
