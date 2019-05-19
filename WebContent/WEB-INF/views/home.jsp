<%@include file="_master.jsp"  %>
<!DOCTYPE html>
<html>
	<head>
	<title>Home</title>
	<style>
		.center {
			margin-left: auto;
			margin-right: auto;
		}
		.screenFiller {
		    right: 0; bottom: 0; left: 0;
		    border: none;
		}
	</style>
	</head>
	<body>
		<div class="jumbotron text-center center screenFiller" style="background:transparent url('<c:url value="/resources/images/backgrounds/back1.jpg" />') no-repeat center center /cover">
			<div class="container">
				<h2><button class="btn btn-default btn-lg" disabled="disabled">Popular Products</button></h2>
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
						<li data-target="#myCarousel" data-slide-to="3"></li>
						<li data-target="#myCarousel" data-slide-to="4"></li>
					</ol>
					
					<!-- Wrapper for slides -->
					<div class="carousel-inner" align="center">
						<div class="item active">
							<img src="<c:url value="/resources/images/electronics.jpg" />" width="800" height="200" alt="NO IMAGE FOUND" title="Electronics and Accessories">
						</div>
					
						<div class="item">
							<img src="<c:url value="/resources/images/appliances.jpg" />" width="800" height="200" alt="NO IMAGE FOUND" title="Household Appliances">
						</div>
					
						<div class="item">
							<img src="<c:url value="/resources/images/books.jpg" />" width="800" height="200" alt="NO IMAGE FOUND" title="Books">
						</div>
						
						<div class="item">
							<img src="<c:url value="/resources/images/furniture.jpg" />" width="800" height="200" alt="NO IMAGE FOUND" title="Home Furniture">
						</div>
						
						<div class="item">
							<img src="<c:url value="/resources/images/food.jpg" />" width="800" height="200" alt="NO IMAGE FOUND" title="Food Items">
						</div>
					</div>
					
					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="right carousel-control" href="#myCarousel" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</div>
	</body>
</html>