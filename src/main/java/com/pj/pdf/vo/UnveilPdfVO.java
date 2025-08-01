package com.pj.pdf.vo;

import lombok.*;

import java.util.List;

@NoArgsConstructor @AllArgsConstructor
@Builder(toBuilder = true)
@Getter
@Setter
@ToString
public class UnveilPdfVO {
    // 사용자 DB
    private int userSeq;
    private String userId;
    private String userPwd;
    private String userName;
    private String userAut;
    private String createDt;
    private String mdfDt;

    // 프로젝트 db
    private int projectId;
    private String projectName;
    private String isPublic;
    private String userVisibility;

    // pdf file db
    private int pdfId;
    private String fileName;
    private String filePath;
    private String fileType;
    private String status;
    private String uploadDt;
    private String imagePath;
    // ocr_result
    private int ocrId;
    private int pageNo;
    private String ocrText;

    // parsing_result
    private int parsingId;
    private String fieldName;
    private String fieldValue;
    private String field;

}
