<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
</section>
<style>
.popupuse {
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 100;
	background-color: rgba(0, 0, 0, 0.6);
	position: fixed;
	z-index: 99999;
}

.popup-wrapuse {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	border-radius: 10px;
	background-color: white;
	width: 700px;
	height: 610px;
	padding: 20px;
	border: 1px solid #012D5C;
	z-index: 99999;
}

.popupbodyuse {
	font-size: 15px;
	line-height: 2px;
}

.fixed {
	height: 500px
}
</style>
<script>
	$(function() {
		$(".popup-wrapuse").hide();
		$(".popupuse").hide();

		$(".use").click(function() {

			$(".popup-wrapuse").show();
			$(".popupuse").show();

			$(".close").click(function() {
				$(".popup-wrapuse").hide();
				$(".popupuse").hide();

			});

		});

	});
</script>

<hr>
<div class="popupuse" style="display: none;">
	<div class="popup-wrapuse">


		<div class="popupbodyuse">

				<div class="row">
					<div class="row mb-20">
					<h1>개인정보처리방침</h1>
					</div>
					
					<div class="left" style="line-height: 1; box-shadow: 0 0 0 1px gray; color:gray; padding:3px;">
						<p>트리피(이하 ‘회사’라 함)는 이용자의 개인정보보호를 매우 중요시하며, ‘개인정보보호법’, ‘정보통신망
							이용촉진 및 정보보호 등에 관한 법률’ 등 개인정보와 관련한 법령상의 개인정보보호 규정을 준수하고 있습니다. 회사는
							아래와 같이 개인정보처리방침을 통해 이용자가 회사에 제공한 개인정보가 어떤 용도와 방식으로 이용되고 있고,
							개인정보보호를 위해 어떤 조치를 취하는지 알려드립니다.</p>
						<p>
							<strong style="font-weight: bold; color: #190707;">제1조 수집하는 개인정보의 항목 및 방법</strong>
						</p>
						<p>회사는 원활한 서비스의 제공을 위해 회원가입시 아래와 같은 최소한의 개인정보를 수집하고 있습니다.</p>
						<p>1. 수집하는 개인정보의 항목</p>
						<p>1) 회원 가입 과정에서 아래 정보가 수집됩니다.</p>
						<p>· (필수항목) 아이디, 비밀번호, 이메일주소</p>
						<p>
							<strong style="font-weight: bold; color: #190707;">제2조 개인정보의 수집 및 이용목적</strong>
						</p>
						<p>개인정보 관련 법령 및 본 방침에 따라 회사는 이용자의 개인정보를 수집할 수 있으며 수집된 개인정보는
							개인의 동의가 있는 경우에 한해 제3자에게 제공될 수 있습니다. 단, 법령의 규정 등에 의해 적법하게 강제되는 경우
							회사는 수집한 이용자의 개인정보를 사전에 개인의 동의없이 제3자에게 제공할 수도 있습니다.</p>
						<p>
							<strong style="font-weight: bold; color: #190707;">제3조 개인정보의 제3자 제공</strong>
						</p>
						<p>회사는 원칙적으로 정보주체의 개인정보를 제2조(개인정보의 수집 및 이용목적)에서 명시한 범위 내에서만
							처리하며, 정보주체의 사전 동의 없이 본래의 범위를 초과하여 처리하거나 제3자에게 제공하지 않습니다. 다만, 다른
							법률에 특별한 규정이 있는 경우 또는 범죄의 수사와 같이 개인정보보호법 제18조 제1항에 해당하는 경우는 예외로
							처리됩니다.</p>
						<p>
							<strong style="font-weight: bold; color: #190707;">제4조 개인정보의 처리 및 보유기간</strong>
						</p>
						<p>회사는 원칙적으로, 개인정보 수집 및 이용목적이 달성된 후 또는 회원이 탈퇴한 경우에는 해당 정보를
							지체없이 파기합니다.</p>

						<p>
							<strong style="font-weight: bold; color: #190707;">제5조 이용자의 권리·의무 및 행사방법</strong>
						</p>
						<p>이용자는 회사에 대해 언제든지 이용자 본인의 개인정보 열람 요구, 오류등에 대한 정정 요구, 삭제요구,
							처리정지 요구 등 개인정보 보호 관련 권리를 행사할 수 있습니다. 이용자의 개인정보 조회, 수정을 위해서는
							“개인정보변경”(또는 ‘회원정보수정’ 등)을, 가입해지(동의철회)를 위해서는 “회원탈퇴”를 클릭하여 직접 열람, 정정
							또는 탈퇴가 가능합니다.</p>
						<p>
							<strong style="font-weight: bold; color: #190707;">제6조 처리하는 개인정보의 파기</strong>
						</p>
						<p>회사는 개인정보 수집 및 이용목적이 달성되었거나 보유 및 이용기간이 경과된 후에는 해당 정보를 지체없이
							파기합니다. 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제하고, 그 밖에
							기록물, 인쇄물, 서면 등은 분쇄하거나 소각하여 파기합니다.</p>

				</div>
		</div>
		<div class="flex-container auto-width">
			<div class="col-3 "></div>
			<div class="col-3 ">
				<button class="btn close w-100">닫기</button>
			</div>
			<div class="col-3 "></div>
		</div>
	</div>

</div>
</div>

<footer class="flex-container">
	<div class="logo" style="margin-left: 150px;">
		<a class="link" href="/"><img width=14% src="/images/logo.png"></a>
		<span class="mb-30 use">개인정보처리방침</span> <span>이용약관</span>
	</div>
</footer>
<div class="left" style="margin-left: 150px;">
	상호명 : (주)트리피 
</div>
<div class="left" style="margin-left: 150px;">회사 주소 : 서울특별시 영등포구
	선유동 2로 57 구관 19층 C강의장</div>
</main>
</body>
</html>