package pcs.css.persistance.mapper;

import org.apache.ibatis.annotations.Mapper;
import pcs.css.dto.CommentsDTO;

@Mapper
public interface ICommentsMapper {

    CommentsDTO getCommentsInfo(CommentsDTO pDTO) throws Exception;


}
