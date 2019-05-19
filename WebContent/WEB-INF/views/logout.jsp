<%@include file="_master.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Logout</title>
		<style>
			.center {
				margin-top: 10%;
				width: 50%;
				margin-left: auto;
	  			margin-right: auto;
			}
		</style>
	</head>
	
	<body>
		<div class="jumbotron text-center center" style="background:transparent url('<c:url value="/resources/images/backgrounds/back4.jpg" />') no-repeat center center /cover">
			<div class="container">
				<h2 class="center-text">Logout Successful</h2>
				<p class="center-text"><a href="${pageContext.request.contextPath}/"> click here to go back to the homepage </a></p>
			</div>
		</div>
	</body>
</html>