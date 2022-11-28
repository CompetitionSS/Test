package pcs.css.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import pcs.css.dto.CommentDTO;
import pcs.css.dto.NoticeDTO;
import pcs.css.service.INoticeService;
import pcs.css.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Slf4j
@Controller
public class TestController {
    @Resource(name = "NoticeService")
    private INoticeService noticeService;



}
