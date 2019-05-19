<%@include file="_master.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Shop</title>
		<style>
			.center {
				margin-top: 5%;
				margin-left: auto;
	  			margin-right: auto;
			}
			.center-block {
				display: inline-block;
				text-align:center;
				margin-right: auto;
				margin-left: auto;
			}
		</style>
	</head>
	<body>
	<div class="jumbotron text-center center" style="background:transparent url('<c:url value="/resources/images/backgrounds/back4.jpg" />') no-repeat center center /cover">
		<div class="container">
			<form:form id="categoryForm" method="POST" action="categories" modelAttribute="searchBean">	
				<div align="center">	
					<p><form:label path="parameter" name="parameter" id="parameter" required="required"> Select Category </form:label><br/>
					
					<form:radiobutton path = "parameter" value = "electronics" label = "" checked="checked" />
					<img src='<c:url value="/resources/images/electronics.jpg"
							 />' width="800" height="200" alt="NO IMAGE FOUND"
							 title="Electronics and Accessories"><br/><br/>
							 
	        		<form:radiobutton path = "parameter" value = "food" label = "" />
	        		<img src='<c:url value="/resources/images/food.jpg"
							 />' width="800" height="200" alt="NO IMAGE FOUND"
							 title="Electronics and Accessories"><br/><br/>
							 
	        		<form:radiobutton path = "parameter" value = "appliances" label = "" />
	        		<img src='<c:url value="/resources/images/appliances.jpg"
							 />' width="800" height="200" alt="NO IMAGE FOUND"
							 title="Electronics and Accessories"><br/><br/>
							 
	        		<form:radiobutton path = "parameter" value = "furniture" label = "" />
	        		<img src='<c:url value="/resources/images/furniture.jpg"
							 />' width="800" height="200" alt="NO IMAGE FOUND"
							 title="Electronics and Accessories"><br/><br/>
							 
	        		<form:radiobutton path = "parameter" value = "books" label = "" />
	        		<img src='<c:url value="/resources/images/books.jpg"
							 />' width="800" height="200" alt="NO IMAGE FOUND"
							 title="Electronics and Accessories"></p>
				</div>
				<br/>
				<div align="center">
					<input type="Submit" class="btn btn-primary btn-lg" value="Search" onClick="return validate();">
				</div>
			</form:form>
			</div>
		</div>
	</body>
</html>