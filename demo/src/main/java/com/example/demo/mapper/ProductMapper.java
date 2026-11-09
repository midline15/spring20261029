package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.File;
import com.example.demo.model.Product;

@Mapper 
public interface ProductMapper {
    // 제품 목록
    List<Product> selectProductList(HashMap<String, Object> map);
    
    // 카테고리 목록
    List<Product> selectCategoryList(HashMap<String, Object> map);

    // 제품 상세
    Product selectProduct(HashMap<String,Object> map);

    void stopProduct(HashMap<String,Object> map);

    int insertProduct(HashMap<String, Object> map);

    int insertProductFile(HashMap<String,Object> map);

    List<File> selectProductFile(HashMap<String,Object> map);

    
}
