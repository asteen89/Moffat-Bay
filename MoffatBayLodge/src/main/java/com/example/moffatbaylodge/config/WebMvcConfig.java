package com.example.moffatbaylodge.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Serve any request to /images/** from /WEB-INF/images/ (and its subfolders)
        registry.addResourceHandler("/images/**")
                .addResourceLocations("/WEB-INF/images/");
        // Optional: cache for a bit (uncomment if you want)
        // .setCachePeriod(3600);
    }
}
