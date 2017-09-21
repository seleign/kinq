<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    <%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<!-- Basic Page Needs -->
	<meta charset="utf-8">
	<title>Ask me – Responsive Questions and Answers Template</title>
	<meta name="description" content="Ask me Responsive Questions and Answers Template">
	<meta name="author" content="vbegy">
	
	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
	<!-- Main Style -->
	<link rel="stylesheet" href="./resources/css/style.css"> 
	
	<!-- Skins -->
	<link rel="stylesheet" href="./resources/css/gray.css">
	
	<!-- Responsive Style -->
	<link rel="stylesheet" href="./resources/css/responsive.css">
	
	<!-- Favicons -->
	<link rel="shortcut icon" href="./resources/images/favicon_qs.png">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript">
	

	var startpage = 0;
	var endpage = 10;
	var urgentStartpage = 0;
	var urgentEndpage = 10;
	var progressStartpage = 0;
	var progressEndpage = 10;
	
	function userlist(){
		$.ajax({
			url: 'getQuestionPage',
			method: 'get',
			data: {startpage:startpage, endpage:endpage},
			success: function(result){
				var html = '';
				$.each(result, function(index, element){
					if(element.timeCheck == -1){
						html +='<article class="question question-type-normal" id="q_urgent">';
					}else{
						html +='<article class="question question-type-normal">';
					}
					html += '<h2><a href="question_view?questionNum='+element.questionNum+'">'+element.title+'</a></h2>';
					html += '<a class="question-report" href="javascript:void(0)" onclick="location.href=\'reportPage?reportedQNum='+element.questionNum+'\'">Report</a>';
					html += '<div class="question-inner"><div class="clearfix"></div>';
					html += '<p class="question-desc">'+element.questionContent+'</p>';
					html += '<div class="question-details">';
					if(element.qstatus == "solved"){
						html += '<span class="question-answered question-answered-done"><i class="icon-ok"></i>solved</span>';
					}else{
						html += '<span class="question-answered"><i class="icon-ok"></i>in progress</span>';
					}
					html += '<span class="question-favorite"><i class="icon-star"></i>'+element.score+'</span></div>';
					html += '<span class="question-date"><i class="icon-time"></i>'+element.limit+'</span>';
					html += '<span class="question-comment"><a href="#"><i class="icon-comment"></i>'+element.allReply+'</a></span>';
					html += '<span class="question-view"><i class="icon-user"></i>'+element.hit+'</span>';
					html += '<div class="clearfix"></div>';
					html += '</div></article>';
				});
					$('#QuestionList_tap').append(html);
			}
		});
		startpage = startpage+10;
		endpage = endpage+10;
	}
	
	function urgentUserlist(){
		$.ajax({
			url: 'getQuestionPage',
			method: 'get',
			data: {startpage:urgentStartpage, endpage:urgentEndpage},
			success: function(result){
				var html = '';
				$.each(result, function(index, element){
					if(element.timeLimit){
						if(element.timeCheck == -1){
							html +='<article class="question question-type-normal" id="q_urgent">';
						}else{
							html +='<article class="question question-type-normal">';
						}
					html += '<h2><a href="question_view?questionNum='+element.questionNum+'">'+element.title+'</a></h2>';
					html += '<a class="question-report" href="javascript:void(0)" onclick="location.href=\'reportPage?reportedQNum='+element.questionNum+'\'">Report</a>';
					html += '<div class="question-inner"><div class="clearfix"></div>';
					html += '<p class="question-desc">'+element.questionContent+'</p>';
					html += '<div class="question-details">';
					if(element.qstatus == "solved"){
						html += '<span class="question-answered question-answered-done"><i class="icon-ok"></i>solved</span>';
					}else{
						html += '<span class="question-answered"><i class="icon-ok"></i>in progress</span>';
					}
					html += '<span class="question-favorite"><i class="icon-star"></i>'+element.score+'</span></div>';
					html += '<span class="question-date"><i class="icon-time"></i>'+element.Limit+'</span>';
					html += '<span class="question-comment"><a href="#"><i class="icon-comment"></i>'+element.AllReply+'</a></span>';
					html += '<span class="question-view"><i class="icon-user"></i>'+element.hit+'</span>';
					html += '<div class="clearfix"></div>';
					html += '</div></article>';
					}
				});
					$('#QuestionList_tap_urgent').append(html);
			}
		});
		urgentStartpage = urgentStartpage+10;
		urgentEndpage = urgentEndpage+10;
	}
	
	function progressUserlist(){
		$.ajax({
			url: 'getQuestionPage',
			method: 'get',
			data: {startpage:progressStartpage, endpage:progressEndpage},
			success: function(result){
				var html = '';
				$.each(result, function(index, element){
					if(element.qstatus == "in progress"){
						if(element.timeCheck == -1){
							html +='<article class="question question-type-normal" id="q_urgent">';
						}else{
							html +='<article class="question question-type-normal">';
						}
					html += '<h2><a href="question_view?questionNum='+element.questionNum+'">'+element.title+'</a></h2>';
					html += '<a class="question-report" href="javascript:void(0)" onclick="location.href=\'reportPage?reportedQNum='+element.questionNum+'\'">Report</a>';
					html += '<div class="question-inner"><div class="clearfix"></div>';
					html += '<p class="question-desc">'+element.questionContent+'</p>';
					html += '<div class="question-details">';
					html += '<span class="question-answered"><i class="icon-ok"></i>in progress</span>';
					html += '<span class="question-favorite"><i class="icon-star"></i>'+element.score+'</span></div>';
					html += '<span class="question-date"><i class="icon-time"></i>'+element.Limit+'</span>';
					html += '<span class="question-comment"><a href="#"><i class="icon-comment"></i>'+element.AllReply+'</a></span>';
					html += '<span class="question-view"><i class="icon-user"></i>'+element.hit+'</span>';
					html += '<div class="clearfix"></div>';
					html += '</div></article>';
					}
				});
					$('#QuestionList_tap_progress').append(html);
			}
		});
		progressStartpage = progressStartpage+10;
		progressEndpage = progressEndpage+10;
	}
	
	$(function(){

		userlist();
		urgentUserlist();
		progressUserlist();
	});
	</script>
  
</head>
<body>
<jsp:include page="header.jsp" flush="false" />

	<div class="section-warp ask-me">
		<div class="container clearfix">
			<div class="box_icon box_warp box_no_border box_no_background" box_border="transparent" box_background="transparent" box_color="#FFF">
				<div class="row">
					<div class="col-md-3">
						<h2>なんでも質問して!</h2>
						<p>一日にも、多くの情報を接して数多くの質問を接するあなたに最も最適化されたサイト!今、早速質問して返事して知識を共有してください</p>
						<div class="clearfix"></div>
						<a class="color button dark_button medium" href="#">About Us</a>
						<a class="color button dark_button medium" href="#">Join Now</a>
					</div>
					<div class="col-md-9">
						<form class="form-style form-style-2">
							<p>
								<textarea rows="4" id="question_title" onfocus="if(this.value=='今,あなたが一番知りたいことは何ですか?')this.value='';" onblur="if(this.value=='')this.value='今,あなたが一番知りたいことは何ですか?';">今あなたが一番知りたいことは何ですか?</textarea>
								<i class="icon-pencil"></i>
								<span class="color button small publish-question">質問</span>
							</p>
						</form>
					</div>
				</div><!-- End row -->
			</div><!-- End box_icon -->
		</div><!-- End container -->
	</div><!-- End section-warp -->
	
	<section class="container main-content">
		<div class="row">
			<div class="col-md-9">
				
				<div class="tabs-warp question-tab">
		            <ul class="tabs">
		                <li class="tab"><a href="#" class="current">Recent Questions</a></li>
		                <li class="tab"><a href="#">緊急</a></li>
		                <li class="tab"><a href="#">in progress</a></li>
		            </ul>
		            <div class="tab-inner-warp">
						<div class="tab-inner" id="QuestionList_tap">
					    </div>
							<button class="button large gray-button" id="QuestionList_button" onclick="javascript:userlist()"><i class="icon-refresh"></i>Load More Questions</button>
					</div>
					<div class="tab-inner-warp">
						<div class="tab-inner" id="QuestionList_tap_urgent">
					    </div>
					    <button class="button large gray-button" id="QuestionList_button" onclick="javascript:urgentUserlist()"><i class="icon-refresh"></i>Load More Questions</button>
					</div>
					<div class="tab-inner-warp">
						<div class="tab-inner" id="QuestionList_tap_progress">
					    </div>
					    <button class="button large gray-button" id="QuestionList_button" onclick="javascript:progressUserlist()"><i class="icon-refresh"></i>Load More Questions</button>
					</div>
		        </div><!-- End page-content -->
			</div><!-- End main -->
			<jsp:include page="aside.jsp" flush="false" />
		</div><!-- End row -->
	</section><!-- End container -->
	<jsp:include page="footer.jsp" flush="false" />

</div><!-- End wrap -->

<div class="go-up"><i class="icon-chevron-up"></i></div>

<!-- js -->
<script src="./resources/js/jquery.min.js"></script>
<script src="./resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="./resources/js/jquery.easing.1.3.min.js"></script>
<script src="./resources/js/html5.js"></script>
<script src="./resources/js/twitter/jquery.tweet.js"></script> 
<script src="./resources/js/jflickrfeed.min.js"></script>
<script src="./resources/js/jquery.inview.min.js"></script>
<script src="./resources/js/jquery.tipsy.js"></script>
<script src="./resources/js/tabs.js"></script>
<script src="./resources/js/jquery.flexslider.js"></script>
<script src="./resources/js/jquery.prettyPhoto.js"></script>
<script src="./resources/js/jquery.carouFredSel-6.2.1-packed.js"></script>
<script src="./resources/js/jquery.scrollTo.js"></script>
<script src="./resources/js/jquery.nav.js"></script>
<script src="./resources/js/tags.js"></script>
<script src="./resources/js/jquery.bxslider.min.js"></script>
<script src="./resources/js/custom.js"></script>
<!-- End js -->

</body>
</html>