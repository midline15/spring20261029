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
            <div id="chart"></div>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {

                };
            },
            methods: {
                fnList: function () {
                    let self = this;
                    let param = {};
                    $.ajax({
                        url: "http://localhost:8080/",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {

                        }
                    });
                },
                fnchart() {
                    let self = this;
                    var options = {
                        chart: {
                            type: 'line'
                        },
                        series: [{
                            name: 'sales',
                            data: [125, 40, 35, 50, 49, 60, 70, 91, 125]
                        }],
                        xaxis: {
                            categories: [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999]
                        }
                    }

                    var chart = new ApexCharts(document.querySelector('#chart'), options)

                    chart.render()
                }
            }, // methods
            mounted() {
                let self = this;
                self.fnchart();
            }
        });

        app.mount('#app');
    </script>