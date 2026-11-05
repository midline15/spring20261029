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
            아이디 : <input type="text" v-model="userId">
        </div>
        <div>
            비밀번호 : <input type="password" v-model="pwd">
        </div>
        <div>
            비밀번호 확인 : <input type="password" v-model="pwd2">
        </div>
        <div>
            이름 : <input type="text" v-model="userName">
        </div>
        <div>
            주소 : <input type="text" v-model="addr">
            <button @click="fnAddr">주소검색</button>
        </div>
        <div>
            <button @click="fnJoin">가입하기</button>
        </div>
    </div>
</body>
</html>

<script>
    function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
        console.log("roadFullAddr ==> ", roadFullAddr);
        window.vueObj.addr = roadFullAddr;
    }

    const app = Vue.createApp({
        data() {
            return {
                userId: "",
                pwd: "",
                pwd2: "",
                userName: "",
                addr: ""
            };
        },
        methods: {
            fnJoin : function () {
                let self = this;
                // 1. 아이디는 최소 다섯 글자
                if(self.userId.length < 5){
                    alert("아이디는 최소 5글자 입니다.");
                    return;
                }
                // 2. 아이디는 영어 소문자 + 숫자 필수, 영어로 시작
                const idRegex = /^(?=.*\d)[a-z][a-z\d]*$/;
                
                if(!idRegex.test(self.userId)){
                    alert("아이디는 영어 소문자+숫자 조합입니다. \n아이디는 소문자로 시작해야 합니다.");
                    return;
                }
                // 3. 비밀번호는 최소 8글자
                if(self.pwd.length < 8){
                    alert("비밀번호는 최소 8글자 입니다.");
                    return;
                }
                // 4. 비밀번호는 특수문자 필수
                const pwdRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!-/:-@[-`{-~])[!-~]+$/;
                if(!pwdRegex.test(self.pwd)){
                    alert("비밀번호는 영문대소문자,특수문자,숫자 조합입니다.")
                    return;
                }
                // 5. 비밀번호와 비밀번호 확인은 같아야함
                if(self.pwd != self.pwd2){
                    alert("비밀번호가 다릅니다.")
                    return;
                }
                // 6. 이름은 한글만
                const nameRegex = /^[가-힣]+$/;
                if(!nameRegex.test(self.userName)){
                    alert("이름은 한글만");
                    return;
                }
                // 7. 이름, 주소는 빈 값 안됨
                if(self.userName == "" || self.addr == ""){
                    alert("필수 값은 모두 입력해주세요.")
                    return;
                }
                let param = {
                    userId: self.userId,
                    pwd: self.pwd,
                    userName: self.userName,
                    addr: self.addr
                };
                $.ajax({
                    url: "http://localhost:8080/user/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.message);
                        location.href="login.do";
                    }
                });
            },
            fnAddr: function () {
                let self = this;
                window.open("addr.do", "addr", "width=500, height=500");
            }
        }, // methods
        mounted() {
            let self = this;
            window.vueObj = this;
        }
    });

    app.mount('#app');
</script>