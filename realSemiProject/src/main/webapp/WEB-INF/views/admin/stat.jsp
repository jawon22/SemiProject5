<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.title{
		font-size: 30px;
		font-weight: bold;
		color: #26C2BF;
	}
</style>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    $(function () {

        //나이 통계
        $.ajax({
            url: contextPath+"/rest/member/stat/birth",
            dataType: "json",
            method:"post",
            success: function (response) {
                var labels = [], data = [];

                for (var i = 0; i < response.length; i++) {
                    labels.push(response[i].name);
                    data.push(response[i].cnt);
                }

                const ctx = document.getElementById('birthChart');

                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: [
                            	'rgb(186, 219, 173)',
                                'rgb(199, 173, 214)',
                                'rgb(255, 187, 187)',
                                'rgb(153, 204, 204)'
                            ],
                            borderWidth: 1,
                        }]
                    },
                    options: {
                    	responsive: true,
                        plugins: {
                            title: {
                                display: true,
                                text: '회원 나이 통계',
                            },
                            legend: {
                                position: 'top',
                            }
                        }
                    }
                });
            },
        });
        
        
        //지역 통계
        $.ajax({
            url: contextPath+"/rest/member/stat/area",
            dataType: "json",
            method:"post",
            success: function (response) {
                var labels = [], data = [];

                for (var i = 0; i < response.length; i++) {
                    labels.push(response[i].name);
                    data.push(response[i].cnt);
                }

                const ctx = document.getElementById('areaChart');

                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: [
                            	'rgb(186, 219, 173)',
                                'rgb(199, 173, 214)',
                                'rgb(255, 187, 187)',
                                'rgb(153, 204, 204)',
                                'rgb(214, 173, 230)',
                                'rgb(244, 230, 204)',
                                'rgb(204, 173, 214)',
                                'rgb(255, 204, 173)',
                                'rgb(255, 214, 186)',
                                'rgb(255, 244, 204)',
                                'rgb(186, 219, 186)',
                                'rgb(173, 204, 214)',
                                'rgb(219, 186, 173)',
                                'rgb(204, 204, 204)'
                            ],
                            borderWidth: 1,
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            title: {
                                display: true,
                                text: '회원 지역 통계',
                            },
                            legend: {
                                position: 'top',
                            }
                        }
                    }
                });
            },
        });
        
        
        //가입월 통계
        $.ajax({
            url: contextPath+"/rest/member/stat/join",
            dataType: "json",
            method:"post",
            success: function (response) {
                var labels = [], data = [];

                for (var i = 0; i < response.length; i++) {
                    labels.push(response[i].name);
                    data.push(response[i].cnt);
                }

                const ctx = document.getElementById('joinChart');

                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: [
                            	'rgb(186, 219, 173)',
                                'rgb(199, 173, 214)',
                                'rgb(255, 187, 187)',
                                'rgb(153, 204, 204)',
                                'rgb(214, 173, 230)',
                                'rgb(244, 230, 204)',
                                'rgb(204, 173, 214)',
                                'rgb(255, 204, 173)',
                                'rgb(255, 214, 186)',
                                'rgb(255, 244, 204)',
                                'rgb(186, 219, 186)',
                                'rgb(173, 204, 214)'
                            ],
                            borderWidth: 1,
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            title: {
                                display: true,
                                text: '회원 가입월 통계',
                            },
                            legend: {
                                position: 'top',
                            }
                        }
                    }
                });
            },
        });
        
        
        //등급 통계
        $.ajax({
            url: contextPath+"/rest/member/stat/level",
            dataType: "json",
            method:"post",
            success: function (response) {
                var labels = [], data = [];

                for (var i = 0; i < response.length; i++) {
                    labels.push(response[i].name);
                    data.push(response[i].cnt);
                }

                const ctx = document.getElementById('levelChart');

                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: [
                                'rgb(186, 219, 173)',
                                'rgb(199, 173, 214)',
                                'rgb(255, 187, 187)',
                            ],
                            borderWidth: 1,
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            title: {
                                display: true,
                                text: '회원 등급 통계',
                            },
                            legend: {
                                position: 'top',
                            }
                        }
                    }
                });
            },
        });
    });
</script>

<div class="container w-700">

	<div class="row">
		<a href="stat" class="link" ><span class="title">회원통계</span></a>
	</div>

        <div class="flex-container">
            <div class="inline-flex-container align-center card">
                <div class="center">
        			<canvas id="birthChart"></canvas>
    			</div>
            </div>
            <div class="inline-flex-container align-center card" style="margin-left:100px">
                <div class="center">
        			<canvas id="areaChart"></canvas>
    			</div>
            </div>
        </div>
        
        <div class="row"></div>
        
        <div class="flex-container">
            <div class="inline-flex-container align-center card">
                <div class="center">
        			<canvas id="joinChart"></canvas>
    			</div>
            </div>
            <div class="inline-flex-container align-center card" style="margin-left:100px">
                <div class="center">
        			<canvas id="levelChart"></canvas>
    			</div>
            </div>
        </div>

    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
