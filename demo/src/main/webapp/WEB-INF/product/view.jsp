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
        {{info}}
        
        <div>
            <button @click="fnStop">제품 삭제</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                productId: "${productId}",
                info: ""
            };
        },
        methods: {
            fnInfo : function () {
                let self = this;
                let param = {
                    productId: self.productId
                };
                $.ajax({
                    url: "http://localhost:8080/product/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.info = data.info;
                    }
                });
            },
            fnStop(){
                let self = this;
                let param = {
                    productId: self.productId
                }
                $.ajax({
                    url: "http://localhost:8080/product/stop.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("판매중지");
                        location.href="list.do";
                    }
                });
            }
        }, // methods
        mounted() {
            let self = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>