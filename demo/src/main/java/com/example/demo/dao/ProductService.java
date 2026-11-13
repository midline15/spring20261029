package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.common.Message;
import com.example.demo.mapper.ProductMapper;
import com.example.demo.model.Product;

@Service 
public class ProductService {
    
    @Autowired 
    ProductMapper productMapper;

    public HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		try {
			List<Product> list = productMapper.selectProductList(map);
            List<Product> categoryList = productMapper.selectCategoryList(map);

			resultMap.put("list", list);
            resultMap.put("categoryList", categoryList);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}

    public HashMap<String, Object> getProduct(HashMap<String,Object> map) {
        HashMap<String, Object> resultMap = new HashMap();
		try {
			Product info = productMapper.selectProduct(map);

			resultMap.put("info", info);
			resultMap.put("fileList", productMapper.selectProductFile(map));
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
    }

    public HashMap<String, Object> stopProduct(HashMap<String,Object> map) {
        HashMap<String, Object> resultMap = new HashMap();
		try {
			productMapper.stopProduct(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
    }

	public HashMap<String, Object> addProduct(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		try {
			int cnt = productMapper.insertProduct(map);
			
			resultMap.put("productId", map.get("productId"));
			resultMap.put("message", Message.INSERT_SUCCESS);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", Message.INSERT_FAIL);
			System.out.println(e.getMessage());
		}
		return resultMap;
	}

    public HashMap<String, Object> addProductFile(HashMap<String,Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		try {
			int cnt = productMapper.insertProductFile(map);
			resultMap.put("message", Message.INSERT_SUCCESS);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", Message.INSERT_FAIL);
			System.out.println(e.getMessage());
		}
		return resultMap;
    }

	public HashMap<String, Object> getTotalOrderPriceList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		try {
			List<Product> list = productMapper.selectOrderPriceByProductName(map);

			resultMap.put("list", list);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		return resultMap;
	}

	public HashMap<String, Object> addOrder(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap();
		try {
			int cnt = productMapper.insertOrder(map);
			
			resultMap.put("message", Message.INSERT_SUCCESS);
			resultMap.put("result", "success");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", Message.INSERT_FAIL);
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
}
