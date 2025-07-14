package com.pj.pdf.dao;

import com.pj.pdf.vo.UnveilPdfVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UnveilPdfDAO {
    int idCheck(String userId) throws Exception;

    void saveJoinForm(UnveilPdfVO vo) throws Exception;

    UnveilPdfVO userChk(UnveilPdfVO vo);

    UnveilPdfVO findUserById(String userId);

    void updateUser(UnveilPdfVO vo) throws Exception;

}
