package pcs.css.service;

import org.eclipse.jdt.internal.compiler.batch.Main;
import org.springframework.transaction.annotation.Transactional;
import pcs.css.dto.MainDTO;
import pcs.css.dto.PageDTO;

import java.util.List;

public interface IMainService {


    List<MainDTO> getMainList() throws Exception;
    List<MainDTO> getMainList2(MainDTO pDTO) throws Exception;

    int count(MainDTO pDTO) throws Exception;

    void InsertMainInfo(MainDTO pDTO) throws Exception;


    MainDTO getMainInfo(MainDTO pDTO) throws Exception;

    void updateMainInfo(MainDTO pDTO) throws Exception;

    void deleteMainInfo(MainDTO pDTO) throws Exception;

    List<MainDTO> SearchMainList(MainDTO mDTO) throws Exception;

    void mainCrawling() throws Exception;

}
