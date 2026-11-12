package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller 
public class MapController {
    
    @RequestMapping(path="/map1.do")
    public String map1() {

        return "map/map1";
    }

    @RequestMapping(path="/map2.do")
    public String map2() {

        return "map/map2";
    }

    @RequestMapping("/map3.do")
    public String map3() {

        return "map/map3";
    }
    
}
