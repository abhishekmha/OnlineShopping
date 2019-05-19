<%@include file="_master.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>New Product</title>
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
			    var f=document.getElementById("productForm");
			    var error=document.getElementById("error");
			    if(validateProductname(f) && validateDescription(f) && validateQuantity(f) && validatePrice(f) )
			    {
			    	error.classList.add("hidden");
			    	return true;
			    }
			    else
			    	return false;
			}
			
			function validateQuantity(form){
				var error=document.getElementById("error");
				var errormsg=document.getElementById("errormsg");
				var quantity=form["quantity"].value;
				
				if( quantity==null || quantity==""){
					error.classList.remove("hidden");
					errormsg.innerHTML="Input Product Quantity";
					return false;
				}
				else if(isNaN(quantity)){
					error.classList.remove("hidden");
					errormsg.innerHTML="Invalid Quantity";
			    }
			    else if(quantity<1){
			    	error.classList.remove("hidden");
					errormsg.innerHTML="Must be atleast 1"
			    }
				else{
					errormsg.innerHTML=" ";
					return true;
				}
			}
			
			function validatePrice(form){
				var error=document.getElementById("error");
				var errormsg=document.getElementById("errormsg");
				var price=form["price"].value;
				
				if( price==null || price==""){
					error.classList.remove("hidden");
					errormsg.innerHTML="Input Product Price";
					return false;
				}
				else if(isNaN(price)){
					error.classList.remove("hidden");
					errormsg.innerHTML="Invalid Price";
			    }
			    else if(price<1){
			    	error.classList.remove("hidden");
					errormsg.innerHTML="Must be atleat Rs. 1"
			    }
				else{
					errormsg.innerHTML=" ";
					return true;
				}
			}
			
			function validateProductname(form){
				var error=document.getElementById("error");
				var errormsg=document.getElementById("errormsg");
				var productname=form["productname"].value;
				
				var regx = /^[^a-zA-Z]*$/;
				if( productname==null || productname==""){
					error.classList.remove("hidden");
					errormsg.innerHTML="Input the Product name";
					return false;
				}
				else if(!productname.match(regx)){
					error.classList.remove("hidden");
					errormsg.innerHTML="Product name should be plain text";
			    }
			    else if(productname.length<5 || productname.length>15){
			    	error.classList.remove("hidden");
					errormsg.innerHTML="Product name should be 5-15 characters"
			    }
				else{
					errormsg.innerHTML=" ";
					return true;
				}
			}
			
			function validateDescription(form){
				var error=document.getElementById("error");
				var errormsg=document.getElementById("errormsg");
				var description=form["description"].value;
				
				var regx = /^[^a-zA-Z]*$/;
				if( description==null || description==""){
					error.classList.remove("hidden");
					errormsg.innerHTML="Input the description";
					return false;
				}
				else if(!description.match(regx)){
					error.classList.remove("hidden");
					errormsg.innerHTML="Description should be plain text";
					return false;
				}
				else if(description.length<5 || description.length>50){
			    	error.classList.remove("hidden");
					errormsg.innerHTML="Description should be 5-50 characters"
			    }
				else{
					errormsg.innerHTML=" ";
					return true;
				}
			}
			
			function errmsg() {
				var msg = "${requestScope.msg}";
				if (msg!=null && msg.length > 5) {
					var f=document.getElementById("productForm");
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
				<form:form id="productForm" method="POST" action="addProduct" modelAttribute="productBean" onsubmit="return validate()">	
					<h2 align="center"><b> Enter Your Details </b></h2>
					<br/>
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-5" align="right">
							<p><form:label path="productname"> Product Name </form:label></p>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-7" align="left">
          					<p><form:input id="productname" name="productname" path="productname" required="required" /></p>
						</div>
					</div>
					<br/>
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-5" align="right">
							<p><form:label path="description"> Product Description </form:label></p>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-7" align="left">
          					<p><form:textarea id="description" name="description" path="description" rows="5" cols="30" required="required" /></p>
						</div>
					</div>
					<br/>
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-5" align="right">
							<p><form:label path="quantity"> Quantity </form:label></p>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-7" align="left">
          					<p><form:input id="quantity" name="quantity" path="quantity" required="required" /></p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-5" align="right">
							<p><form:label path="price"> Price (in Rs.) </form:label></p>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-7" align="left">
          					<p><form:input id="price" name="price" path="price" required="required" /></p>
						</div>
					</div>
					<br/>
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-5" align="right">
							<p><form:label path="category"> Category </form:label></p>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-7" align="left">
							<p>&nbsp;<form:select path = "category" name="category" id="category">
	                 			<form:option value="electronics"> Electronics </form:option>
	                 			<form:option value="food"> Food </form:option>
	                 			<form:option value="appliances"> Home Appliances </form:option>
	                 			<form:option value="furniture"> Furniture </form:option>
	                 			<form:option value="books"> Books </form:option>
                 			</form:select></p>
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
						<input type="Submit" class="btn btn-primary btn-lg" value="Add Product" onClick="return validate();">
					</div>
				</form:form>
			</div>
		</div>
	</body>
</html>