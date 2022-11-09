package pcs.css.service;

import org.springframework.transaction.annotation.Transactional;
import pcs.css.dto.MainDTO;

import java.util.List;

public interface IMainService {


    List<MainDTO> getMainList() throws Exception;




    void InsertMainInfo(MainDTO pDTO) throws Exception;


    MainDTO getMainInfo(MainDTO pDTO) throws Exception;

    void updateMainInfo(MainDTO pDTO) throws Exception;

    void deleteMainInfo(MainDTO pDTO) throws Exception;

    List<MainDTO> SearchMainList(MainDTO mDTO) throws Exception;

    void mainCrawling() throws Exception;

}
