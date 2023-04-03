package com.server;

import com.server.config.JwtPropertiesConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties(JwtPropertiesConfig.class)
public class GuideServerAppApplication {

	public static void main(String[] args) {
		SpringApplication.run(GuideServerAppApplication.class, args);
	}

}
