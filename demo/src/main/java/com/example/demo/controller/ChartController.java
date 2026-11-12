package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.dao.ProductService;

@Controller 
public class ChartController {

    @Autowired 
    ProductService productService;
    
    @RequestMapping("/chart1.do")
	public String chart1(Model model) throws Exception{
		
		return "/chart/chart1";
	}

    @RequestMapping("/chart2.do")
	public String char2(Model model) throws Exception{
		
		return "/chart/chart2";
	}

    @RequestMapping("/chart3.do")
	public String char3(Model model) throws Exception{
		
		return "/chart/chart3";
	}

}
