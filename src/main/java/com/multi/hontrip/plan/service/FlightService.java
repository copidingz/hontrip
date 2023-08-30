package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.FlightDTO;
import com.multi.hontrip.plan.dto.FlightSearchDTO;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.text.ParseException;
import java.util.List;

public interface FlightService {

    // 항공편 추가
    void insertFlight(FlightDTO flightDTO);

    // 검색 항공편 수 카운트
    int countFlight(FlightSearchDTO flightSearchDTO) throws ParseException;

    // 항공편 api 조회 및 데이터 파싱
    void parseData(FlightSearchDTO flightSearchDTO) throws IOException, ParserConfigurationException, SAXException, ParseException;

    // 항공편 목록 조회
    List<FlightDTO> listFlight(FlightSearchDTO flightSearchDTO) throws ParseException;

    // 항공편 목록 조회 (무한 스크롤)
    List<FlightDTO> listFlightWithScroll(FlightSearchDTO flightSearchDTO) throws ParseException;

    // 무한 스크롤 시 목록 조회
    List<FlightDTO> loadList(FlightSearchDTO flightSearchDTO) throws ParseException;
}
