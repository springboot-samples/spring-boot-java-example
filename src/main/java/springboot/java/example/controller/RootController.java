package springboot.java.example.controller;

import com.google.common.collect.ImmutableMap;
import java.util.Map;
import org.joda.time.LocalDateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

@RestController
public class RootController {

    @Autowired
    public RootController() {
    }

    @RequestMapping(path = {"/"}, method = {GET}, produces = {"application/json"})
    public Map example() {
        return ImmutableMap.builder()
                .put("message", "Java rocks!")
                .put("today", LocalDateTime.now().toString())
                .build();
    }
}