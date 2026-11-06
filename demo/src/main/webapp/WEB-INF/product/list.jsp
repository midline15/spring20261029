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
            #app {
                width: 800px;
                margin: 30px auto;
            }

            table {
                width: 750px;
            }

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
                background-color: rgb(197, 197, 197);
            }

            #paging {
                text-align: center;
            }

            #paging a {
                margin-right: 6px;
                text-decoration: none;
            }

            #paging .active {
                font-weight: bold;
                color: black;
            }

            .table select {
                margin-bottom: 10px;
                width: 80px;
                text-align: center;
            }
            .search {
                text-align: center;
            }
            .search input {
                height: 25px;
            }
            .order{
                margin: 5px;
            }
        </style>
</head>
<body>
    <div id="app">
        <div>
            <div class="order">
                <select v-model="category" @change="fnList">
                    <option value="">::전체::</option>
                    <option v-for="item in categoryList" :value="item.category"> {{item.category}}</option>
                </select>
                |
                <label v-for="item in orderList"><input type="radio" v-model="order" :value="item.key" @change="fnList">{{item.name}}</label>
            </div>
            <table>
                <tr>
                    <th>제품번호</th>
                    <th>제품명</th>
                    <th>브랜드</th>
                    <th>카테고리</th>
                    <th>가격</th>
                    <th>등록일</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.productId}}</td>
                    <td><a href="javascript:;" @click="fnView(item.productId)">{{item.productName}}</a></td>
                    <td>{{item.brand}}</td>
                    <td>{{item.category}}</td>
                    <td>₩{{item.convertPrice}}</td>
                    <td>{{item.releaseDate}}</td>
                </tr>
            </table>
            
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                list: "",
                order: 0,
                categoryList: '',
                category:'',
                orderList: [
                    {key: 1, name: '낮은가격순'},
                    {key: 2, name: '높은가격순'},
                    {key: 3, name: '등록순'}
                ]

            };
        },
        methods: {
            fnList : function () {
                let self = this;
                let param = {
                    order: self.order,
                    category: self.category
                };
                $.ajax({
                    url: "http://localhost:8080/product/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.categoryList = data.categoryList;
                    }
                });
            },
            fnView(productId){
                pageChange("view.do",{productId: productId});
            }
        }, // methods
        mounted() {
            let self = this;
            self.fnList();
        }
    });

    app.mount('#app');
</script>