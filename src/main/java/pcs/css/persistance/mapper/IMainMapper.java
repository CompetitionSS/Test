package pcs.css.persistance.mapper;

import org.apache.ibatis.annotations.Mapper;
import pcs.css.dto.MainDTO;

import java.util.List;

@Mapper
public interface IMainMapper {

    List<MainDTO> getMainList();

    void InsertMainInfo(MainDTO pDTO);

    void updateMainReadCnt(MainDTO pDTO);

    MainDTO getMainInfo(MainDTO pDTO);

    void updateMainInfo(MainDTO pDTO);

    void deleteMainInfo(MainDTO pDTO);
}
