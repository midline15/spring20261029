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
            <select v-model="dong" @change="fnGetWeather">
                <option value="">:: 선택 ::</option>
                <option v-for="item in dongList" :value="item">
                    {{item.dong}}
                </option>
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
                dong: "",
                nx: "",
                ny: "",
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
                let param = {
                    serviceKey : decodeURIComponent("6b846af1debe4a608940aae218c9ab506aba135f6481e2df85bc8cad03d81af7"),
                    pageNo : 1,
                    numOfRows : 1000,
                    dataType : "JSON",
                    base_date : "20261113",
                    base_time : "0900",
                    nx : self.dong.nx,
                    ny : self.dong.ny
                };
                $.ajax({
                    url: "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst",
                    dataType: "json",
                    type: "GET",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        let items = data.response.body.items.item;
                        for(let i = 0; i < items.length; i++){
                            let item = items[i];
                            if(item.category == "T1H"){
                                // 기온에 대한 처리, 단위 : ℃
                                console.log("기온 ===> ", item.obsrValue)
                            }
                            if(item.category == "RN1"){
                                // 강수에 대한 처리, 단위 : ℃
                                console.log("강수량 ===> ", item.obsrValue)
                            }
                            if(item.category == "PTY"){
                                console.log("강수형태 ===> ", item.obsrValue)
                            }
                        }
                    }
                });
            }
        }, // methods
        mounted() {
            let self = this;
            self.fnSiList();
        }
    });

    app.mount('#app');
</script>