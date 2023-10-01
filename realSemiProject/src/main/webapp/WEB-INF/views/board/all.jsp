<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
h1 {
	font-size: 30px;
	font-weight: bold;
	color: #26C2BF;
}
</style>

<!-- 카카오 지도 cdn -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c18c138c3ab7eb5251102708e8a79c47"></script>
<script>
	$(function(){
		var areas = [
		    {
		         name : '경기',
		        path : [
		            new kakao.maps.LatLng(38.2657,127.0907),
		            new kakao.maps.LatLng(38.1873,126.9714),
		            new kakao.maps.LatLng(38.1536,126.9538),
		            new kakao.maps.LatLng(38.1337,126.9733),
		            new kakao.maps.LatLng(38.0939,126.9013),
		            new kakao.maps.LatLng(38.0954,126.8819),
		            new kakao.maps.LatLng(37.9958,126.8235),
		            new kakao.maps.LatLng(37.9413,126.7093),
		            new kakao.maps.LatLng(37.9488,126.6785),
		            new kakao.maps.LatLng(37.8309,126.6975),
		            new kakao.maps.LatLng(37.7728,126.6619),
		            new kakao.maps.LatLng(37.7485,126.5813),
		            new kakao.maps.LatLng(37.7803,126.5315),
		            new kakao.maps.LatLng(37.5889,126.5481),
		            new kakao.maps.LatLng(37.4083,126.6192),
		            new kakao.maps.LatLng(37.3235,126.6690),
		            new kakao.maps.LatLng(37.2877,126.7805),
		            new kakao.maps.LatLng(37.2632,126.5339),
		            new kakao.maps.LatLng(37.1933,126.5623),
		            new kakao.maps.LatLng(37.2179,126.6192),
		            new kakao.maps.LatLng(37.1177,126.6856),
		            new kakao.maps.LatLng(37.1423,126.7591),
		            new kakao.maps.LatLng(37.0856,126.7354),
		            new kakao.maps.LatLng(37.0326,126.7473),
		            new kakao.maps.LatLng(37.0194,126.7947),
		            new kakao.maps.LatLng(36.9872,126.7828),
		            new kakao.maps.LatLng(36.9436,126.8445),
		            new kakao.maps.LatLng(36.8981,126.8540),
		            new kakao.maps.LatLng(36.9645,127.1361),
		            new kakao.maps.LatLng(36.8962,127.2926),
		            new kakao.maps.LatLng(36.9266,127.2973),
		            new kakao.maps.LatLng(36.9626,127.3874),
		            new kakao.maps.LatLng(36.9891,127.3874),
		            new kakao.maps.LatLng(37.0175,127.4515),
		            new kakao.maps.LatLng(37.0421,127.4609),
		            new kakao.maps.LatLng(37.0591,127.5250),
		            new kakao.maps.LatLng(37.0440,127.5629),
		            new kakao.maps.LatLng(37.0743,127.5700),
		            new kakao.maps.LatLng(37.1007,127.6269),
		            new kakao.maps.LatLng(37.1593,127.6245),
		            new kakao.maps.LatLng(37.1367,127.6862),
		            new kakao.maps.LatLng(37.2141,127.7455),
		            new kakao.maps.LatLng(37.3650,127.7621),
		            new kakao.maps.LatLng(37.4724,127.8000),
		            new kakao.maps.LatLng(37.4987,127.7573),
		            new kakao.maps.LatLng(37.5438,127.8427),
		            new kakao.maps.LatLng(37.6401,127.6151),
		            new kakao.maps.LatLng(37.6383,127.5416),
		            new kakao.maps.LatLng(37.7189,127.5582),
		            new kakao.maps.LatLng(37.7189,127.5155),
		            new kakao.maps.LatLng(37.7583,127.5439),
		            new kakao.maps.LatLng(37.8314,127.5226),
		            new kakao.maps.LatLng(37.8910,127.6105),
		            new kakao.maps.LatLng(37.9546,127.5986),
		            new kakao.maps.LatLng(38.0069,127.4635),
		            new kakao.maps.LatLng(38.1059,127.4398),
		            new kakao.maps.LatLng(38.0984,127.4066),
		            new kakao.maps.LatLng(38.1189,127.3947),
		            new kakao.maps.LatLng(38.0928,127.3378),
		            new kakao.maps.LatLng(38.1245,127.2738),
		            new kakao.maps.LatLng(38.1749,127.2975),
		            new kakao.maps.LatLng(38.1395,127.2264)
		        ]
		    },  {
		        name : '서울',
		        path : [
		        	new kakao.maps.LatLng(37.6552,126.9484),
		        	new kakao.maps.LatLng(37.6418,126.9119),
		        	new kakao.maps.LatLng(37.5872,126.9002),
		        	new kakao.maps.LatLng(37.5891,126.8841),
		        	new kakao.maps.LatLng(37.5783,126.8751),
		        	new kakao.maps.LatLng(37.5718,126.8511),
		        	new kakao.maps.LatLng(37.6045,126.8062),
		        	new kakao.maps.LatLng(37.5514,126.7715),
		        	new kakao.maps.LatLng(37.5367,126.8241),
		        	new kakao.maps.LatLng(37.4781,126.8212),
		        	new kakao.maps.LatLng(37.4928,126.8723),
		        	new kakao.maps.LatLng(37.4388,126.9017),
		        	new kakao.maps.LatLng(37.4467,126.9287),
		        	new kakao.maps.LatLng(37.4364,126.9423),
		        	new kakao.maps.LatLng(37.4625,127.0001),
		        	new kakao.maps.LatLng(37.4576,127.0321),
		        	new kakao.maps.LatLng(37.4305,127.0576),
		        	new kakao.maps.LatLng(37.4407,127.0731),
		        	new kakao.maps.LatLng(37.4622,127.0983),
		        	new kakao.maps.LatLng(37.4909,127.1606),
		        	new kakao.maps.LatLng(37.5078,127.1393),
		        	new kakao.maps.LatLng(37.5450,127.1606),
		        	new kakao.maps.LatLng(37.5495,127.1777),
		        	new kakao.maps.LatLng(37.5791,127.1724),
		        	new kakao.maps.LatLng(37.5558,127.1048),
		        	new kakao.maps.LatLng(37.5964,127.1161),
		        	new kakao.maps.LatLng(37.6391,127.1104),
		        	new kakao.maps.LatLng(37.6436,127.0934),
		        	new kakao.maps.LatLng(37.6852,127.0934),
		        	new kakao.maps.LatLng(37.6920,127.0806),
		        	new kakao.maps.LatLng(37.6964,127.0252),
		        	new kakao.maps.LatLng(37.6852,127.0068),
		        	new kakao.maps.LatLng(37.6537,126.9883),
		        	new kakao.maps.LatLng(37.6312,126.9812)
		        ]
		    }, {
		        name : '강원',
		        path : [
		            new kakao.maps.LatLng(38.6081,128.3706),
		            new kakao.maps.LatLng(38.5807,128.3228),
		            new kakao.maps.LatLng(38.4935,128.3228),
		            new kakao.maps.LatLng(38.4237,128.2909),
		            new kakao.maps.LatLng(38.3062,128.0870),
		            new kakao.maps.LatLng(38.3187,127.8895),
		            new kakao.maps.LatLng(38.2987,127.8289),
		            new kakao.maps.LatLng(38.3312,127.7843),
		            new kakao.maps.LatLng(38.3237,127.6155),
		            new kakao.maps.LatLng(38.2912,127.4944),
		            new kakao.maps.LatLng(38.3187,127.3924),
		            new kakao.maps.LatLng(38.3262,127.2427),
		            new kakao.maps.LatLng(38.2962,127.1407),
		            new kakao.maps.LatLng(38.2762,127.1057),
		            new kakao.maps.LatLng(38.2412,127.1280),
		            new kakao.maps.LatLng(38.2362,127.1758),
		            new kakao.maps.LatLng(38.1410,127.2172),
		            new kakao.maps.LatLng(38.1836,127.2936),
		            new kakao.maps.LatLng(38.1160,127.2968),
		            new kakao.maps.LatLng(38.1135,127.4243),
		            new kakao.maps.LatLng(38.0131,127.4689),
		            new kakao.maps.LatLng(37.9981,127.5358),
		            new kakao.maps.LatLng(37.9528,127.5995),
		            new kakao.maps.LatLng(37.8732,127.6166),
		            new kakao.maps.LatLng(37.8313,127.5318),
		            new kakao.maps.LatLng(37.7610,127.5509),
		            new kakao.maps.LatLng(37.7258,127.5127),
		            new kakao.maps.LatLng(37.7225,127.5615),
		            new kakao.maps.LatLng(37.6369,127.5551),
		            new kakao.maps.LatLng(37.6453,127.6145),
		            new kakao.maps.LatLng(37.5513,127.8519),
		            new kakao.maps.LatLng(37.4958,127.7734),
		            new kakao.maps.LatLng(37.4292,127.8150),
		            new kakao.maps.LatLng(37.2157,127.7532),
		            new kakao.maps.LatLng(37.1495,127.7918),
		            new kakao.maps.LatLng(37.1603,127.9193),
		            new kakao.maps.LatLng(37.2249,127.9270),
		            new kakao.maps.LatLng(37.2618,127.9850),
		            new kakao.maps.LatLng(37.1957,128.0391),
		            new kakao.maps.LatLng(37.2295,128.1318),
		            new kakao.maps.LatLng(37.2141,128.1666),
		            new kakao.maps.LatLng(37.2480,128.1994),
		            new kakao.maps.LatLng(37.2095,128.2747),
		            new kakao.maps.LatLng(37.2187,128.3308),
		            new kakao.maps.LatLng(37.1495,128.2825),
		            new kakao.maps.LatLng(37.1521,128.3882),
		            new kakao.maps.LatLng(37.1037,128.4338),
		            new kakao.maps.LatLng(37.1273,128.4930),
		            new kakao.maps.LatLng(37.0301,128.7538),
		            new kakao.maps.LatLng(37.0898,128.7765),
		            new kakao.maps.LatLng(37.0470,128.8882),
		            new kakao.maps.LatLng(37.0969,128.9299),
		            new kakao.maps.LatLng(37.0706,129.0656),
		            new kakao.maps.LatLng(37.1025,129.0934),
		            new kakao.maps.LatLng(37.0428,129.1926),
		            new kakao.maps.LatLng(37.0387,129.2343),
		            new kakao.maps.LatLng(37.0775,129.2308),
		            new kakao.maps.LatLng(37.1441,129.3595),
		            new kakao.maps.LatLng(37.2300,129.3561),
		            new kakao.maps.LatLng(37.3753,129.2587),
		            new kakao.maps.LatLng(37.4915,129.1439),
		            new kakao.maps.LatLng(37.5702,129.1195),
		            new kakao.maps.LatLng(37.6391,129.0482),
		            new kakao.maps.LatLng(37.6776,129.0586),
		            new kakao.maps.LatLng(38.1572,128.6054),
		            new kakao.maps.LatLng(38.2153,128.5978)
		        ]
		    }, {
		        name : '충청',
		        path : [
		            new kakao.maps.LatLng(37.0557,126.5035 ),
		            new kakao.maps.LatLng(36.8822,126.2202),
		            new kakao.maps.LatLng(36.7184,126.1289),
		            new kakao.maps.LatLng(36.6098,126.3020),
		            new kakao.maps.LatLng(36.3643,126.3807),
		            new kakao.maps.LatLng(36.4074,126.4437),
		            new kakao.maps.LatLng(36.6148,126.3807),
		            new kakao.maps.LatLng(36.6098,126.4437),
		            new kakao.maps.LatLng(36.2146,126.5444),
		            new kakao.maps.LatLng(36.1435,126.5098),
		            new kakao.maps.LatLng(35.9959,126.6860),
		            new kakao.maps.LatLng(36.0642,126.8548),
		            new kakao.maps.LatLng(36.1397,126.8831),
		            new kakao.maps.LatLng(36.1512,127.0475),
		            new kakao.maps.LatLng(36.0848,127.0843),
		            new kakao.maps.LatLng(36.1283,127.3394),
		            new kakao.maps.LatLng(36.0138,127.3989),
		            new kakao.maps.LatLng(35.9817,127.5123),
		            new kakao.maps.LatLng(36.0367,127.5434),
		            new kakao.maps.LatLng(36.0084,127.6138),
		            new kakao.maps.LatLng(36.0670,127.6283),
		            new kakao.maps.LatLng(36.0610,127.6890),
		            new kakao.maps.LatLng(36.0391,127.7060),
		            new kakao.maps.LatLng(36.0350,127.8554),
		            new kakao.maps.LatLng(36.0597,127.9555),
		            new kakao.maps.LatLng(36.1981,127.9759),
		            new kakao.maps.LatLng(36.2009,128.0506),
		            new kakao.maps.LatLng(36.2529,128.0421),
		            new kakao.maps.LatLng(36.2680,128.0132),
		            new kakao.maps.LatLng(36.2474,127.9555),
		            new kakao.maps.LatLng(36.2899,127.9012),
		            new kakao.maps.LatLng(36.2707,127.8554),
		            new kakao.maps.LatLng(36.3172,127.8452),
		            new kakao.maps.LatLng(36.3575,127.8874),
		            new kakao.maps.LatLng(36.3963,127.8645),
		            new kakao.maps.LatLng(36.4846,127.8737),
		            new kakao.maps.LatLng(36.5024,127.9059),
		            new kakao.maps.LatLng(36.5242,127.9008),
		            new kakao.maps.LatLng(36.5856,127.8007),
		            new kakao.maps.LatLng(36.6128,127.8499),
		            new kakao.maps.LatLng(36.6551,127.8788),
		            new kakao.maps.LatLng(36.6101,127.9212),
		            new kakao.maps.LatLng(36.6496,127.9331),
		            new kakao.maps.LatLng(36.6850,127.8822),
		            new kakao.maps.LatLng(36.7013,127.9348),
		            new kakao.maps.LatLng(36.7367,127.9551),
		            new kakao.maps.LatLng(36.7068,128.0638),
		            new kakao.maps.LatLng(36.7544,128.0315),
		            new kakao.maps.LatLng(36.8183,128.0553),
		            new kakao.maps.LatLng(36.8006,128.0926),
		            new kakao.maps.LatLng(36.8373,128.1334),
		            new kakao.maps.LatLng(36.8169,128.2047),
		            new kakao.maps.LatLng(36.8482,128.2149),
		            new kakao.maps.LatLng(36.8740,128.2471),
		            new kakao.maps.LatLng(36.8061,128.3693),
		            new kakao.maps.LatLng(36.8129,128.4236),
		            new kakao.maps.LatLng(36.8495,128.4474),
		            new kakao.maps.LatLng(36.8794,128.4253),
		            new kakao.maps.LatLng(36.9310,128.4457),
		            new kakao.maps.LatLng(37.0246,128.5679),
		            new kakao.maps.LatLng(37.0598,128.6443),
		            new kakao.maps.LatLng(37.0909,128.5102),
		            new kakao.maps.LatLng(37.1234,128.4983),
		            new kakao.maps.LatLng(37.0977,128.4304),
		            new kakao.maps.LatLng(37.1505,128.3880),
		            new kakao.maps.LatLng(37.1315,128.2997),
		            new kakao.maps.LatLng(37.1586,128.2624),
		            new kakao.maps.LatLng(37.2113,128.3303),
		            new kakao.maps.LatLng(37.2411,128.2132),
		            new kakao.maps.LatLng(37.1857,128.0400),
		            new kakao.maps.LatLng(37.2519,127.9891),
		            new kakao.maps.LatLng(37.2276,127.9280),
		            new kakao.maps.LatLng(37.1532,127.9110),
		            new kakao.maps.LatLng(37.1343,127.7871),
		            new kakao.maps.LatLng(37.2019,127.7430),
		            new kakao.maps.LatLng(37.1315,127.6836),
		            new kakao.maps.LatLng(37.1464,127.6377),
		            new kakao.maps.LatLng(37.0693,127.6004),
		            new kakao.maps.LatLng(36.9907,127.3967),
		            new kakao.maps.LatLng(36.9405,127.3848),
		            new kakao.maps.LatLng(36.8930,127.2931),
		            new kakao.maps.LatLng(36.9608,127.1540),
		            new kakao.maps.LatLng(36.8903,126.8773)
		        ]
		    }, {
		        name : '경상',
		        path : [
		            new kakao.maps.LatLng(37.1460,129.3759),
		            new kakao.maps.LatLng(37.0666,129.2360),
		            new kakao.maps.LatLng(37.0964,129.0867),
		            new kakao.maps.LatLng(37.0393,128.8815),
		            new kakao.maps.LatLng(37.0889,128.8006),
		            new kakao.maps.LatLng(37.0542,128.6483),
		            new kakao.maps.LatLng(36.8131,128.4306),
		            new kakao.maps.LatLng(36.8579,128.2471),
		            new kakao.maps.LatLng(36.8056,128.0606),
		            new kakao.maps.LatLng(36.7085,128.0668),
		            new kakao.maps.LatLng(36.6785,127.8958),
		            new kakao.maps.LatLng(36.5982,127.9305),
		            new kakao.maps.LatLng(36.6461,127.8699),
		            new kakao.maps.LatLng(36.5958,127.8057),
		            new kakao.maps.LatLng(36.5675,127.8683),
		            new kakao.maps.LatLng(36.2756,127.8702),
		            new kakao.maps.LatLng(36.2528,128.0339),
		            new kakao.maps.LatLng(36.1944,128.0654),
		            new kakao.maps.LatLng(36.1842,127.9835),
		            new kakao.maps.LatLng(36.0444,127.9332),
		            new kakao.maps.LatLng(36.0138,127.8765),
		            new kakao.maps.LatLng(35.8992,127.8796),
		            new kakao.maps.LatLng(35.7665,127.6845),
		            new kakao.maps.LatLng(35.5439,127.5932),
		            new kakao.maps.LatLng(35.4317,127.6751),
		            new kakao.maps.LatLng(35.2957,127.5869),
		            new kakao.maps.LatLng(35.0074,127.7884),
		            new kakao.maps.LatLng(34.7311,127.8167),
		            new kakao.maps.LatLng(34.6975,128.0433),
		            new kakao.maps.LatLng(34.8707,128.0685),
		            new kakao.maps.LatLng(34.9120,128.2951),
		            new kakao.maps.LatLng(34.8526,128.4179),
		            new kakao.maps.LatLng(35.0744,128.4934),
		            new kakao.maps.LatLng(35.0641,128.6382),
		            new kakao.maps.LatLng(35.1903,128.5910),
		            new kakao.maps.LatLng(35.0770,128.7515),
		            new kakao.maps.LatLng(35.0435,129.0883),
		            new kakao.maps.LatLng(35.3162,129.2992),
		            new kakao.maps.LatLng(35.3571,129.3634),
		            new kakao.maps.LatLng(35.5161,129.3792),
		            new kakao.maps.LatLng(35.4751,129.4233),
		            new kakao.maps.LatLng(35.5955,129.4768),
		            new kakao.maps.LatLng(35.6415,129.4358),
		            new kakao.maps.LatLng(36.0192,129.5901),
		            new kakao.maps.LatLng(36.0752,129.5649),
		            new kakao.maps.LatLng(35.9912,129.4421),
		            new kakao.maps.LatLng(36.0447,129.3855),
		            new kakao.maps.LatLng(36.0828,129.4327),
		            new kakao.maps.LatLng(36.3419,129.3949),
		            new kakao.maps.LatLng(36.4035,129.4539),
		            new kakao.maps.LatLng(36.7502,129.4815),
		            new kakao.maps.LatLng(36.8846,129.4154),
		            new kakao.maps.LatLng(37.0571,129.4246)
		        ]
		    }, {
		        name : '전라',
		        path : [
		            new kakao.maps.LatLng(35.9690,126.5272),
		            new kakao.maps.LatLng(35.8288,126.6409),
		            new kakao.maps.LatLng(35.7737,126.5781),
		            new kakao.maps.LatLng(35.7089,126.6019),
		            new kakao.maps.LatLng(35.6386,126.4678),
		            new kakao.maps.LatLng(35.5751,126.5034),
		            new kakao.maps.LatLng(35.5848,126.6562),
		            new kakao.maps.LatLng(35.5655,126.6528),
		            new kakao.maps.LatLng(35.5282,126.4899),
		            new kakao.maps.LatLng(35.2154,126.2997),
		            new kakao.maps.LatLng(35.0927,126.0108),
		            new kakao.maps.LatLng(34.9969,126.0957),
		            new kakao.maps.LatLng(34.7671,125.8818),
		            new kakao.maps.LatLng(34.3561,126.1653),
		            new kakao.maps.LatLng(34.5479,126.4318),
		            new kakao.maps.LatLng(34.2888,126.5218),
		            new kakao.maps.LatLng(34.3183,126.8850),
		            new kakao.maps.LatLng(34.4290,127.2194),
		            new kakao.maps.LatLng(34.5104,127.4277),
		            new kakao.maps.LatLng(34.4105,127.4890),
		            new kakao.maps.LatLng(34.6010,127.5071),
		            new kakao.maps.LatLng(34.7797,127.3943),
		            new kakao.maps.LatLng(34.8700,127.5113),
		            new kakao.maps.LatLng(34.6480,127.5684),
		            new kakao.maps.LatLng(34.6228,127.6436),
		            new kakao.maps.LatLng(34.7144,127.6339),
		            new kakao.maps.LatLng(34.7488,127.6701),
		            new kakao.maps.LatLng(34.6846,127.7565),
		            new kakao.maps.LatLng(34.6193,127.7119),
		            new kakao.maps.LatLng(34.5815,127.7968),
		            new kakao.maps.LatLng(34.7167,127.7858),
		            new kakao.maps.LatLng(34.7729,127.7479),
		            new kakao.maps.LatLng(34.8911,127.7849),
		            new kakao.maps.LatLng(34.9679,127.7591),
		            new kakao.maps.LatLng(35.0182,127.7836),
		            new kakao.maps.LatLng(35.1813,127.6232),
		            new kakao.maps.LatLng(35.3077,127.5735),
		            new kakao.maps.LatLng(35.3360,127.6230),
		            new kakao.maps.LatLng(35.3683,127.6090),
		            new kakao.maps.LatLng(35.4409,127.6686),
		            new kakao.maps.LatLng(35.4517,127.6439),
		            new kakao.maps.LatLng(35.4792,127.6324),
		            new kakao.maps.LatLng(35.4859,127.6530),
		            new kakao.maps.LatLng(35.5510,127.5878),
		            new kakao.maps.LatLng(35.7689,127.6645),
		            new kakao.maps.LatLng(35.9400,127.9036),
		            new kakao.maps.LatLng(36.0340,127.8553),
		            new kakao.maps.LatLng(36.0124,127.7653),
		            new kakao.maps.LatLng(36.0615,127.6401),
		            new kakao.maps.LatLng(36.0051,127.6170),
		            new kakao.maps.LatLng(36.0367,127.5463),
		            new kakao.maps.LatLng(35.9840,127.5220),
		            new kakao.maps.LatLng(36.0111,127.3991),
		            new kakao.maps.LatLng(36.1285,127.3302),
		            new kakao.maps.LatLng(36.0608,127.1198),
		            new kakao.maps.LatLng(36.1345,127.0397),
		            new kakao.maps.LatLng(36.1315,126.8907),
		            new kakao.maps.LatLng(36.0533,126.8646)
		        ]
		    }, {
		        name : '제주',
		        path : [
		            new kakao.maps.LatLng(33.4878,126.3905),
		            new kakao.maps.LatLng(33.4761,126.3537),
		            new kakao.maps.LatLng(33.4668,126.3377),
		            new kakao.maps.LatLng(33.4694,126.3322),
		            new kakao.maps.LatLng(33.4684,126.3130),
		            new kakao.maps.LatLng(33.4460,126.2949),
		            new kakao.maps.LatLng(33.4425,126.2895),
		            new kakao.maps.LatLng(33.4448,126.2848),
		            new kakao.maps.LatLng(33.4433,126.2778),
		            new kakao.maps.LatLng(33.4351,126.2730),
		            new kakao.maps.LatLng(33.4376,126.2703),
		            new kakao.maps.LatLng(33.4351,126.2627),
		            new kakao.maps.LatLng(33.4160,126.2625),
		            new kakao.maps.LatLng(33.4130,126.2539),
		            new kakao.maps.LatLng(33.4091,126.2586),
		            new kakao.maps.LatLng(33.4079,126.2572),
		            new kakao.maps.LatLng(33.4088,126.2527),
		            new kakao.maps.LatLng(33.4006,126.2496),
		            new kakao.maps.LatLng(33.3982,126.2424),
		            new kakao.maps.LatLng(33.3895,126.2348),
		            new kakao.maps.LatLng(33.3905,126.2220),
		            new kakao.maps.LatLng(33.3818,126.2146),
		            new kakao.maps.LatLng(33.3755,126.2138),
		            new kakao.maps.LatLng(33.3657,126.1968),
		            new kakao.maps.LatLng(33.3580,126.1807),
		            new kakao.maps.LatLng(33.3458,126.1793),
		            new kakao.maps.LatLng(33.3436,126.1691),
		            new kakao.maps.LatLng(33.3339,126.1621),
		            new kakao.maps.LatLng(33.3236,126.1635),
		            new kakao.maps.LatLng(33.3228,126.1667),
		            new kakao.maps.LatLng(33.3092,126.1659),
		            new kakao.maps.LatLng(33.3087,126.1639),
		            new kakao.maps.LatLng(33.2983,126.1678),
		            new kakao.maps.LatLng(33.2926,126.1613),
		            new kakao.maps.LatLng(33.2844,126.1640),
		            new kakao.maps.LatLng(33.2418,126.2131),
		            new kakao.maps.LatLng(33.2409,126.2288),
		            new kakao.maps.LatLng(33.2369,126.2288),
		            new kakao.maps.LatLng(33.2355,126.2353),
		            new kakao.maps.LatLng(33.2287,126.2379),
		            new kakao.maps.LatLng(33.2168,126.2486),
		            new kakao.maps.LatLng(33.2100,126.2562),
		            new kakao.maps.LatLng(33.2103,126.2623),
		            new kakao.maps.LatLng(33.1985,126.2622),
		            new kakao.maps.LatLng(33.1947,126.2716),
		            new kakao.maps.LatLng(33.2006,126.2847),
		            new kakao.maps.LatLng(33.1953,126.2886),
		            new kakao.maps.LatLng(33.1973,126.2951),
		            new kakao.maps.LatLng(33.2047,126.2906),
		            new kakao.maps.LatLng(33.2266,126.3025),
		            new kakao.maps.LatLng(33.2313,126.3152),
		            new kakao.maps.LatLng(33.2357,126.3162),
		            new kakao.maps.LatLng(33.2406,126.3308),
		            new kakao.maps.LatLng(33.2346,126.3352),
		            new kakao.maps.LatLng(33.2360,126.3622),
		            new kakao.maps.LatLng(33.2311,126.3662),
		            new kakao.maps.LatLng(33.2325,126.3846),
		            new kakao.maps.LatLng(33.2446,126.4084),
		            new kakao.maps.LatLng(33.2331,126.4336),
		            new kakao.maps.LatLng(33.2403,126.4562),
		            new kakao.maps.LatLng(33.2252,126.4717),
		            new kakao.maps.LatLng(33.2318,126.5139),
		            new kakao.maps.LatLng(33.2398,126.5199),
		            new kakao.maps.LatLng(33.2424,126.5905),
		            new kakao.maps.LatLng(33.2350,126.5969),
		            new kakao.maps.LatLng(33.2419,126.6200),
		            new kakao.maps.LatLng(33.2499,126.6194),
		            new kakao.maps.LatLng(33.2562,126.6394),
		            new kakao.maps.LatLng(33.2665,126.6422),
		            new kakao.maps.LatLng(33.2787,126.7391),
		            new kakao.maps.LatLng(33.3053,126.7776),
		            new kakao.maps.LatLng(33.3024,126.8067),
		            new kakao.maps.LatLng(33.3201,126.8479),
		            new kakao.maps.LatLng(33.3270,126.8365),
		            new kakao.maps.LatLng(33.3545,126.8700),
		            new kakao.maps.LatLng(33.3633,126.8669),
		            new kakao.maps.LatLng(33.3831,126.8808),
		            new kakao.maps.LatLng(33.3916,126.9061),
		            new kakao.maps.LatLng(33.4029,126.9030),
		            new kakao.maps.LatLng(33.4333,126.9163),
		            new kakao.maps.LatLng(33.4771,126.9091),
		            new kakao.maps.LatLng(33.5066,126.9136),
		            new kakao.maps.LatLng(33.5268,126.8913),
		            new kakao.maps.LatLng(33.5255,126.8597),
		            new kakao.maps.LatLng(33.5585,126.8248),
		            new kakao.maps.LatLng(33.5645,126.7656),
		            new kakao.maps.LatLng(33.5511,126.6763),
		            new kakao.maps.LatLng(33.5443,126.6733),
		            new kakao.maps.LatLng(33.5546,126.6451),
		            new kakao.maps.LatLng(33.5364,126.6325),
		            new kakao.maps.LatLng(33.5200,126.4932)
		        ]
		    }
		];
		
		var container = document.querySelector("#map");
		var cantainer = $("#map")
		
		var options = {
			center: new kakao.maps.LatLng(36.143912575657915, 127.77675054040399),
			/*	draggable: false,  */
// 			disableDoubleClickZoom: true,
			draggable: false,
			//지도의 배율(zoom level : 1~14) //몇 층에서 보는 느낌
			level: 14
		};
		
		//범위 제한을 없애고 싶다면 외부에 만들거나 window에 추가한다
        window.map = new kakao.maps.Map(container,options);
		
        var map = new kakao.maps.Map(container, options),
        customOverlay = new kakao.maps.CustomOverlay({}),
        infowindow = new kakao.maps.InfoWindow({removable: true});

	    // 지도에 영역데이터를 폴리곤으로 표시합니다 
	    for (var i = 0, len = areas.length; i < len; i++) {
	        displayArea(areas[i]);
	    }
		
	    function displayArea(area){
	    	
	    	//다각형 생성하기
	    	var polygon = new kakao.maps.Polygon({
	            map: map, // 다각형을 표시할 지도 객체
	            path: area.path,
	            strokeWeight: 1, // 선의 두께입니다
	            strokeColor: '#004c80', // 선의 색깔입니다
	            strokeOpacity: 0.7, // 선의 불투명도 입니다 -> 1로 갈수록 진해짐
	            fillColor: '#fff', // 채우기 색깔입니다
	            fillOpacity: 0.4  // 채우기 불투명도 입니다
	        });
	    	
	    	// 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
	        // 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
	        kakao.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
	            polygon.setOptions({fillColor: '#09f'});

	            customOverlay.setContent('<div class="area">' + area.name + '</div>');
	            
	            customOverlay.setPosition(mouseEvent.latLng); 
	            customOverlay.setMap(map);
	        });

	        // 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 커스텀 오버레이의 위치를 변경합니다 
	        kakao.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
	            
	            customOverlay.setPosition(mouseEvent.latLng); 
	        });

	        // 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
	        // 커스텀 오버레이를 지도에서 제거합니다 
	        kakao.maps.event.addListener(polygon, 'mouseout', function() {
	            polygon.setOptions({fillColor: '#fff'});
	            customOverlay.setMap(null);
	        }); 
	    	
	        // 지도 클릭시 해당 지역 게시판으로 이동 
	        kakao.maps.event.addListener(polygon, 'click', function(mouseEvent) {
	            
	        	var correctArea = customOverlay.getContent(); // 오버레이의 내용을 가져옴 가져오면 div가 포함된 내용을 가져옴
	        	var areaElement = document.createElement('div'); //임시 <div> 요소 생성 후
	        	areaElement.innerHTML = correctArea; //HTML 문자열 할당
	        	var areaText = areaElement.textContent || areaElement.innerText; // 텍스트 추출
	        	
	        	if(areaText =='서울'){
	        		window.location.href = "/board/list?weather=전체&area=서울&type=board_title&keyword=";
	            }
	            else if(areaText == '경기'){
	            	window.location.href = "/board/list?weather=전체&area=경기&type=board_title&keyword=";
	            }
	            else if(areaText == '강원'){
	            	window.location.href = "/board/list?weather=전체&area=강원&type=board_title&keyword=";
	            }
	            else if(areaText == '충청'){
	            	window.location.href = "/board/list?weather=전체&area=충청&type=board_title&keyword=";
	            }
	            else if(areaText == '경상'){
	            	window.location.href = "/board/list?weather=전체&area=경상&type=board_title&keyword=";
	            }
	            else if(areaText == '전라'){
	            	window.location.href = "/board/list?weather=전체&area=전라&type=board_title&keyword=";
	            }
	            else{
	            	window.location.href = "/board/list?weather=전체&area=제주&type=board_title&keyword=";
	            }
	        });
	        
	    }
		
	});
</script>


<style>
	.area {
	    position: absolute;
	    background: #fff;
	    border: 1px solid #888;
	    border-radius: 3px;
	    font-size: 12px;
	    top: -5px;
	    left: 15px;
	    padding:2px;
	}
	.text-position{
		position: relative;
		z-index:9999;
		margin-top:100px;
		margin-left:180px;
	}

</style>

<!-- 이거는 가로가 크게 보여줘야 할 것 같아서 1000으로 지정함 -->

<div class="container w-1000">
	<div class="flex-container">
	
		<div class="row" style="width:450px; margin-left:25px;"> 
			<h1>계절 게시판</h1>
			<div class="flex-container">
				<div>
					<span>
						<a class="text-position link" href="/board/list?weather=봄&area=전체&type=board_title&keyword=">봄
							<img style="height:225px; width:225px;" src="/images/weather/spring.jpg">
						</a>
					</span>
				</div>
				<div>
					<span>
						<a class="text-position link" href="/board/list?weather=여름&area=전체&type=board_title&keyword=">여름
							<img style="height:225px; width:225px" src="/images/weather/summer.jpg">
						</a>
					</span>
				</div>
			</div>
			<div class=flex-container>
				<div>
					<span>
						<a class="text-position link" href="/board/list?weather=가을&area=전체&type=board_title&keyword=">가을
							<img style="height:225px; width:225px" src="/images/weather/fall.jpg">
						</a>
					</span>
				</div>
				<div>
					<span>
						<a class="text-position link" href="/board/list?weather=겨울&area=전체&type=board_title&keyword=">겨울
							<img style="height:225px; width:225px" src="/images/weather/winter.jpg">
						</a>
					</span>
				</div>
			</div>
		</div>
		
		<div class="row ms-50" style="width:450px">
			<div class="mb-20">
				<h1>지역 게시판</h1>
			</div>
			<div id="map" style="width:450px;height:450px;"></div>
		</div>

	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>