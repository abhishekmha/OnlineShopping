<%@include file="_master.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>New User</title>
		<style>
			.center {
			width: 70%;
			margin-left: auto;
  			margin-right: auto;
			}
			.hidden {
			display: block;
			}
		</style>
		<script>
			function validate(){
			    var f=document.getElementById("registerForm");
			    var error=document.getElementById("error");
			    if(validateEmail(f) && validatePassword(f) && validateUsername(f) && validateAge(f))
			    {
			    	error.classList.add("hidden");
			    	return true;
			    }
			    else
			    	return false;
			}
			
			
			function  validatePassword(form){
			    var error=document.getElementById("error");
				var errormsg=document.getElementById("errormsg");
				var password=form["password"].value;
				var password2=form["password2"].value;			    
			    
			    if( password==null || password==""){
			    	error.classList.remove("hidden");
			        errormsg.innerHTML="Input a Password";
			        return false;
			    }
			    else if(password.length < 5){
			    	error.classList.remove("hidden");
			        errormsg.innerHTML="Password has to be atleast 5 chars";
			        return false;
			    }
			    else if( password2==null || password2==""){
			    	error.classList.remove("hidden");
			        errormsg.innerHTML="Input in confirm Password";
			        return false;
			    }
			    else if(password2.length < 5){
			    	error.classList.remove("hidden");
			        errormsg.innerHTML="Confirm Password has to be atleast 5 chars";
			        return false;
			    }
			    else if(password != password2){
			        errormsg.innerHTML="Password Does Not Match"
			    }
			    else{
					errormsg.innerHTML=" ";
					return true;
				}
			}

			function validateAge(form){
				var error=document.getElementById("error");
				var errormsg=document.getElementById("errormsg");
				var age=form["age"].value;
				
				if( age==null || age==""){
					error.classList.remove("hidden");
					errormsg.innerHTML="Input Your Age";
					return false;
				}
				else if(isNaN(age)){
					error.classList.remove("hidden");
					errormsg.innerHTML="Invalid Age";
			    }
			    else if(age<10){
			    	error.classList.remove("hidden");
					errormsg.innerHTML="Must be older than 10 years"
			    }
				else{
					errormsg.innerHTML=" ";
					return true;
				}
			}
			
			function validateUsername(form){
				var error=document.getElementById("error");
				var errormsg=document.getElementById("errormsg");
				var username=form["username"].value;
				
				if( username==null || username==""){
					error.classList.remove("hidden");
					errormsg.innerHTML="Input Your Name";
					return false;
				}
				else if(!isNaN(username)){
					error.classList.remove("hidden");
					errormsg.innerHTML="Name Can Not be a number";
			    }
			    else if(username.length<5 || username.length>15){
			    	error.classList.remove("hidden");
					errormsg.innerHTML="Name has to be 5 to 15 chars"
			    }
				else{
					errormsg.innerHTML=" ";
					return true;
				}
			}
			
			function validateEmail(form){
				var error=document.getElementById("error");
				var errormsg=document.getElementById("errormsg");
				var email=form["email"].value;
				
				var regx = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
				if( email==null || email==""){
					error.classList.remove("hidden");
					errormsg.innerHTML="Input Your Email";
					return false;
				}
				else if(!email.match(regx)){
					error.classList.remove("hidden");
					errormsg.innerHTML="Invalid Email";
					return false;
				}
				else{
					errormsg.innerHTML=" ";
					return true;
				}
			}
			
			function errmsg() {
				var msg = "${requestScope.msg}";
				if (msg!=null && msg.length > 5) {
					var f=document.getElementById("registerForm");
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
				<form:form id="registerForm" method="POST" action="register" modelAttribute="registerBean" onsubmit="return validate()">	
					<h2 align="center"><b> Enter Your Details </b></h2>
					<br/>
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-5" align="right">
							<p><form:label path="username"> Name </form:label></p>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-7" align="left">
          					<p><form:input id="username" name="username" path="username" required="required" /></p>
						</div>
					</div>
					<br/>
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-5" align="right">
							<p><form:label path="age"> Age </form:label></p>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-7" align="left">
          					<p><form:input id="age" name="age" path="age" required="required" /></p>
						</div>
					</div>
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
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-5" align="right">
							<p><form:label path="password2"> Confirm Password </form:label></p>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-7" align="left">
          					<p><form:password id="password2" name="password2" path="password2" required="required" /></p>
						</div>
					</div>
					<br/>
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-5" align="right">
							<p><form:label path="type" name="type" id="type" required="required"> Account Type </form:label></p>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-7" align="left">
							<p>&nbsp;<form:radiobutton path = "type" value = "user" label = "" checked="checked" /> &nbsp;<b>User</b>
                 			<form:radiobutton path = "type" value = "vendor" label = "" /> &nbsp;<b>Vendor</b></p>
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
						<input type="Submit" class="btn btn-primary btn-lg" value="Register" onClick="return validate();">
					</div>
				</form:form>
			</div>
		</div>
	</body>
</html>