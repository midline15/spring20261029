<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>
        <style>
            table,
            tr,
            td,
            th {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
                text-align: center;
            }

            th {
                background-color: beige;
            }

            tr:nth-child(even) {
                background-color: azure;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <h3>제목 : {{info.title}}</h3>
            <h3>작성자 : {{info.userId}} | 조회수 : {{info.cnt}}</h3>
            <hr>
            <h4>내용</h4>
            <img v-for="item in fileList" :src="item.filePath">
            <div v-html="info.contents"></div>
            <hr>
            <div>
                <button @click="fnEdit()">수정</button>
            </div>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    boardNo: "${boardNo}",
                    info: "",
                    fileList: ""
                };
            },
            methods: {
                fnInfo: function () {
                    let self = this;
                    let param = {
                        boardNo: self.boardNo
                    };
                    $.ajax({
                        url: "http://localhost:8080/board/view.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            self.info = data.info;
                            self.fileList = data.fileList;
                        }
                    });
                },
                fnEdit: function(){
                    let self = this;
                    pageChange("edit.do",{boardNo : self.boardNo})
                }
            }, // methods
            mounted() {
                let self = this;
                self.fnInfo();
            }
        });

        app.mount('#app');
    </script>