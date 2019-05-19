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
		<script>
		function validate(){
		    var f=document.getElementById("addForm");
		    var error=document.getElementById("error");
		    if(validateQuantity(f))
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
		</script>
	</head>
	
	<body>
		<div class="container center">
			<h2 class="center-text"> Available Products </h2><hr/>
			<div class="row">
				<c:forEach items="${productList}" var="name">
					<div class="col-md-4 col-sm-4 col-xs-4" align="center">
						<p><button class="btn btn-default" data-toggle="modal" data-target="#modal${name}">
						<img src="<c:url value="/resources/images/products/${name}.jpg" />"
						alt="NO IMAGE PROVIDED" width="200" height="150"><br/><br/><b>${name}</b>
						</button></p>
					</div>
					<div id="modal${name}" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">Product Details - ${name}</h4>
								</div>
								<form:form id="addForm" method="POST" action="addToCart" modelAttribute="purchaseBean" onsubmit="return validate()">	
								<br/>
								<div class="row">
								<div class="col-md-5 col-sm-5 col-xs-5" align="right">
									<p><form:label path="productname"> Product Name </form:label></p>
								</div>
								<div class="col-md-7 col-sm-7 col-xs-7" align="left">
		          					<p><form:input id="productname" class="center-block" name="productname" path="productname" value="${name}" required="required" readonly="true" /></p>
								</div>
								</div>
								<br/>
								<div class="modal-body">
									<p class="text-center text-capitalize"> Description : <br/> ${descriptionList[name]} </p>
								</div>
								<br/>
								<div class="row">
								<div class="col-md-5 col-sm-5 col-xs-5" align="right">
									<p><form:label path="quantity"> Quantity </form:label></p>
								</div>
								<div class="col-md-7 col-sm-7 col-xs-7" align="left">
		          					<p><form:input id="quantity" class="center-block" name="quantity" path="quantity" required="required" /></p>
								</div>
								</div>
								<br/>
								<div class="row">
								<div class="col-md-5 col-sm-5 col-xs-5" align="right">
									<p><form:label path="vendor"> Vendor </form:label></p>
								</div>
								<div class="col-md-7 col-sm-7 col-xs-7" align="left">
									<p>&nbsp;<form:select path = "vendor" name="vendor" id="vendor">
			                 			<c:forEach items="${vendorList[name]}" var="ven">
			                 				<form:option value="${ven}"> ${vendorNameList[ven]} </form:option>
			                 			</c:forEach>
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
									<input type="Submit" class="btn btn-primary" value="addToCart" onClick="return validate();">
								</div>
					
								</form:form>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		
	</body>
</html>