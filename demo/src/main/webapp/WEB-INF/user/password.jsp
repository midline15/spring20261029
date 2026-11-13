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
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
            <div v-if="!authFlg">
                아이디 : <input type="text" v-model="userId">
                <button @click="fnAuth">본인인증</button>
            </div>
            <div v-if="authFlg">
                <h2>비밀번호 재설성</h2>
                <div>
                    비밀번호 : <input type="password" v-model="pwd">
                </div>
                <div>
                    비밀번호 확인 : <input type="password" v-model="pwd2">
                </div>
                <div>
                    <button @click="fnChange">확인</button>
                </div>
            </div>
        </div>
    </body>

    </html>

    <script>
        IMP.init("imp01876866");
        const app = Vue.createApp({
            data() {
                return {
                    userId: "",
                    authFlg: false,
                    pwd: "",
                    pwd2: "",
                };
            },
            methods: {
                fnAuth: function () {
                    let self = this;
                    // IMP.certification(param, callback) 호출
                    IMP.certification(
                        {
                            // param
                            channelKey: "channel-key-7f1f2204-bbf1-4425-8fb1-3ea3b34c79e2",
                            merchant_uid: "AUTH" + new Date().toLocaleString(), // 주문 번호
                            m_redirect_url: "", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
                            popup: false, // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
                        },
                        function (rsp) {
                            // callback
                            if (rsp.success) {
                                // 인증 성공 시 로직
                                // jQuery로 HTTP 요청
                                $.ajax({
                                    url: "auth.dox",
                                    method: "POST",
                                    dataType: "json",
                                    data: { 
                                        impUid: rsp.imp_uid,
                                        userId: self.userId
                                    },
                                    success : function (data) {
                                        console.log(data);
                                        if(data.success){
                                            
                                            self.authFlg = true;
                                        }else{
                                            alert("번호가 다름");
                                        }
                                    }
                                });
                            } else {
                                // 인증 실패 시 로직
                            }
                        },
                    );
                },
                fnChange() {
                    let self = this;
                    if (self.pwd != self.pwd2) {
                        alert("비밀번호 확인");
                        return;
                    }
                    let param = {
                        userId: self.userId,
                        pwd: self.pwd
                    }
                    $.ajax({
                        url: "http://localhost:8080/re-pwd.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            alert(data.message)
                            location.href = "login.do";
                        }
                    });
                }
            }, // methods
            mounted() {
                let self = this;
            }
        });

        app.mount('#app');
    </script>