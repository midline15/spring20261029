
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리별 장소 검색</title>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>

    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2669401d1a4ac21b4fc46aef901f34d5&libraries=services"></script>

    <style>
        #map {
            width: 100%;
            height: 350px;
        }
    </style>
</head>

<body>

    <div id="app">

        <select v-model="category">
            <option value="">:: 선택 ::</option>
            <option value="MT1">대형마트</option>
            <option value="CS2">편의점</option>
            <option value="PS3">어린이집, 유치원</option>
            <option value="SC4">학교</option>
            <option value="AC5">학원</option>
            <option value="PK6">주차장</option>
            <option value="OL7">주유소, 충전소</option>
            <option value="SW8">지하철역</option>
            <option value="BK9">은행</option>
            <option value="CT1">문화시설</option>
            <option value="AG2">중개업소</option>
            <option value="PO3">공공기관</option>
            <option value="AT4">관광명소</option>
            <option value="AD5">숙박</option>
            <option value="FD6">음식점</option>
            <option value="CE7">카페</option>
            <option value="HP8">병원</option>
            <option value="PM9">약국</option>
        </select>

        <div id="map"></div>

    </div>

    <script>
        const app = Vue.createApp({

            data() {
                return {
                    category: "BK9",

                    map: null,
                    ps: null,
                    infowindow: null,
                    markers: []
                };
            },

            watch: {
                // 카테고리가 변경되면 다시 검색
                category(newValue) {
                    if (newValue) {
                        this.searchPlaces();
                    } else {
                        this.removeMarker();
                    }
                }
            },

            methods: {

                // 지도 초기화
                fnInit() {

                    const mapContainer = document.getElementById('map');

                    const mapOption = {
                        center: new kakao.maps.LatLng(37.489550, 126.724070),
                        level: 3
                    };

                    this.map = new kakao.maps.Map(mapContainer, mapOption);

                    // 장소 검색 객체
                    this.ps = new kakao.maps.services.Places(this.map);

                    // 인포윈도우
                    this.infowindow = new kakao.maps.InfoWindow({
                        zIndex: 1
                    });

                    // 최초 검색
                    this.searchPlaces();
                },

                // 카테고리 검색
                searchPlaces() {

                    this.removeMarker();

                    this.ps.categorySearch(
                        this.category,
                        (data, status, pagination) => {
                            this.placesSearchCB(data, status, pagination);
                        },
                        {
                            useMapBounds: true
                        }
                    );
                },

                // 검색 완료 콜백
                placesSearchCB(data, status, pagination) {

                    if (status === kakao.maps.services.Status.OK) {

                        for (let i = 0; i < data.length; i++) {
                            this.displayMarker(data[i]);
                        }

                    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                        alert('검색 결과가 존재하지 않습니다.');

                    } else if (status === kakao.maps.services.Status.ERROR) {

                        alert('검색 중 오류가 발생했습니다.');

                    }
                },

                // 지도에 마커 표시
                displayMarker(place) {

                    const marker = new kakao.maps.Marker({
                        map: this.map,
                        position: new kakao.maps.LatLng(place.y, place.x)
                    });

                    this.markers.push(marker);

                    // 마커 클릭 이벤트
                    kakao.maps.event.addListener(marker, 'click', () => {

                        const content =
                            '<div style="padding:5px;font-size:12px;">' +
                            place.place_name +
                            '</div>';

                        this.infowindow.setContent(content);

                        this.infowindow.open(this.map, marker);

                    });
                },

                // 기존 마커 제거
                removeMarker() {

                    this.markers.forEach(marker => {
                        marker.setMap(null);
                    });

                    this.markers = [];

                    this.infowindow?.close();
                }

            },

            mounted() {
                this.fnInit();
            }

        });

        app.mount('#app');
    </script>

</body>
</html>
