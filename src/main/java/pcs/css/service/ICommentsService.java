package pcs.css.service;

import pcs.css.dto.CommentsDTO;

import java.util.List;

public interface ICommentsService {

    List<CommentsDTO> getCommentsList() throws Exception;

    void InsertCommentsInfo(CommentsDTO pDTO) throws Exception;
}
