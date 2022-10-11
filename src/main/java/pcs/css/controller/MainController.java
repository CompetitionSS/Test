package pcs.css.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import pcs.css.service.IMailService;
import pcs.css.service.IMainService;

import javax.annotation.Resource;

@Slf4j
@Controller
public class MainController {

    @Resource(name = "MainService")
    private IMainService mainService;

    @GetMapping(value = "main/main")
    public String mailForm() throws Exception {
        return "/main/main";
    }

}
