package com.thehecklers.java_in_the_can;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CanController {
    @GetMapping
    public String getContainerAppUp() {
        return "Container of Java coming up!";
    }

    @GetMapping("/java")
    public String getJavaMessage() {
        return "Brewing fresh Java inside this container. ☕️";
    }
}
