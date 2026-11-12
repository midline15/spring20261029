<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
        }
    </style>
</head>
<body>
    <div id="app">
        <div>
            <select v-model="si" @change="fnGuList">
                <option value="">:: 선택 ::</option>
                <option v-for="item in siList" :value="item.si">{{item.si}}</option>
            </select>
            <select v-model="gu" @change="fnDongList">
                <option value="">:: 선택 ::</option>
                <option v-for="item in guList" :value="item.gu">{{item.gu}}</option>
            </select>
            <select v-model="dong">
                <option value="">:: 선택 ::</option>
                <option v-for="item in dongList" :value="item.dong">{{item.dong}}</option>
            </select>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                siList: "",
                guList: "",
                dongList: "",
                si: "",
                gu: "",
                dong: ""
            };
        },
        methods: {
            fnSiList : function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "http://localhost:8080/area/si.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.siList = data.siList;
                        
                    }
                });
            },
            fnGuList : function () {
                let self = this;
                self.gu = "";
                self.dong = "";
                self.guList = "";
                self.dongList = "";
                let param = {
                    si: self.si
                };
                $.ajax({
                    url: "http://localhost:8080/area/gu.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.guList = data.guList;
                    }
                });
            },
            fnDongList : function () {
                let self = this;
                self.dong = "";
                self.dongList = "";
                let param = {
                    si: self.si,
                    gu: self.gu
                };
                $.ajax({
                    url: "http://localhost:8080/area/dong.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.dongList = data.dongList;
                    }
                });
            },
            fnGetWeather : function () {
                let self = this;
                self.dong = "";
                self.dongList = "";
                let param = {
                    serviceKey : decodeURI("일반 인증키"),
                    pageNo : 1,
                    numOfRows : 1000,
                    dataType : "JSON",
                    base_date : "20261112",
                    base_time : "1600",
                    nx : 55,
                    ny : 125
                };
                $.ajax({
                    url: "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst",
                    dataType: "json",
                    type: "GET",
                    data: param,
                    success: function (data) {
                        console.log(data)
                    }
                });
            }
        }, // methods
        mounted() {
            let self = this;
            self.fnSiList();
            self.fnGetWeather();
        }
    });

    app.mount('#app');
</script>