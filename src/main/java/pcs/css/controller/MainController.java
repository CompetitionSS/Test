package pcs.css.controller;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.eclipse.jdt.internal.compiler.batch.Main;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import pcs.css.dto.MainDTO;
import pcs.css.dto.PageDTO;
import pcs.css.service.IMainService;
import pcs.css.util.CmmUtil;
import pcs.css.util.DateUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
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
    @GetMapping(value = "main/mainList")
    public String MainList(HttpServletRequest request, ModelMap model) throws Exception {
        log.info(this.getClass().getName() + ".MainList start!");
        MainDTO mDTO = new MainDTO();
        PageDTO pageDTO;
       int count = mainService.count(mDTO);
        log.info(String.valueOf(count));
       String no = CmmUtil.nvl(request.getParameter("num"));

       if(no.isEmpty()){
           pageDTO = new PageDTO(1,count);
       }else {
           pageDTO = new PageDTO(Integer.parseInt(no),count);
       }




        List<MainDTO> mList = mainService.getMainList2(pageDTO);





        // 현재 페이지
        model.addAttribute("select", pageDTO.getNum());
        model.addAttribute("startPageNum", pageDTO.getStartPageNum());
        model.addAttribute("endPageNum", pageDTO.getEndPageNum());

        // 이전 및 다음
        model.addAttribute("prev", pageDTO.isPrev());
        model.addAttribute("next", pageDTO.isNext());
        if(mList == null) {
            mList = new ArrayList<>();
        }
        model.addAttribute("mList", mList);
        log.info(this.getClass().getName() + ".MainList end!");
        return "/main/mainList";
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

        pDTO.setArea(area);
        String deadline;
        if(request.getParameter("deadline").equals("전체")){
            deadline=CmmUtil.nvl( 10+request.getParameter("deadline2"), DateUtil.getDateTime("MMdd"));
        }else{
            deadline=CmmUtil.nvl(request.getParameter("deadline")+request.getParameter("deadline2"), DateUtil.getDateTime("MMdd"));
        }

        pDTO.setDeadline(deadline);
        String candidate =CmmUtil.nvl(request.getParameter("candidate"));
        pDTO.setCandidate(candidate);
       // String organizer =CmmUtil.nvl(request.getParameter("organizer"));


        List<String> organizer = new ArrayList<>(Arrays.asList(request.getParameterValues("organizer2")));

        String s_year ="";
        pDTO.setS_organizer(organizer);
        String s_year2 = "";
        s_year2= CmmUtil.nvl(request.getParameter("s_year2"));
        if(!s_year2.isEmpty()){
            s_year =CmmUtil.nvl(request.getParameter("s_year"), DateUtil.getDateTime("yyyyMMdd"));
        }else{
            s_year = "전체";
        }



        pDTO.setS_year(s_year);
        String b_year =CmmUtil.nvl(request.getParameter("b_year"));
        pDTO.setB_year(b_year);



        PageDTO pageDTO;
        int count = mainService.Searchcount(pDTO);
        log.info(String.valueOf(count));
        String no = CmmUtil.nvl(request.getParameter("num"));
        log.info(no);

        if(no.isEmpty()){

            pageDTO = new PageDTO(1,count);
        }else {
            pageDTO = new PageDTO(Integer.parseInt(no),count);

        }


        pDTO.setStart(pageDTO.getStart());

        pDTO.setFinish(pageDTO.getFinish());

        List<MainDTO> mList = mainService.SearchMainList(pDTO);
        if (mList == null) {
            mList = new ArrayList<>();

        }

        model.addAttribute("select", pageDTO.getNum());
        model.addAttribute("startPageNum", pageDTO.getStartPageNum());
        model.addAttribute("endPageNum", pageDTO.getEndPageNum());

        // 이전 및 다음
        model.addAttribute("prev", pageDTO.isPrev());
        model.addAttribute("next", pageDTO.isNext());
        model.addAttribute("mList", mList);
        // 조회된 리스트 결과값 넣어주기

     /*   model.addAttribute("rList", pList);*/
        // 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".SearchMain end!");
        return "/main/searchMain";
    }

    @GetMapping(value = "main/mainCrawling")
    public String mainCrawling(HttpServletRequest request,ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".mainCrawling Start!");

        mainService.mainCrawling();
        List<MainDTO> mList = mainService.getMainList();
        if (mList == null) {
            mList = new ArrayList<>();

        }

        model.addAttribute("mList", mList);
        // 조회된 리스트 결과값 넣어주기


        log.info(this.getClass().getName() + ".mainCrawling End!");

        return "/main/mainCrawling";
    }
}
