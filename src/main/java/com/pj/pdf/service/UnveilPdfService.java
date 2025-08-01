package com.pj.pdf.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pj.pdf.dao.UnveilPdfDAO;
import com.pj.pdf.vo.UnveilPdfVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class UnveilPdfService {
    private final ObjectMapper objectMapper = new ObjectMapper(); // ObjectMapper 인스턴스 생성

    @Autowired(required = false)
    private UnveilPdfDAO unveilPdfDAO;


    public void saveJoinForm(UnveilPdfVO vo) throws Exception{
        unveilPdfDAO.saveJoinForm(vo);
    }

    public int idCheck(String userId) throws Exception{
        return unveilPdfDAO.idCheck(userId);
    }

    public UnveilPdfVO userChk(UnveilPdfVO vo){
        return unveilPdfDAO.userChk(vo);
    }

    public UnveilPdfVO findUserById(String userId){
        return unveilPdfDAO.findUserById(userId);
    }

    public void updateUser(UnveilPdfVO vo) throws Exception{
        unveilPdfDAO.updateUser(vo);
    }
    public List<UnveilPdfVO> getUserList(){
        return unveilPdfDAO.getUserList();
    }
    public void savePjForm(UnveilPdfVO vo) throws Exception{
        unveilPdfDAO.savePjForm(vo);
    }
    public List<UnveilPdfVO> getProjectList(UnveilPdfVO vo){
        return unveilPdfDAO.getProjectList(vo);
    }

    public List<UnveilPdfVO> getProjectById(int projectId){
        return unveilPdfDAO.getProjectById(projectId);
    }

    public void insertPdfFile(UnveilPdfVO vo) throws Exception{
        unveilPdfDAO.insertPdfFile(vo);
    }

    public int getPdfId() throws Exception{
        return unveilPdfDAO.getPdfId();
    }

    public void insertOcrResult(UnveilPdfVO vo) throws Exception{
        unveilPdfDAO.insertOcrResult(vo);
    }

    public List<UnveilPdfVO> getPdfResultData(int pdfId){
        return unveilPdfDAO.getPdfResultData(pdfId);
    }
}
