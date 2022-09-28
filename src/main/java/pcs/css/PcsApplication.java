package pcs.css;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class PcsApplication {

    public static void main(String[] args) {
        SpringApplication.run(PcsApplication.class, args);
    }

}
