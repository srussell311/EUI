<html>
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
 <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
$(document).ready(function() {
	var $datepicker = $('#ui-datepicker-div');
    $("#ediLaunch").datepicker();
        var edilaunch = $("#ediLaunch").val();

});

</script>
<style>
.ui-datepicker {
	 position: absolute !important;
    top: 550px !important;
    left: 580px !important;

}
</style>
</head>
<%@ include file="banner.jsp"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>
<%@ page import="java.util.Calendar"%>
<body id="wrapper">
<%
String actionType = (String)request.getParameter("actionType");
String action = (String)request.getParameter("action");
//System.out.println(actionType);
String orderSource = request.getParameter("orderSource");
if(orderSource == null){
	orderSource = "";
}
//System.out.println(orderSource);

dbUser.orderSource = (String)request.getSession().getAttribute("orderSource");
//System.out.println(dbUser.orderSource);

String catalogView = (String)request.getSession().getAttribute("catalogView");
dbUser.catView = (String)request.getSession().getAttribute("catalogView");
System.out.println("Catalog View only? ="+dbUser.catView);
//System.out.println("OrderSource= "+orderSource);
%>
<script language="Javascript">

function Cancel(){
	document.newAcct.actionType.value = "NewNA";
	document.newAcct.page.value="newNA.jsp"
	document.newAcct.submit();
	//location.reload();
}
	
   function getNA() {
   //gets national account list based on ecommerce platform selected
   document.newAcct.actionType.value="NewNA_1";
   document.newAcct.submit();
   }
  
   function SaveAccount(){
			document.newAcct.actionType.value = "SaveNewNA";
			document.newAcct.page.value="newNA.jsp"
			document.newAcct.submit();
	}
		
		function disableSubmit(){
			document.getElementById('SubmitNS').disabled=true;
			document.getElementById('Submitedi').disabled=true;
		}

		function disableCancel(){
			document.getElementById('CancelNS').disabled=true;
			document.getElementById('Canceledi').disabled=true;
		}

</script>
<%@ include file="navMenu.jsp"%>

<form action="ControllerServlet?page=newediNA.jsp" method="post" name="newAcct" onSubmit="return (disableSubmit() & disableCancel());">
	<input type=hidden name='actionType' value=""> <input type=hidden name='page' value=""><input type="hidden" name='routeToViewDtl' id='routeToViewDtl' value="viewNADtl"/>
	<div id="inputField">

		<span class="subTitle">New National Account</span> <br /> <br />
		<div id="centerTable">
		<% if (actionType.equals("NewNAEDI")) {%>
		<!--  <table border="0" cellpadding="0" width="100%">-->
		<!--  <table style="margin-left:auto;margin-right:auto;">-->

			
			
			<tr>
				<td><strong>National Account:</strong></td>
				<td><%=dbUser.nationalAccountNbr%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><strong>Order Source:</strong></td>
				<td><%=dbUser.orderSource%></td>
			</tr>
			</tr>
		<!--  </table>-->
			<br>
			<br>
			 	<p valign="top" style="postion:absolute;padding:-200px 0px 0px 0px" class="subTitle" name="ediSetupTitle" id="ediSetupTitle"><strong>EDI Setup</strong></p>
			 	
			<!--Account Setup Section -->
		
		<input name="typeAction" type="hidden" id="typeAction" value="I" />
<br><br>

	<!-- EDI Setup Section -->
		<table name="ediTable" id="ediTable" style="">
			<tr>
			 <td class="subTitle" name="ediSetup" id="ediSetup">EDI Account Setup</td>
			 <td></td>
			</tr>
			<!-- <tr>
				<td name="catView" id="catView">Catalog View Only Account?</td>
				<%//if(dbUser.catView.equals("N")){%>
				<td><select name="nscatView" id="nscatView">
				<option value="N" selected>No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%//} else { %>
				<td><select name="nscatView" id="nscatView">
				<option value="Y" selected>Yes</option>
				<option value="N">No</option>
				</select></td>
				<%// } %>
			</tr> -->
			<tr>
			<td name="ddMTUsed" id="ddMTUsed">DDMT Used?</td>
				<td><select name="ddMT" id="ddMT">
				<option selected value="N">No</option>
				<option value="Y">Yes</option>
				</select></td>
			</tr>
			<tr>
				<td name="imagedUsed" id="imagedUsed">Item Images Used?</td>
				<%if(dbUser.catView.equals("N")){ %>
				<td><select name="imgUsed" id="imgUsed">
				<option selected value="N">No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="imgUsed" id="imgUsed">
				<option selected value="Y">Yes</option>
				<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="itemEnrich" id="itemEnrich">Item Enrichment?</td>
				<%if(dbUser.catView.equals("N")){ %>
				<td><select name="enrichMent" id="enrichMent">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="enrichMent" id="enrichMent">
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="sdsProvided" id="sdsProvided">SDS Provided?</td>
				<%if(dbUser.catView.equals("N")){ %>
				<td><select name="sDs" id="sDs">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="sDs" id="sDs">
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="barAvail" id="barAvail">Barcodes Available?</td>
				<td><select name="barCodes" id="barCodes">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
			</tr>
			<tr>
				<td name="ediDate" id="ediDate">Launch Date</td>
				<td><input type="text" id="ediLaunch" name="ediLaunch" readonly="true"/></td>
			</tr>
			<tr>
				<td name="specNotesNS" id="specNotesNS">Special Setup Notes:</td>
				<td><textarea name="nsaddNotes" id="nsaddNotes"></textarea></td>
			</tr>
		</table>
		<br>
		<br>
		<br>
		<table>
			<tr colspan="4">
			<td><input type="button" name="Canceledi" id="Canceledi" value="Cancel" style="position:absolute;top:515px;left:535px;right:0px;bottom:0px;width: 100px;height:25px;" value="Cancel" onClick="window.location='ControllerServlet?page=newNA.jsp&actionType=NewNA';" />
				<td><input type="button" name="Submitedi" id="Submitedi" value="Save" style="position:absolute;top:515px;left:655px;right:0px;bottom:0px;width: 100px;height:25px;" value="Save" onclick="javascript:SaveAccount()" /></td> 
					<input name="typeAction" type="hidden" id="typeAction" value="I" /></td>
			</tr>
			</table>

			<%
		}		
			
if (actionType.equals("SaveNewNA")) { 

String confirmMsg = "";

	//if (dbUser.validSQLF.equals("Y")) {

confirmMsg = "The New National Account was successfully saved.";

	//} else {
//confirmMsg = "<span class='errorField'>The new National Account was NOT saved.  The SQL statement did NOT pass validation.</span>";	
	//}
%>
			<table style="margin: 0 auto;">
			<tr>
				<td><span class="subTitle"><%=confirmMsg%></span><br />
					<br /></td>
			</tr>
			</table>
			<% }
			//national account was successfully saved 
%>
		
		</div>
	</div>

</form>






</body>
</html>