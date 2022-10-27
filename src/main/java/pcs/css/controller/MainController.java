package pcs.css.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import pcs.css.dto.MainDTO;
import pcs.css.service.IMainService;
import pcs.css.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
public class MainController {

    @Resource(name = "MainService")
    private IMainService mainService;

    @GetMapping(value = "main/main")
    public String MainInfo() throws Exception {
        log.info(this.getClass().getName() + ".Main start!");
        return "/main/main";
    }

    @GetMapping(value = "main/searchMain")
    public String SearchMain(HttpServletRequest request, ModelMap model) throws Exception {
        log.info(this.getClass().getName() + ".SearchMain start!");
        MainDTO pDTO = null;

        try{
            String c_name = CmmUtil.nvl(request.getParameter("c_name"));
            String area = CmmUtil.nvl(request.getParameter("area"));
            String deadline = CmmUtil.nvl(request.getParameter("deadline"));
            String candidate = CmmUtil.nvl(request.getParameter("candidate"));
            String organizer = CmmUtil.nvl(request.getParameter("organizer"));
            String year = CmmUtil.nvl(request.getParameter("year"));
            String b_year = CmmUtil.nvl(request.getParameter("b_year"));
            String r_date = CmmUtil.nvl(request.getParameter("r_date"));
            pDTO= new MainDTO();
            pDTO.setC_name(c_name);
            pDTO.setArea(area);
            pDTO.setDeadline(deadline);
            pDTO.setCandidate(candidate);
            pDTO.setOrganizer(organizer);
            pDTO.setYear(year);
            pDTO.setB_year(b_year);
            pDTO.setR_date(r_date);

        } catch (Exception e){
            e.printStackTrace();
        }finally {

            model.addAttribute("pDTO", pDTO);
            pDTO = null;
        }



        // 조회된 리스트 결과값 넣어주기

     /*   model.addAttribute("rList", pList);*/
        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".SearchMain end!");
        return "/main/searchMain";
    }


}
