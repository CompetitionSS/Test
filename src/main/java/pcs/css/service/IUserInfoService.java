package pcs.css.service;


import org.apache.ibatis.annotations.Mapper;
import pcs.css.dto.NoticeDTO;
import pcs.css.dto.UserInfoDTO;

import javax.servlet.http.HttpServletResponse;
import java.util.List;


public interface IUserInfoService {

    // 회원 가입하기(회원정보 등록하기)
    int insertUserInfo(UserInfoDTO pDTO) throws Exception;

    // 로그인을 위해 아이디와 비밀번호가 일치하는지 확인하기
    int getUserLoginCheck(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO find_id(UserInfoDTO pDTO) throws Exception;

    int find_ps(UserInfoDTO pDTO) throws Exception;

    List<UserInfoDTO> getUserList() throws Exception;

    void DeleteID(UserInfoDTO uDTO);
}
