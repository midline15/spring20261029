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
        <!-- Quill CDN -->
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
        <script src="/js/page-change.js"></script>
        <style>
            #app {
                width: 800px;
                margin: 30px auto;
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
                width: 20%;
                background-color: beige;
            }

            td {
                text-align: left;
            }

            td select {
                width: 100px;
                height: 30px;
            }

            td input {
                width: 90%;
                height: 30px;
            }

            .contents {
                width: 750px;
            }

            table {
                width: 100%;
            }

            .editor-area {
                height: 400px;
                padding: 10px 10px 50px 10px;
            }

            .btn-area {
                text-align: center;
                margin-top: 15px;
            }

            .btn-area button {
                height: 30px;
                width: 100px;
                margin: 5px;
                background-color: rgb(89, 239, 241);
                border: 1px solid rgb(2, 174, 177);
                box-shadow: 0px 0px 2px black;
                cursor: pointer;
                border-radius: 5px;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <div class="contents">
                <table>
                    <tr>
                        <th>카테고리</th>
                        <td>
                            <select v-model="category">
                                <option value="">::전체::</option>
                                <option v-for="item in categoryList" :value="item.category"> {{item.category}}</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>제품명</th>
                        <td>
                            <input class="title" v-model="productName">
                        </td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td>
                            <input type="file" id="file1" name="file1" accept=".jpg, .png">
                        </td>
                    </tr>
                    <tr>
                        <th>제품설명</th>
                        <td class="editor-area">
                            <div id="editor"></div>
                        </td>
                    </tr>
                </table>
                <div class="btn-area">
                    <button @click="fnAdd">등록</button>
                    <button>되돌아가기</button>
                </div>
            </div>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    category: "",
                    productName: "",
                    description: "",
                    categoryList: ""
                };
            },
            methods: {
                fnAdd: function () {
                    let self = this;

                    let param = {
                        category: self.category,
                        productName: self.productName,
                        description: self.description
                    };
                    $.ajax({
                        url: "http://localhost:8080/product/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if ($("#file1")[0].files[0] != null || $("#file1")[0].files[0] != undefined) {
                                self.fnFileAdd(data.productId);
                            } else {
                                alert(data.message);
                                location.href = "list.do";
                            }
                        }
                    });
                },
                fnFileAdd: function (productId) {
                    var self = this;
                    console.log($("#file1")[0].files[0]);
                    var form = new FormData();
                    form.append("file1", $("#file1")[0].files[0]);
                    form.append("idx", productId);
                    self.upload(form);
                },
                // 파일 업로드
                upload: function (form) {
                    var self = this;
                    console.log(form);
                    $.ajax({
                        url: "/product/fileUpload.dox",
                        type: "POST",
                        processData: false,
                        contentType: false,
                        data: form,
                        success: function (data) {
                            alert(data.message);
                            location.href = "list.do";
                        }
                    });
                },
                fnList() {
                    let self = this;
                    $.ajax({
                        url: "http://localhost:8080/product/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: "",
                        success: function (data) {
                            console.log(data.categoryList);
                            self.categoryList = data.categoryList;
                        }
                    });
                }
            }, // methods
            mounted() {
                let self = this;
                self.fnList();

                // Quill 에디터 초기화
                var quill = new Quill('#editor', {
                    theme: 'snow',
                    modules: {
                        toolbar: [
                            [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                            ['bold', 'italic', 'underline'],
                            [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                            ['link', 'image'],
                            [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
                            ['clean']
                        ]
                    }
                });

                // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
                quill.on('text-change', function () {
                    self.description = quill.root.innerHTML;
                });
            }
        });

        app.mount('#app');
    </script>