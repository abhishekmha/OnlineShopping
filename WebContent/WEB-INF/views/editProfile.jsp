<%@include file="_master.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Update User</title>
		<style>
			.center {
			margin-top: 2.5%;
			width: 60%;
			margin-left: auto;
  			margin-right: auto;
			}
			.hidden {
			display: block;
			}
		</style>
		<script>
			function validate(){
			    var f=document.getElementById("editForm");
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
					errormsg.innerHTML="Input Your Email";
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
					var f=document.getElementById("editForm");
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
				<form:form id="editForm" method="POST" action="editProfile" modelAttribute="registerBean" onsubmit="return validate()">	
					<h2 align="center"><b> Enter New Details </b></h2>
					<div class="row">
			            <div class="col-md-6 col-sm-6 col-xs-6" align="center">
			            	<p>
								<form:label path="email"> New Email ID </form:label><br/>
								<form:input id="email" name="email" class="center-block" path="email" required="required" /><br/>
			                </p>
			            </div>
					    <div class="col-md-6 col-sm-6 col-xs-6" align="center">
			                <p>
			                   <input type="Submit" class="btn btn-primary btn-lg" value="Save Changes" onClick="return validate();">
			                </p>
			            </div>
			        </div>
			        <div class="row">
			            <div class="col-md-6 col-sm-6 col-xs-6" align="center">
			                <p>
								<form:label path="username"> New Name </form:label><br/>
								<form:input id="username" name="username" class="center-block" path="username" required="required" /><br/>
			                </p>
			            </div>
					    <div class="col-md-6 col-sm-6 col-xs-6" align="center">
			                <p>
			                	<form:label path="age"> New Age </form:label><br/>
			                	<form:input id="age" name="age" class="center-block" path="age" required="required" />
			                </p>
			            </div>
			        </div>
			        <div class="row">
			            <div class="col-md-6 col-sm-6 col-xs-6" align="center">
			                <p>
								<form:label path="password"> Enter New Password </form:label><br/>
								<form:password id="password" name="password" class="center-block" path="password" required="required" /><br/>
			                </p>
			            </div>
					    <div class="col-md-6 col-sm-6 col-xs-6" align="center">
			                <p>
			                	<form:label path="password2"> Confirm New Password </form:label><br/>
			                	<form:password id="password2" name="password2" class="center-block" path="password2" required="required" />
			                </p>
			            </div>
			        </div>
					<div align="center">
						<div id="error" class="alert alert-danger alert-dismissible hidden" role="alert">
	       					<button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
	       					<div id="errormsg"></div>
     					</div>
     				</div>
				</form:form>
			</div>
		</div>
	</body>
</html>