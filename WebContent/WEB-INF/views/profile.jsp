<%@include file="_master.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Success</title>
		<style>
			.center {			
				margin-top: 2.5%;
				width: 60%;
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
		<div class="container">
			<div class="jumbotron center" align="center" style="background:transparent url('<c:url value="/resources/images/backgrounds/back4.jpg" />') no-repeat center center /cover">
			<h2 align="center"><b> User Details </b></h2>
			<br/>
		        <div class="row">
		            <div class="col-md-6 col-sm-6 col-xs-6" align="center">
		                <p>
		                    User Id<br>
		                    <input type="text" class="center-block" value='${requestScope.id}' readonly><br/>
		                </p>
		            </div>
		            <div class="col-md-6 col-sm-6 col-xs-6" align="right">
		                <p>
		                   <a href="editProfile" class="btn btn-primary btn-lg" role="button"> Edit Profile </a>
		                </p>
		            </div>
		        </div>
		        <br/>
		        <div class="row">
		            <div class="col-md-6 col-sm-6 col-xs-6" align="center">
		                <h3 align="center"> Personal Details </h3><br/>
		                <p>
							Name<br/>
		                    <input type="text" class="center-block" value='${requestScope.username}' readonly><br/>
		                </p>
		            </div>
		            <div class="col-md-6 col-sm-6 col-xs-6" align="center">
		            	<h3 align="center"> Account Details </h3><br/>
		                <p>
		                    Email<br>
		                    <input type="text" class="center-block" value='${requestScope.email}' readonly><br/>
		                </p>
		            </div>
				</div>
				<br/>
				<div class="row">
					<div class="col-md-6 col-sm-6 col-xs-6" align="center">
						<p>
							Age<br>
							<input type="text" class="center-block" value='${requestScope.age}' readonly><br/>
						</p>
					</div>
					<div class="col-md-6 col-sm-6 col-xs-6" align="center">
						<p>
							AccountType<br>
							<input type="text" class="center-block" value='${requestScope.type}' readonly><br/>
						</p>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>