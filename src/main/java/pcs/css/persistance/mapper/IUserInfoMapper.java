package pcs.css.persistance.mapper;


import org.apache.ibatis.annotations.Mapper;
import pcs.css.dto.UserInfoDTO;

import java.util.List;

@Mapper
public interface IUserInfoMapper {

    // 회원 가입하기(회원정보 등록하기)
    int insertUserInfo(UserInfoDTO pDTO) throws Exception;

    // 회원 가입 전 중복체크하기(DB조회하기)
    UserInfoDTO getUserExists(UserInfoDTO pDTO) throws Exception;

    // 로그인을 위해 아이디와 비밀번호가 일치하는지 확인하기
    UserInfoDTO getUserLoginCheck(UserInfoDTO pDTO) throws Exception;

    UserInfoDTO find_id(UserInfoDTO pDTO) throws Exception;

    void find_ps(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO find_pscheck(UserInfoDTO pDTO) throws Exception;

    List<UserInfoDTO> getUserList();

    void DeleteID(UserInfoDTO uDTO);
}

