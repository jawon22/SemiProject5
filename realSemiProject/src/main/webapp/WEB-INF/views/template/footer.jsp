<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
</section>
<style>
.popup {
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 100;
	background-color: rgba(0, 0, 0, 0.6);
	position: fixed;
	z-index: 99999;
}

.popup-wrap {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	border-radius: 10px;
	background-color: white;
	width: 650px;
	height: 610px;
	padding: 20px;
	border: 1px solid #012D5C;
	z-index: 99999;
}

.popupbody {
	font-size: 15px;
	line-height: 2px;
}

.fixed {
	height: 500px
}

 .textbox {
 	line-height: 1; 
 	color:gray; 
 	padding:3px;
	line-height: 1; 
	box-shadow: 0 0 0 1px gray; 
	width:610px; 
	height:500px; 
	overflow-y:scroll;"
 	
 }

</style>
<script>
	$(function() {
		$(".popup-wrap-privacy").hide();
		$(".popup-privacy").hide();
		$(".popup-wrap-use").hide();
		$(".popup-use").hide();

		$(".privacy").click(function() {

			$(".popup-wrap-privacy").show();
			$(".popup-privacy").show();

			$(".close").click(function() {
				$(".popup-wrap-privacy").hide();
				$(".popup-privacy").hide();

			});

		});
		$(".use").click(function() {

			$(".popup-wrap-use").show();
			$(".popup-use").show();

			$(".close").click(function() {
				$(".popup-wrap-use").hide();
				$(".popup-use").hide();

			});

		});

	});
</script>

<hr>
<div class="popup popup-privacy" style="display: none;">
	<div class="popup-wrap popup-wrap-privacy">


		<div class="popupbody popupbody-privacy">

				<div class="row">
					<div class="row mb-20">
					<h1>개인정보처리방침</h1>
					</div>
					
					<div class="left textbox">
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
						    <strong>제7조 개인정보보호 책임자</strong>
							    <p>회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제를 처리하기 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다. 이용자는 아래의 담당부서에 개인정보보호 관련 문의, 불만, 조언이나 기타 사항을 연락해 주시기 바랍니다.</p>
								<p>· 개인정보 보호책임자 박소은</p>
								    <p>tripee.info@gmail.com</a></p>
								    <p>기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.</p>
								    <p><strong>개인정보침해신고센터 (privacy.kisa.or.kr / 국번없이 118)</strong></p>
								    <p><strong>대검찰청 사이버수사과 (www.spo.go.kr / 국번없이 1301)</strong></p>
								    <p><strong>경찰청 사이버안전국 (cyberbureau.police.go.kr / 국번없이 182)</strong></p>	
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

<div class="popup popup-use" style="display: none;">
	<div class="popup-wrap popup-wrap-use">


		<div class="popupbody popupbody-use">

				<div class="row">
					<div class="row mb-20 mt-10">
					<h1>이용약관</h1>
					</div>
					<div class="left textbox">
								    <strong>제1조 (목적)</strong>
					    <p>
					        본 약관은 ㈜트리피(이하 "회사"라 합니다)가 운영하는 사이트(이하 "사이트"라 합니다)를 통해 서비스를 제공함에 있어 회사와 이용자의 이용조건 및 제반 절차, 기타 필요한 사항을 규정함을 목적으로 합니다.
					    </p>
					    <p><strong>본 약관에서 사용하는 용어의 정의는 아래와 같습니다.</strong></p>
					    <p>
					        ① "사이트"라 함은 회사가 서비스를 이용자에게 제공하기 위하여 제작, 운영하는 사이트를 말합니다.
					        ② “이용자”라 함은 사이트가 제공하는 서비스를 이용하는 개인 회원 및 비회원을 말합니다.
					        ④ "서비스"라 함은 사이트가 이용자에게 제공하는 모든 서비스를 말합니다. 구체적으로는 회사가 DB화하여 각각의 목적에 맞게 분류 가공, 집계하여 제공하는 모든 서비스를 말합니다. 회사가 제공하는 서비스는 유형에 따라 무료 제공됩니다.
					        ⑤ "회원"이라 함은 본 서비스를 이용하기 위하여 본 약관에 동의하고 회사와 서비스 이용계약을 체결하여 회원ID를 부여받은 이용자를 말합니다.
					        ⑥ “비회원”이라 함은 회사와 서비스 이용계약을 체결하지 않은 채 사이트 등을 통하여 회사가 제공하는 서비스를 이용하는 이용자를 말합니다.
					        ⑦ "서비스 이용계약"이라 함은 회사가 개인회원을 위해 제공하는 서비스를 계속적으로 이용하기 위하여 회사와 이용자 사이에 체결되는 계약을 말합니다.
					        ⑧ “ID"라 함은 개인회원의 식별 및 서비스 이용을 위하여 개인회원이 선정하거나 회사가 부여하는 문자와 숫자의 조합을 말합니다.
					        ⑨ "비밀번호"라 함은 회사의 서비스를 이용하려는 사람이 개인회원ID를 부여 받은 자와 동일인임을 확인하고 회원의 권익을 보호하기 위하여 회원이 선정하거나 회사가 부여하는 문자와 숫자의 조합을 말합니다.
					        ⑩ “계정”이라 함은 회원의 개인정보, 이력서 등을 등록, 관리할 수 있도록 회사가 회원에게 제공하는 공간을 말합니다.
					    </p>
					    <strong>제2조 (약관의 명시와 개정)</strong>
					    <p>
					        ① 회사는 본 약관의 내용과 상호, 영업소 소재지, 사업자등록번호, 연락처 등을 이용자가 알 수 있도록 초기 화면에 게시하거나 기타의 방법으로 이용자에게 공지합니다. 약관의 내용은 이용자가 사이트 등의 링크를 통한 연결화면을 통하여 볼 수 있도록 할 수 있습니다.
					        ② 회사는 약관의 규제 등에 관한 법률, 전기통신기본법, 전기통신사업법, 정보통신망 이용 촉진 및 정보보호 등에 관한 법률 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.
					        ③ 회사가 약관을 개정할 경우에는 개정 약관 적용일 최소 7일전(약관의 변경이 개인회원에게 불리하거나 기업회원의 권리•의무의 중요한 변경의 경우에는 30일전)부터 웹사이트 공지사항 또는 이메일을 통해 사전 공지합니다.
					        ④ 회원은 변경된 약관에 대해 거부할 권리가 있으며, 변경된 약관이 공지된 지 15일 이내에 변경 약관에 대한 거부 의사를 표시할 수 있습니다. 만약, 회원이 거부 의사를 표시하지 않고 서비스를 계속 이용하는 경우, 회사는 회원이 변경 약관 적용에 동의하는 것으로 봅니다.
					        ⑤ 회원이 제4항에 따라 변경 약관 적용을 거부할 의사를 표시한 경우, 회사는 회원에게 15일의 기간을 정하여 사전 통지 후 해당 개인회원과의 서비스 이용계약 또는/및 별도로 체결된 계약을 해지할 수 있습니다.
					    </p>
					
					    <strong>제3조 (약관 외 준칙)</strong>
					    <p>
					        ① 약관에서 규정하지 않은 사항에 관해서는 약관의 규제 등에 관한 법률, 정보통신망 이용 촉진 및 정보보호 등에 관한 법률, 개인정보 보호법, 전기통신기본법, 전기통신사업법 등의 관계법령에 따라 규율됩니다.
					        ② 회원이 회사와 개별 계약을 체결하여 서비스를 이용하는 경우, 회원의 서비스 이용과 관련된 권리 의무는 순차적으로 개별 계약, 개별 서비스 이용약관, 본 약관에서 정한 내용에 따라 규율됩니다.
					    </p>
					
					    <strong>제4조 (회원에 대한 고지, 통지 및 공지)</strong>
					    <p>
					        회사는 회원에게 서비스 정책, 이용약관, 개인정보 처리방침 등 일체의 약관, 서비스 이용 관련 일정한 사항이나 정보를 알리거나 안내할 목적으로 개인회원에게 각종 고지나 통지를 이행할 수 있으며, 사이트 등의 게시판이나 화면에 일정한 사항을 게시하여 공지함으로써 각 개인회원에 대한 각종 고지나 통지를 갈음할 수 있습니다. 이와 관련하여 고지∙통지 수단, 공지 방법, 공지 기간 등의 상세한 내용은 개인정보 처리방침을 확인 바랍니다.
					    </p>
					    <strong>제5조 (서비스 이용계약의 성립)</strong>
					<p>
					    ① 회사의 서비스 이용계약(이하 "이용계약")은 서비스를 이용하고자 하는 자가 본 서비스 약관과 개인정보처리방침을 읽고 약관에 동의한 것으로 간주합니다.
					</p>
					
					<strong>제10조 (게시물 등 작성에 따른 책임과 회사의 정보 수정•삭제 권한)</strong>
					<p>
					    ① 게시물 등은 회원이 사이트에 등록한 게시물을 말합니다.
					    ② 모든 게시물 등의 작성 및 관리는 당해 게시물 등을 작성한 이용자가 하는 것이 원칙입니다. 이용자의 사정상 위탁 또는 대행관리를 하더라도 게시물 등 작성의 책임은 이용자에게 있고, 주기적으로 자신의 자료를 확인하여 항상 정확성을 유지하도록 관리해야 합니다.
					    ③ 회사는 회원이 작성한 콘텐츠가 다음 각 호에 해당한다고 판단되는 경우, 이를 삭제하거나 게시를 거부할 수 있습니다.
					</p>
					 <ul style="list-style-type: circle; margin-left: 20px;">
					    <li>광고/음란성 글</li>
					    <li>욕설/반말/부적절한 언어</li>
					    <li>회원 분란 유도</li>
					    <li>회원 비방</li>
					    <li>지나친 정치/종교 논쟁</li>
					    <li>도배성 글</li>
					</ul>
					<strong>제16조 (회원의 개인정보보호)</strong>
					<p>
					    ① 회사는 이용자의 개인정보 수집 시 서비스 제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다.
					    ② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.
					</p>
					<ul style="list-style-type: circle; margin-left: 20px;">
					    <li>홈페이지 회원가입 및 관리와 관련한 개인정보는 수집.이용에 관한 동의일로부터 3년까지 위 이용목적을 위하여여 보유 및 이용됩니다. 하고 보유근거 : 개인정보처리방침</li>
					    <li>관련법령 : 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년</li>
					</ul>
					<p>
					    (주)트리피
					</p>
					
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
		<span class="mb-30 privacy">개인정보처리방침</span> <span class="use">이용약관</span>
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