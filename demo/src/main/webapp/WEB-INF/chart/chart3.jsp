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
        <script src="https://cdn.jsdelivr.net/npm/apexcharts@8.8.1/dist/apexcharts.min.js"></script>
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
            <div>
                <button @click="fnChart">차트1</button>
                <button @click="fnChart2">차트2</button>
            </div>
            <div id="chart"></div>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    list: ""
                };
            },
            methods: {
                fnList: function () {
                    let self = this;
                    let param = {};
                    $.ajax({
                        url: "http://localhost:8080/product/total-order-price.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            self.list = data.list;
                        }
                    });
                },
                fnChart() {
                    let self = this;

                    var options = {
                        chart: {
                            type: 'line'
                        },
                        series: [{
                            name: 'total order price',
                            data: self.list.map(item => item.totalPrice)
                        }],
                        xaxis: {
                            categories: self.list.map(item => item.productName)
                        }
                    }

                    var chart = new ApexCharts(document.querySelector('#chart'), options)

                    chart.render()
                },
                fnChart2() {
                    const self = this;

                    const options = {
                        series: self.list.map(item => Number(item.totalPrice)),
                        chart: {
                            type: 'donut',
                            width: 420,
                            height: 350,
                        },
                        labels: self.list.map(item => item.productName),
                        colors: self.list.map(() =>
                            '#' + Math.floor(Math.random() * 16777215)
                                .toString(16).padStart(6, '0')
                        ),
                        plotOptions: {
                            pie: {
                                expandOnClick: false,
                                borderRadius: 4,
                                donut: {
                                    size: '68%',
                                    labels: {
                                        show: true,
                                        total: {
                                            show: true,
                                            label: 'Total Orders',
                                        },
                                    },
                                },
                            },
                        },
                        dataLabels: {
                            enabled: false,
                        },
                        legend: {
                            position: 'bottom',
                        },
                    };

                    const chart = new ApexCharts(
                        document.querySelector('#chart'),
                        options
                    );

                    chart.render();
                }
            }, // methods
            mounted() {
                let self = this;
                self.fnList();
            }
        });

        app.mount('#app');
    </script>