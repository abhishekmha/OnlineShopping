<%@include file="_master.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Log In</title>
		<style>
			.center {
			margin-top: 2.5%;
			width: 50%;
			margin-left: auto;
  			margin-right: auto;
			}
			.hidden {
			display: block;
			}
		</style>
		<script>
			function validate() {
			    var f=document.getElementById("loginForm");
			    var error=document.getElementById("error");
			    if(validateEmail(f) && validatePassword(f)) {
			    	error.classList.add("hidden");
			    	return true;
			    }
			    else
			    	return false;
			}
			
			
			function  validatePassword(form) {
			    var error=document.getElementById("error");
				var errormsg=document.getElementById("errormsg");
				var password=form["password"].value;
			    
			    if( password==null || password=="") {
			    	error.classList.remove("hidden");
			        errormsg.innerHTML="Give Password";
			        return false;
			    }
			    else if(password.length < 5) {
			    	error.classList.remove("hidden");
			        errormsg.innerHTML="Password has to be atleast 5 chars";
			        return false;
			    }
			    else {
					errormsg.innerHTML=" ";
					return true;
				}
			}

			function validateEmail(form) {
				var error=document.getElementById("error");
				var errormsg=document.getElementById("errormsg");
				var email=form["email"].value;
				
				var regx = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
				if( email==null || email=="") {
					error.classList.remove("hidden");
					errormsg.innerHTML="Input Your Email";
					return false;
				}
				else if(!email.match(regx)) {
					error.classList.remove("hidden");
					errormsg.innerHTML="Invalid Email";
					return false;
				}
				else {
					errormsg.innerHTML=" ";
					return true;
				}
			}
			
			function errmsg() {
				var msg = "${requestScope.msg}";
				if (msg!=null && msg.length > 5) {
					var f=document.getElementById("loginForm");
					var error=document.getElementById("error");
					var errormsg=document.getElementById("errormsg");
					error.classList.remove("hidden");
					errormsg.innerHTML=msg;
				}
			}
			window.onload = errmsg;
		</script>
	</head>
	<body>
		<div class="jumbotron text-center center" style="background:transparent url('<c:url value="/resources/images/backgrounds/back4.jpg" />') no-repeat center center /cover">
			<div class="container">
				<form:form id="loginForm" method="POST" action="login" modelAttribute="loginBean" onsubmit="return validate()">	
					<h1 align="center"> Online Shop </h1>
					<br/>
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-5" align="right">
							<p><form:label path="email"> Email ID </form:label></p>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-7" align="left">
          					<p><form:input id="email" name="email" path="email" required="required" /></p>
						</div>
					</div>
					<br/>
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-5" align="right">
							<p><form:label path="password"> Password </form:label></p>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-7" align="left">
          					<p><form:password id="password" name="password" path="password" required="required" /></p>
						</div>
					</div>
					<br/>
					<div align="center">
						<div id="error" class="alert alert-danger alert-dismissible hidden" role="alert">
        					<button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
        					<div id="errormsg"></div>
      					</div>
      				</div>
      				<br/>
					<div align="center">
						<input type="Submit" class="btn btn-primary btn-lg" value="Log In" onClick="return validate();">
					</div>
					
					<br/><br/>
					
					<div class="row">
						<div class="col-md-8 col-sm-8 col-xs-8" align="right">
							<p> Don't Have A Account Yet? </p>
						</div>
						<div class="col-md-4 col-sm-4 col-xs-4" align="left">
          					<p><a href="register" class="btn btn-info" role="button">Join Now!</a></p>
          				</div>
					</div>
				</form:form>
			</div>
		</div>
	</body>
</html>