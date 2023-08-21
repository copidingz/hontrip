package com.multi.hontrip.record.dao;

import com.multi.hontrip.record.dto.CreatePostDTO;
import com.multi.hontrip.record.dto.LocationDTO;
import com.multi.hontrip.record.dto.PostInfoDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class RecordDAO {

    private final SqlSessionTemplate sqlSessionTemplate;

    public void insertPost(CreatePostDTO createPostDTO) {
        sqlSessionTemplate.insert("record.createPost", createPostDTO);
    }

    public PostInfoDTO selectPost(long id) {
        return sqlSessionTemplate.selectOne("record.selectPostInfo", id);
    }

    public void updatePost(CreatePostDTO createPostDTO) {
        sqlSessionTemplate.update("record.updatePostInfo", createPostDTO);
    }

    public void deletePost(long id) {
        sqlSessionTemplate.delete("record.deletePost", id);
    }

    public List<CreatePostDTO> getMyList(){ //내 게시물 전체 리스트 가져오기
        return sqlSessionTemplate.selectList("record.mylist");
    }

    public List<CreatePostDTO> getListMyLocation(int locationId) { // 내 게시물 마커클릭한 지역 리스트 가져오기
        return  sqlSessionTemplate.selectList("record.listmylocation", locationId);
    }

    public List<CreatePostDTO> getFeedList(){ //공유피드 전체 리스트 가져오기
        return sqlSessionTemplate.selectList("record.feedlist");
    }

    public List<LocationDTO> getMyMap(){ //공유피드 전체 리스트 가져오기
        return sqlSessionTemplate.selectList("record.mymap");
    }
}
