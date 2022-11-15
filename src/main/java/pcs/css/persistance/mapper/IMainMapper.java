package pcs.css.persistance.mapper;

import org.apache.ibatis.annotations.Mapper;
import pcs.css.dto.MainDTO;
import pcs.css.dto.PageDTO;

import java.util.List;

@Mapper
public interface IMainMapper {

    List<MainDTO> getMainList() throws Exception;

    List<MainDTO> getMainList2(PageDTO pDTO) throws Exception;

    void InsertMainInfo(MainDTO pDTO) throws Exception;

    void updateMainReadCnt(MainDTO pDTO) throws Exception;

    MainDTO getMainInfo(MainDTO pDTO) throws Exception;

    void updateMainInfo(MainDTO pDTO) throws Exception;

    void deleteMainInfo(MainDTO pDTO) throws Exception;

    List<MainDTO> SearchMainList(MainDTO mDTO) throws Exception;

    MainDTO getMainExists(MainDTO pDTO) throws Exception;

    int count(MainDTO pDTO) throws Exception;
    int Searchcount(MainDTO pDTO) throws Exception;
}
