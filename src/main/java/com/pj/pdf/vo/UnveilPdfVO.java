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
}
