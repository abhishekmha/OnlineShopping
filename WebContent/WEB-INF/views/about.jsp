<%@include file="_master.jsp"%>
<!DOCTYPE html>
<html>
	<head>
	<title>About Us</title>
		<script>
			function toggleDetails() {
				var about = document.getElementById("about");
				var toggleButton = document.getElementById("toggleButton");
		
				if (about.style.visibility == 'hidden') {
					about.style.visibility = 'visible';
					toggleButton.innerHTML = "Show Less";
				} else {
					about.style.visibility = 'hidden';
					toggleButton.innerHTML = "More Details";
				}
			}
		</script>
	</head>
	
	<body>
		<div class="jumbotron text-center">
			<div class="container">
				<h1>Online Shopping</h1>
				<p>By PG-DAC project group 31</p>
				<p>Online Shopping website hosted on apache tomcat v8.5.32</p>
				<button class="btn btn-primary" onclick="toggleDetails()"
					id="toggleButton">More Details</button>
			</div>
		</div>
	
		<div class="container" id="about" style="visibility: hidden;">
			<p class="text-center lead">Designed By</p>
			<table class="table table-striped table-hover table-condensed">
				<tr>
					<td>180240120203</td>
					<td>Sushen</td>
					<td>Kaw</td>
				</tr>
				<tr>
					<td>180240120148</td>
					<td>Proloy</td>
					<td>Ghosh</td>
				</tr>
				<tr>
					<td>180240120194</td>
					<td>Siddartha</td>
					<td>Sagun</td>
				</tr>
				<tr>
					<td>180240120006</td>
					<td>Abhishek</td>
					<td>Gupta</td>
				</tr>
				<tr>
					<td>180240120152</td>
					<td>Rahul</td>
					<td>Agrawal</td>
				</tr>
			</table>
		</div>
	
	</body>
</html>