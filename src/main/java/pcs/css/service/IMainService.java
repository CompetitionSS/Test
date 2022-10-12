package pcs.css.service;

import org.springframework.transaction.annotation.Transactional;
import pcs.css.dto.MainDTO;

import java.util.List;

public interface IMainService {

    @Transactional
    List<MainDTO> getMainList() throws Exception;

    @Transactional
    void InsertMainInfo(MainDTO pDTO) throws Exception;

    @Transactional
    MainDTO getMainInfo(MainDTO pDTO) throws Exception;

    @Transactional
    void updateMainInfo(MainDTO pDTO) throws Exception;

    @Transactional
    void deleteMainInfo(MainDTO pDTO) throws Exception;
}
