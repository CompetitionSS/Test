package pcs.css.service;


import org.apache.ibatis.annotations.Mapper;
import pcs.css.dto.UserInfoDTO;

import javax.servlet.http.HttpServletResponse;


public interface IUserInfoService {

    // 회원 가입하기(회원정보 등록하기)
    int insertUserInfo(UserInfoDTO pDTO) throws Exception;

    // 로그인을 위해 아이디와 비밀번호가 일치하는지 확인하기
    int getUserLoginCheck(UserInfoDTO pDTO) throws Exception;

    String find_id(HttpServletResponse response, String email) throws Exception;

    UserInfoDTO getUserIDSearch(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO getUserIDPS(UserInfoDTO pDTO) throws Exception;
}
