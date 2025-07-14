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
    private UnveilPdfDAO kboPjDAO;


    public void saveJoinForm(UnveilPdfVO vo) throws Exception{
        kboPjDAO.saveJoinForm(vo);
    }

    public int idCheck(String userId) throws Exception{
        return kboPjDAO.idCheck(userId);
    }

    public UnveilPdfVO userChk(UnveilPdfVO vo){
        return kboPjDAO.userChk(vo);
    }

    public UnveilPdfVO findUserById(String userId){
        return kboPjDAO.findUserById(userId);
    }

    public void updateUser(UnveilPdfVO vo) throws Exception{
        kboPjDAO.updateUser(vo);
    }

}
