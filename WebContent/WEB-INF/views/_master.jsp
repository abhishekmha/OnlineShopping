<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- Bootstrap -->
		<link href="<c:url value="/resources/css/bootstrap.css" />" rel="stylesheet">
		<style>
		.navbar	{
		    position: absolute;
		    top: 0; right: 0; left: 0;
			border-radius: 0;
		}
		
		.well-sm {
			margin-bottom: 0;
		}
		
		.dropdown:hover .dropdown-menu {
			display: block;
		}
		
		.footer {
			position: fixed;
			bottom: 0;
			width: 100%;
			background-color: lightgrey;
			color: black;
			text-align: center;
		}
		
		body {
			padding:10px;
  			padding-bottom:60px;   /* Height of the footer */
			background: url("<c:url value="/resources/images/backgrounds/background.jpg" />") no-repeat center center fixed;
   			-webkit-background-size: cover;
			-moz-background-size: cover;
			-o-background-size: cover;
			background-size: cover;
		}
		</style>
	</head>

	<body>
		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
						aria-expanded="false">
						<span class="sr-only">Toggle navigation</span>
					</button>
					<a class="navbar-brand"><font color="blue"> Online Shopping </font></a>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li class="active">
							<a href="${pageContext.request.contextPath}/"> Home
							<span class="sr-only">(current)</span></a>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
							aria-haspopup="true" aria-expanded="false"> Menu <span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="allProducts"> All Products </a></li>
									<li><a href="categories"> Select Category </a></li>
									
									<c:set var="type" value="${loggedInUserType}"/>
									<c:if test='${type eq "vendor"}'>
										<li role="separator" class="divider"></li>
										<li><a href="myShop"> Your Products </a></li>
										<li><a href="addProduct"> Add Product </a></li>
									</c:if>
								</ul>
						</li>
					</ul>
					
					<form class="navbar-form navbar-left"  action="search" method="get">
						<div class="form-group text-center">
							<input type="text" class="form-control" size="40" placeholder="Search">
						</div>
						<button type="submit" class="btn btn-default">Search</button>
					</form>
					<ul class="nav navbar-nav navbar-right">
						<c:set var="name" value="${loggedInUsername}"/>
						<c:choose>
  							<c:when test='${name eq null}'>
								<li><a href="login"> Login </a></li>
								<li><a href="register"> Register </a></li>
							</c:when>
							<c:otherwise>
							<li><a href="viewCart"><span class="glyphicon glyphicon-shopping-cart">Cart <span class="badge">${cartTotal}</span> </span></a></li>
							<li><a href="profile"><span class="glyphicon glyphicon-user"> Hi, ${name}</span></a></li>
							<li><a href="logout">Logout</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>

		<!-- Footer -->
		<div class="footer well-sm text-center text-capitalize navbar-fixed-bottom">
			<p>
				© 2018 Designed by : grp31 | SpringMVC + Hibernate + JSP + Bootstrap
				---- <a href="about" class="btn btn-info" role="button"><b>About Us</b></a>
			</p>
		</div>

		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="<c:url value="/resources/js/jquery-3.3.1.js" />"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="<c:url value="/resources/js/bootstrap.js" />"></script>
	</body>
</html>