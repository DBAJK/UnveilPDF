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

    void savePjForm(UnveilPdfVO vo) throws Exception;

    List<UnveilPdfVO> getUserList();

    List<UnveilPdfVO> getProjectList(UnveilPdfVO vo);
    List<UnveilPdfVO> getProjectById(int projectId);

    void insertPdfFile(UnveilPdfVO vo) throws Exception;
    void insertOcrResult(UnveilPdfVO vo) throws Exception;
    int getPdfId() throws Exception;

    List<UnveilPdfVO> getPdfResultData(int pdfId) ;
}
