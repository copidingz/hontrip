package com.multi.hontrip.plan.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class FlightSearchDTO {

    private String depAirportName; // 출발 공항명
    private String arrAirportName; // 도착 공항명

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date depDate; // 출발일
    //private String seatClass; // 좌석등급

    // 무한 스크롤 위한 필드
    private int startRowNum; // 시작 번호
    private int endRowNum;  // 끝 번호
    private int rowCount; // 가져갈 개수

}
