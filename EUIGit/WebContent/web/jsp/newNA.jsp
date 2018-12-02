<html>
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
</head>
<%@ include file="banner.jsp"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>

<body id="wrapper" onload="loadFunction()">
<%
String actionType = (String)request.getParameter("actionType");
//System.out.println(actionType);
String orderSource = request.getParameter("orderSource");
if(orderSource == null){
	orderSource = "";
}
//System.out.println("OrderSource= "+orderSource);
%>
<script language="Javascript">

function Cancel(){
	//alert("Cancel Function")
	loadFunction();
	document.newAcct.actionType.value = "NewNA";
	document.newAcct.page.value="newNa.jsp"
	document.newAcct.submit();
	//location.reload();
}

	
	/*function loadFunction(){
		var source = document.getElementById('orderSource').value;
		//alert("Alert on load start=" +source)
		
		if(document.newAcct.orderSource.value==""||!document.newAcct.orderSource.value==""){
			//alert("Alert 1")
			document.getElementById('catviewOnly').style.display = "none";
			document.getElementById('catalogbtnYes').style.display = "none";
			document.getElementById('catalogbtnNo').style.display = "none";
			document.getElementById('catalogYes').style.display = "none";
			document.getElementById('catalogNo').style.display = "none";
					
		}
		
	}*/
	
	function buttonclicked(clicked_id){
		//alert(clicked_id)
		
		if(clicked_id == "catalogbtnYes"){
			document.newAcct.catalogView.value = "Y";

		}
		if(clicked_id == "catalogbtnNo"){
			document.newAcct.catalogView.value = "N";
		}
	}
	
	function catalog(){

	var account = document.getElementById('natAcct').value
	var orderSrc = document.getElementById('orderSource').value
	var catalogView = document.getElementById('catalogView').value
	//alert (catalogView)

		if(account != "" && orderSrc == ""){
			alert("Please Select an Order Source")
			return false
		}
	
		if(account == "" && orderSrc != ""){
			alert("Please Select a National Account")
			return false
		}
		
		if(document.newAcct.orderSource.value=="NetSupply" && document.newAcct.catalogView.value == "N"){
		document.newAcct.actionType.value = "NewNANetSupply";
		document.newAcct.page.value="newNetsupplyNA.jsp"
		document.newAcct.submit();
		}
		
		if(document.newAcct.orderSource.value=="NetSupply" && document.newAcct.catalogView.value == "Y"){
			document.newAcct.actionType.value = "NewNANetSupply";
			document.newAcct.page.value="newNetsupplyNA.jsp"
			document.newAcct.submit();
			}
		
		if(document.newAcct.orderSource.value !="NetSupply" && document.newAcct.catalogView.value == "Y"){
			document.newAcct.actionType.value = "NewNANetSupply";
			document.newAcct.page.value="newNetsupplyNA.jsp"
			document.newAcct.submit();
		}
		
		if(document.newAcct.orderSource.value !="NetSupply" && document.newAcct.catalogView.value == "N"){
		document.newAcct.actionType.value = "NewNAEDI";
		document.newAcct.page.value="newediNA.jsp"
		document.newAcct.submit();
		}
		
	}
	
	function Hide(){
		var account = document.getElementById('natAcct').value
		var orderSrc = document.getElementById('orderSource').value
		
		document.newAcct.actionType.value = "NewNA_1";
		document.newAcct.page.value="newNA.jsp"
		document.newAcct.submit();
		
		/*if(account != "" && orderSrc != ""){
		
		document.getElementById('catviewOnly').style.display = "block";
		document.getElementById('catalogbtnYes').style.display = "block";
		document.getElementById('catalogbtnNo').style.display = "block";
		}*/
	}
	
	function dropDown(){
		var account = document.getElementById('natAcct').value
		var orderSrc = document.getElementById('orderSource').value
		var ctlgYes = document.getElementById('orderSource').value
		var ctlgNo = document.getElementById('orderSource').value
		
		//if(account != "" && orderSrc != ""){
			//function Hide();
		//}

	}
		

</script>

<form action="ControllerServlet" method="post" name="newAcct" onSubmit="return (disableSubmit() & disableCancel());">
	<input type=hidden name='actionType' value=""> <input type=hidden name='page' value="">
	<div id="inputField">

		<span class="subTitle">New National Account</span> <br /> <br />
		<div id="centerTable">

		<!--  <table border="0" cellpadding="0" width="100%">-->
		<!--  <table style="margin-left:auto;margin-right:auto;">-->

			<% if (actionType.equals("NewNA")) {%>
			
			<tr>
				<td><strong>National Account:</strong></td>
				<td><select name="natAcct" id="natAcct">

						<option align="center" value="">-- Select One --</option>
						<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j);	 %>
						<option value="<%=natAcct.elementAt(1)%> - <%=natAcct.elementAt(0)%>">
						<%=natAcct.elementAt(1)%> - <%=natAcct.elementAt(0)%></option>
						
						<%    }			
%>				
				</select></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><strong>Order Source:</strong></td>
				<td><select name="orderSource" id="orderSource" onchange="javascript:Hide()">
					<option align="center" value="">-- Select One --</option>
					<%
		for (int i = 0; i < dbUser.platform.size(); i++) {
         Vector platform = (Vector) dbUser.platform.elementAt(i);	 %>
						<option value="<%=platform.elementAt(0)%>">
						<%=platform.elementAt(0)%></option>
						
						<%    }			
%>				
					
				</select></td>
			</tr>
		 </table>
			<!-- <br>
			<br>
			 	<p valign="top" name="catviewOnly" id="catviewOnly" style="postion:absolute;top:100px;right:700px;left:400px;bottom:0px;" class="subTitle" ><strong>Is this a Catalog View Only Account?</strong></p>
			 	<input type="button" name="catalogbtnYes" id="catalogbtnYes" style="position:absolute;top:125px;left:535px;right:0px;bottom:0px;width: 100px;height:25px;" value= "Yes" onclick="buttonclicked(this.id);javascript:catalog();" />
			<input name="catalogbtnNo" id="catalogbtnNo" style="position:absolute;top:125px;left:655px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="No" onclick="buttonclicked(this.id);javascript:catalog();"/>
			<input type="hidden" name="catalogView" id="catalogView"/>
			<!-- <input type="hidden" name="catalogNo" value=""/> -->


		

<%} if(actionType.equals("NewNA_1")){ %>
	<tr>
				<td><strong>National Account:</strong></td>
				<td><select name="natAcct" id="natAcct"
					onchange="javascript:Hide()">

						<option selected align="center" value="<%=dbUser.nationalAccountNbr%>"><%=dbUser.nationalAccountNbr%></option>
						<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j);	 %>
						<option value="<%=natAcct.elementAt(1)%> - <%=natAcct.elementAt(0)%>">
						<%=natAcct.elementAt(1)%> - <%=natAcct.elementAt(0)%></option>
						
						<%    }			
%>				
				</select></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><strong>Order Source:</strong></td>
				<td><select name="orderSource" id="orderSource" onchange="javascript:Hide()">
					<option selected align="center" value="<%=dbUser.orderSource%>"><%=dbUser.orderSource%></option>
					<%
		for (int i = 0; i < dbUser.platform.size(); i++) {
         Vector platform = (Vector) dbUser.platform.elementAt(i);	 %>
						<option value="<%=platform.elementAt(0)%>">
						<%=platform.elementAt(0)%></option>
						
						<%    }			
%>				
					
				</select></td>
			</tr>
		 </table>
			<br>
			<br>
			 	<p valign="top" name="catviewOnly" id="catviewOnly" style="postion:absolute;top:100px;right:700px;left:400px;bottom:0px;" class="subTitle" ><strong>Does <%=dbUser.customerName%> use NetSupply as a Catalog site?</strong></p>
			 	<input type="button" name="catalogbtnYes" id="catalogbtnYes" style="position:absolute;top:125px;left:535px;right:0px;bottom:0px;width: 100px;height:25px;" value= "Yes" onclick="buttonclicked(this.id);javascript:catalog();" />
			<input name="catalogbtnNo" id="catalogbtnNo" style="position:absolute;top:125px;left:655px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="No" onclick="buttonclicked(this.id);javascript:catalog();"/>
			<input type="hidden" name="catalogView" id="catalogView"/>
			<!-- <input type="hidden" name="catalogNo" value=""/> -->
	


<%}%>
		</div>
	</div>

</form>


<%@ include file="navMenu.jsp"%>


</body>
</html>