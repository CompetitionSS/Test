package pcs.css.persistance.mapper;

import org.apache.ibatis.annotations.Mapper;
import pcs.css.dto.MainDTO;

import java.util.List;

@Mapper
public interface IMainMapper {

    List<MainDTO> getMainList() throws Exception;

    void InsertMainInfo(MainDTO pDTO) throws Exception;

    void updateMainReadCnt(MainDTO pDTO) throws Exception;

    MainDTO getMainInfo(MainDTO pDTO) throws Exception;

    void updateMainInfo(MainDTO pDTO) throws Exception;

    void deleteMainInfo(MainDTO pDTO) throws Exception;

    List<MainDTO> SearchMainList(MainDTO mDTO) throws Exception;
}
