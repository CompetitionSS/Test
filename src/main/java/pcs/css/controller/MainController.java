package pcs.css.controller;

import lombok.extern.slf4j.Slf4j;
import org.eclipse.jdt.internal.compiler.batch.Main;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import pcs.css.dto.MainDTO;
import pcs.css.service.IMainService;
import pcs.css.util.CmmUtil;
import pcs.css.util.DateUtil;

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
        MainDTO pDTO = new MainDTO();
        String c_name =CmmUtil.nvl(request.getParameter("c_name"));
        pDTO.setC_name(c_name);
        String area;
        if(request.getParameter("area").equals("전체")){
            area =CmmUtil.nvl(request.getParameter("area2"));

        }else{
            area =CmmUtil.nvl(request.getParameter("area")+request.getParameter("area2"));
        }
        log.info(area);
        pDTO.setArea(area);
        String deadline;
        if(request.getParameter("deadline").equals("전체")){
            deadline=CmmUtil.nvl(request.getParameter("deadline2"), DateUtil.getDateTime("dd"));
        }else{
            deadline=CmmUtil.nvl(request.getParameter("deadline")+request.getParameter("deadline2"), DateUtil.getDateTime("MMdd"));
        }

        pDTO.setDeadline(deadline);
        String candidate =CmmUtil.nvl(request.getParameter("candidate"));
        pDTO.setCandidate(candidate);
        String organizer =CmmUtil.nvl(request.getParameter("organizer"));

        pDTO.setOrganizer(organizer);
        String s_year =CmmUtil.nvl(request.getParameter("s_year"), DateUtil.getDateTime("yyyyMMdd"));
        pDTO.setS_year(s_year);
        String b_year =CmmUtil.nvl(request.getParameter("b_year"), DateUtil.getDateTime("yyyyMMdd"));
        pDTO.setB_year(b_year);

        List<MainDTO> mList = mainService.SearchMainList(pDTO);
        if (mList == null) {
            mList = new ArrayList<>();

        }

        model.addAttribute("mList", mList);
        // 조회된 리스트 결과값 넣어주기

     /*   model.addAttribute("rList", pList);*/
        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".SearchMain end!");
        return "/main/searchMain";
    }


}
