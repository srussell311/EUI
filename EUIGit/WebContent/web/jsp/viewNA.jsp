<html>
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
</head>
<%@ include file="banner.jsp" %>
<%@ page import="java.util.Vector"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>


<body id="wrapper" style="height:1700px;">
<%
//System.out.println(dbUser.lsog);
//String routeToViewDtl = (String)request.getParameter("routeToViewDtl");
//System.out.println("ACtion TYPE "+dbUser.routeToViewDtl);
if(dbUser.routeToViewDtl == null){
	dbUser.routeToViewDtl = "";
}
String actionType = (String)request.getParameter("actionType");
//System.out.println("ACtion TYPE "+actionType);
//System.out.println("SSO ="+dbUser.nsssoCustomer);
if(dbUser.custName == null){
	dbUser.custName = dbUser.natAcct;
}

%>
<script language="Javascript">
	
   
   function getNationalAccountDtl() {
	   //alert("Its getting here");
   //get details after national account and member has been selected
   document.updtAcct.actionType.value="viewNADtl";
   document.updtAcct.page.value="viewNA.jsp"
   document.updtAcct.submit();
   }   
   
   function UpdateAccount(){
	   //alert("UpdateAccount");
  
   			document.updtAcct.actionType.value = "UpdateNA_1";
			document.updtAcct.page.value="updateNA.jsp"
			document.updtAcct.submit();

	}
	
	function Cancel(){
		//alert("Cancel");
			document.updtAcct.actionType.value = "UpdateNA";
			document.updtAcct.page.value="updateNA.jsp"
			document.updtAcct.submit();
	}
   

</script>
<%@ include file="navMenu.jsp"%>

<form action="ControllerServlet" method="post" name="updtAcct">
	<input type=hidden name='actionType' value=""> <input
		type=hidden name='page' value="">
	<div id="inputField">

		<br><span class="subTitle">View National Account</span> <br /> <br />
		<div id="centerTable">
		<!--  <table border="0" cellpadding="0">-->
			<% if (actionType.equals("viewNA")) { %>

			<tr>
				<td><strong>National Account:</strong></td>
				<td colspan="3"><select name="natAcct" id="natAcct"
					onchange="javascript:getNationalAccountDtl();">
						<option value="none" selected="selected">--- Select One
							---</option>
						<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j); %>
						<option
							value="<%=natAcct.elementAt(1)%> - <%=natAcct.elementAt(0)%>"><%=natAcct.elementAt(1)%>
							- <%=natAcct.elementAt(0)%></option>
						<%    }			
%>
				</select></td>
			</tr>


			<% } 
			//System.out.println("Sr="+dbUser);
 //display details after all necessary selections made
if (actionType.equals("viewNADtl") || dbUser.routeToViewDtl.equals("viewNADtl")) {%>

<div id="centerTable">
		<!--  <table border="0" cellpadding="0">-->

			
			<tr>
				<td><strong>National Account:</strong></td>
				<td colspan="3"><select name="natAcct" id="natAcct"
					onchange="javascript:getNationalAccountDtl();">
						<!--  <option value="<%=dbUser.custName%> - <%=dbUser.custMaj%> %>" selected="selected" ><%=dbUser.custName%></option>-->
						<option value="<%=dbUser.natAcct%>" selected="selected" ><%=dbUser.natAcct%></option>
						<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j); %>
						<option
							value="<%=natAcct.elementAt(1)%> - <%=natAcct.elementAt(0)%>"><%=natAcct.elementAt(1)%>
							- <%=natAcct.elementAt(0)%></option>
						<%    }			
%>
				</select></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="button" style="width:100px;height:25px;" name="update" id="update" value="Update" onClick="javascript:UpdateAccount();"/></td>
			</tr>

			
			
			<%if(!dbUser.orderSource.equals("NetSupply") & dbUser.catView.equals("N")){%>
			
			<!-- <tr>
				<td><strong>National Account:</strong></td>
				<td> --><br><br><span name="natAcct" type="hidden"
					value="<%=dbUser.nationalAccountNbr%>"><strong><%=dbUser.custName%> ordering on <%=dbUser.orderSource%></strong> 
				</span>
			<!--</tr>  -->
			
			
			<!-- Order Source Field Needs to be here somewhere -->
			<br><br>
			<!-- <p valign="top" style="postion:absolute;padding:-200px 0px 0px 0px" class="subTitle" name="netsupplySetup" id="netsupplySetup"><strong>EDI Setup Details</strong></p> -->
			
			<table align="center" style="margin: 0 auto;border: 5px solid #4f758b;border-radius: 25px;box-shadow: 0px 0px 30px #000; behavior: url(PIE.htc);width:90%;text-align:center;padding:10px">
			<tr>
			 <td class="subTitle" name="ediSetup" id="ediSetup">EDI Account Setup</td>
			 <td></td>
			</tr>

			<tr>
				<td name="ddMTUsed" id="ddMTUsed"><strong>DDMT Used?</strong><br>
				<%if(dbUser.ddMT.equals("N")){ %>
				<td><input size="30" disabled value="No"/></td>
				<%} else { %>
				<td><input size="30" disabled value="Yes"/></td>
			  	<% } %></td>	
				<td name="imagedUsed" id="imagedUsed"><strong>Item Images Used?</strong></td>
				<%if(dbUser.imgUsed.equals("N")){ %>
				<td><input size="30" disabled value="No"/></td>
				<%} else { %>
				<td><input size="30" disabled value="Yes"/></td>
				<% } %>
			</tr>
			<tr>
				<td name="itemEnrich" id="itemEnrich"><strong>Item Enrichment?</strong></td>
				<%if(dbUser.enrichMent.equals("N")){%>
				<td><input size="30" disabled value="No"/></td>
				<%} else { %>
				<td><input size="30" disabled value="Yes"/></td>
				<% } %>
				<td name="sdsProvided" id="sdsProvided"><strong>SDS Provided?</strong></td>
				<%if(dbUser.sDs.equals("N")){%>
				<td><input size="30" disabled value="No"/></td>
				<%} else { %>
				<td><input size="30" disabled value="Yes"/></td>
				<% } %>
			</tr>
			<tr>
				<td name="barAvail" id="barAvail"><strong>Barcodes Available?</strong></td>
				<%if(dbUser.barCodes.equals("N")){%>
				<td><input size="30" disabled value="No"/></td>
				<%} else { %>
				<td><input size="30" disabled value="Yes"/></td>
				<% } %>
				<td name="catViewOnly" id="catViewOnly"><strong>Catalog View Only Account?</strong></td>
				<%if(dbUser.catView.equals("N")){%>
				<td><input size="30" disabled value="No"/></td>
				<%} else { %>
				<td><input size="30" disabled value="Yes"/></td>
				<% } %>	
			</tr>	
				<td name="ediDate" id="ediDate"><strong>Launch Date</strong></td>
				<td><input size="30" disabled value="<%=dbUser.ediLaunch%>"/></td>
				<td name="specNotesNS" id="specNotesNS"><strong>Special Setup Notes:</strong></td>
				<td><textarea disabled style="width:225px;height:90px;" name="nsaddNotes" id="nsaddNotes"><%=dbUser.nsaddNotes%></textarea></td>
			</tr>
		</table>
			
			<%} if(dbUser.orderSource.equals("NetSupply") || !dbUser.orderSource.equals("NetSupply") & dbUser.catView.equals("Y")){ %>
			
			<!-- <tr>
				<td><strong>National Account:</strong> </td>-->
				 <br><br>
			<%if(dbUser.orderSource.equals("NetSupply") & dbUser.catView.equals("N")){ %>	 
			<span name="natAcct" type="hidden" value="<%=dbUser.nationalAccountNbr%>" /><strong><%=dbUser.custName%> ordering on <%=dbUser.orderSource%></strong></span>
			<%} else { %>
			<span name="natAcct" type="hidden" value="<%=dbUser.nationalAccountNbr%>" /><strong><%=dbUser.custName%> catalog setup on NetSupply</strong></span>
			<%} %>
			<br>
			<br>
			
			 	<!--<p valign="top" style="postion:absolute;padding:-200px 0px 0px 0px" class="subTitle" name="netsupplySetup" id="netsupplySetup"><strong>NetSupply Setup Details</strong></p> -->

			
			<!--Account Setup Section -->
		
		<table align="center" style="margin: 0 auto;border: 5px solid #4f758b;box-shadow: 0px 0px 30px #000; behavior: url(PIE.htc);border-radius: 25px;width:90%;text-align:center;padding:10px">
			<tr>
			 	<td class="subTitle" name="acctSetupNS" id="acctSetupNS">Account Setup</td>
			 	<td></td>
			 	<td></td>
			 	<td></td>
			</tr>
			<tr>
				<td name="ddmtNS" id="ddmtNS" width="25%" style="font-size:14px;"><strong>DDMT Used?</strong><br></td>
				<%if(dbUser.nsddMT.equals("N")){%>
				<td align="center"><input disabled value="No"/></td>
				<%} else { %>
				<td align="center"><input disabled value="Yes"/></td>
				<% } %>
				<td name="usaClean" id="usaClean" style="font-size:14px;" width="25%"><strong>USA-Clean SSO Activated?</strong></td>
			    <td width="25%"><input disabled value="<%=dbUser.usaClean%>" /></td>
			</tr>
			<tr>
			    <td name="custLocNS" id="custLocNS" style="font-size:14px;"><strong>Display Customer Location Number?</strong></td>
			    <%if(dbUser.nscustLocNbr.equals("N")){%>
				<td align="center"><input disabled value="No"/></td>
				<%} else { %>
				<td align="center"><input disabled value="Yes"/></td>
				<% } %>
			    <td name="launchDateNS" id="launchDateNS" style="font-size:14px;"><strong>NetSupply Launch Date:</strong></td> 
			   <td><input disabled value="<%=dbUser.nslaunchDate%>"/></td> 
			</tr>
			<tr>  
			    <td name="custURLNS" id="custURLNS" style="font-size:14px;"><strong>URL posted to Customers Intranet?</strong></td>
			    <%if(dbUser.nscustURL.equals("N")){%>
				<td align="center"><input disabled value="No"/></td>
				<%} else { %>
				<td align="center"><input disabled value="Yes"/></td>
				<% } %>
			    <td name="locBudgets" id="locBudgets" style="font-size:14px;"><strong>Locations with Budgets Count:</strong></td>
				<td><input disabled value="<%=dbUser.locBudgets%>"/></td>
			</tr> 
			<tr>
				<td name="locCount" id="locCount" style="font-size:14px;"><strong>Location Count:</strong></td>
			    <td><input disabled value="<%=dbUser.locCount%>"/></td>
				<td name="locworkCount" id="locworkCount" style="font-size:14px;"><strong>Locations With Workflow Counts:</strong></td>
				<%if(dbUser.locworkCount == null ||dbUser.locworkCount.equals("")){%>
				<td><input disabled value="0"/></td>
				<%} else { %>
				<td><input disabled value="<%=dbUser.locworkCount%>"/></td>
				<%} %>
			</tr>
			<tr>
				<td name="workflowCount" id="workflowCount" style="font-size:14px;"><strong>Workflow Count:</strong></td>
				<%if(dbUser.workflowCount == null ||dbUser.workflowCount.equals("")){%>
				<td><input disabled value="0"/></td>
				<%} else { %>
				<td><input disabled value="<%=dbUser.workflowCount%>"/></td>
				<%} %>  
				<td name="markSegment" id="markSegment" style="font-size:14px;"><strong>Market Segment:</strong></td>
				<td><input size="40" disabled value="<%=dbUser.markSegment%>"/></td>
			</tr>
			<tr>
				<td name="distCount" id="distCount" style="font-size:14px;"><strong>Distributor Count:</strong></td>
				<td><input disabled value="<%=dbUser.distCount%>"/></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td name="assignedCSR" id="assignedCSR" style="font-size:14px;"><strong>Assigned CSR <br>(Name and Phone #):</strong></td>
				<td><textarea style="height: 50px;" cols="30" disabled ><%=dbUser.assignedCSR%></textarea></td>
				<td name="specNotesNS" id="specNotesNS" style="font-size:14px" ><strong>Special Setup Notes:</strong></td>
				<td><textarea rows="4" cols="30" disabled value=""><%=dbUser.nsaddNotes%></textarea></td>
			</tr>
		</table>
		<br>
			<!--END OF Account Setup Section -->
			
			<!--Catalog Setup Section -->
		<table align="center"  style="margin: 0 auto;border: 5px solid #4f758b;box-shadow: 0px 0px 60px #000; behavior: url(PIE.htc);border-radius: 25px;width:90%;text-align:center;padding:10px">
			<tr>
			 	<td class="subTitle" name="catSetup" id="catSetup" width="25%">Catalog Setup</td>
			 	<td width="25%"></td>
			 	<td width="25%"></td>
			 	<td width="25%"></td>
			</tr>
			<tr>
				<td name="lsog" id="lsog" style="font-size:14px;" width="25%"><strong>Account LSOG capability?</strong></td>
				<%if(dbUser.lsog == null||dbUser.lsog.equals("")){%>
				<td width="25%"><input disabled value="No"/></td> 
				<%} else { %>
				<td width="25%"><input disabled value="Yes"/></td>
				<% } %>
				<td name="imgUsedNS" id="imgUsedNS" style="font-size:14px;" width="25%"><strong>Item Images Used?</strong></td>
				<%if(dbUser.nsimgUsed.equals("N")){%>
				<td width="25%"><input disabled value="No"/></td>
				<%} else { %>
				<td width="25%"><input disabled value="Yes"/></td>
				<% } %>
			</tr>
				<td name="enrichmentNS" id="enrichmentNS" style="font-size:14px;"><strong>Item Enrichment?</strong></td>
				<%if(dbUser.nsenrichMent.equals("N")){%>
				<td><input disabled value="No"/></td>
				<%} else { %>
				<td><input disabled value="Yes"/></td>
				<%}%>
				<td name="dualOrdGuideNS" id="dualOrdGuideNS" style="font-size:14px;"><strong>Dual Order Guide Setup?</strong></td>
				<%if(dbUser.nsdualOrdGuide.equals("N")){%>
				<td><input disabled value="No"/></td>
				<%} else { %>
				<td><input disabled value="Yes"/></td>
				<% } %>
			</tr>
			<tr>
				<td name="custItemNbrNS" id="custItemNbrNS" style="font-size:14px;"><strong>Customer Item Numbers? </strong></td>
				<%if(dbUser.nscustItemNbr== null||dbUser.nscustItemNbr.equals("")){%>
				<td><input disabled value="No"/></td>
				<%} else { %>
				<td><input disabled value="Yes"/></td>
				<% } %> 
				<td name="percentItemNbr" id="percentItemNbr" style="font-size:14px;"><strong>% of Items with Customer Numbers? </strong></td>
				<%if(dbUser.percentItemNbr == null||dbUser.percentItemNbr == ""){ %>
				<td><input disabled value="0%"/></td>
				<%} else { %>
				<td><input disabled value="<%=dbUser.percentItemNbr%>%"/></td>
				<%}%>
			</tr>
				<td name="catViewNS" id="catViewNS" style="font-size:14px;"><strong>Catalog Viewing Only Account?</strong></td>
				<%if(dbUser.nscatView.equals("N")){%>
				<td><input disabled value="No"/></td>
				<%} else {%>
				<td><input disabled value="Yes"/></td>
				<% } %>
				<td name="sDsNS" id="sDsNS" style="font-size:14px;"><strong>SDS Provided?</td>
				<%if(dbUser.nssDs.equals("N")){%>
				<td><input disabled value="No"/></td>
				<%} else {%>
				<td><input disabled value="Yes"/></td>
				<% } %>
			</tr>
			<tr>
				<td name="barCodesNS" id="barCodesNS" style="font-size:14px;"><strong>Barcodes Available?</strong></td>
				<%if(dbUser.nsbarCodes.equals("N")){%>
				<td><input disabled value="No"/></td>
				<%} else { %>
				<td><input disabled value="Yes"/></td>
				<%}%>
				<td name="zones" id="zones" style="font-size:14px;"><strong>Utilizes Zone 9 and/or 10 for pricing:</strong></td>
				<td><input disabled value="<%=dbUser.zones%>"/></td>
			</tr>
		</table>
			<br>
			<!-- END OF Catalog Setup Section -->
			
			<!--User Setup Section -->
		<table align="center"  style="margin: 0 auto;border: 5px solid #4f758b;box-shadow: 0px 0px 60px #000; behavior: url(PIE.htc);border-radius: 25px;width:90%;text-align:center;padding:10px">
			<tr>
			 	<td class="subTitle" name="userSetup" id="userSetup">User Setup</td>
			 	<td></td>
			 	<td></td>
			 	<td></td>
			</tr>
			<tr>
				<td name="userNamesNS" id="userNamesNS" style="font-size:14px;" width="25%"><strong>Username Example:</strong></td>
				<td width="25%"><input size="30" disabled value="<%=dbUser.nsuserNamesText%>"/></td>
				<td name="userPasswordNS" id="userPasswordNS" style="font-size:14px;"><strong>Passwords Example:</strong></td>
				<td width="25%"><input size="30" disabled value="<%=dbUser.nsuserPasswordText%>"/></td>
			</tr>
			<tr>
				<td name="hidePriceNS" id="hidePriceNS" style="font-size:14px;"><strong>Users with pricing hidden?</strong></td>
				<% if(dbUser.nshidePrice.equals("N")) { %>
				<td><input size="30" disabled value="No"/></td>
				<% } else { %>
				<td><input size="30" disabled value="Yes"/></td>
				<% } %>
				<td name="cleanupFlagNS" id="cleanupFlagNS" style="font-size:14px;"><strong>Disregard User Cleanup?</strong></td>
				<% if(dbUser.nscleanupFlag.equals("N")) { %>
				<td><input disabled value="No"/></td>
				<% } else { %>
				<td><input disabled value="Yes"/></td>
				<% } %>
			</tr>
			<tr>
				<td name="favListNS" id="favListNS" style="font-size:14px;"><strong>Startup Favorite List use?</strong></td>
				<% if(dbUser.nsfavList.equals("N")) { %>
				<td><input size="30" disabled value="No"/></td>
				<% } else { %>
				<td><input size="30" disabled value="Yes"/></td>
				<% } %>
				<td name="favListNoteNS" id="favListNoteNS" style="font-size:14px;"><strong>Favorite List Notes:</strong></td>
				<td><textarea disabled style="width:250px;height:100px;" name="nsfavListNote" id="nsfavListNote"><%=dbUser.nsfavListNote%></textarea></td>
			</tr>
		</table>
		<br>

			<!--END OF User Setup Section -->
			
			<!--Corporate Contact and Approval Rules Section-->
		<table align="center"  style="margin: 0 auto;border: 5px solid #4f758b;box-shadow: 0px 0px 60px #000; behavior: url(PIE.htc);border-radius: 25px;width:90%;text-align:center;padding:10px">
			<tr>
			 	<td class="subTitle" name="contactApprovalNS" id="contactApprovalNS" width="25%">Corporate Contact</td>
			 	<td width="25%"></td>
			 	<td width="25%"></td>
			 	<td width="25%"></td>
			</tr>
			<tr>
				<td name="authContactNS" id="authContactNS" style="font-size:14px;" width="25%"><strong>Corporate Account Contact:</strong></td>
				<td width="25%"><input size="30" disabled value="<%=dbUser.nsauthContact%>"/></td>
				<td width="26%" name="contactEmailNS" id="contactEmailNS" style="font-size:14px;"><strong>Contact Copied on PO Emails:</strong></td>
				<td width="25%"><input size="30" disabled value="<%=dbUser.nsadminEmail%>"/></td>
			</tr>
				<td width="25%"></td>
				<td width="25%"></td>
				<td name="ccLoginNS" id="ccLoginNS" style="font-size:14px;" width="26%"><strong>Contact Copied on Logon Emails:</strong></td>
				<td width="25%"><input size="30" disabled value="<%=dbUser.nsccLogin%>"/></td>
			</tr>
			<tr>
				<td name="corpApprovalNS" id="corpApprovalNS" style="font-size:14px;" width="25%"><strong>Approval Needed for New Users?</strong></td>
				<%if(dbUser.nscorpApproval.equals("1")){%>
				<td width="25%"><input disabled value="Yes"/></td>
				<%}else if (dbUser.nscorpApproval.equals("2")){%>
				<td width="25%"><input disabled value="No"/></td>
				<%} else if (dbUser.nscorpApproval.equals("3")){%>
				<td width="25%"><input disabled value="Not with company email"/></td>
				<%}else{ %>
				<td width="25%"><input disabled value="Company email mandated"/></td>
				<%} %>
				<td name="itemApprovalNS" id="itemApprovalNS" style="font-size:14px;" width="25%"><strong>Approver's Email:</strong></td>
				<td width="25%"><input size="30" disabled value="<%=dbUser.nscontactEmail%>"/></td>
			</tr>
			<tr>
				<td name="itemApprovalNoteNS" id="itemApprovalNoteNS" style="font-size:14px;" width="25%"><strong>Approval Needed for New Item Adds?</strong></td>
				<% if(dbUser.nsitemApproval.equals("1")) { %>
				<td width="25%"><input disabled value="Yes"/></td>
				<%} else if (dbUser.nsitemApproval.equals("2")) { %>
				<td width="25%"><input disabled value="No"/></td>
				<% } else { %>
				<td width="25%"><input disabled value="Mfr. Based"/></td>
				<% } %>
				<td name="adminPOEmailNS" id="adminPOEmailNS" style="font-size:14px;" width="25%"><strong>Approver's Email:</strong></td>
				<td width="25%"><input size="30" disabled value="<%=dbUser.nsitemApprovalNote%>"/></td>
				<td width="25%"></td>
				<td width="25%"></td>
			</tr>
		</table>
		<br>
			<!--END OF Corporate Contact and Approval Rules Section-->

			<!--Account Maintenance Section -->
		<table align="center"  style="margin: 0 auto;border: 5px solid #4f758b;box-shadow: 0px 0px 60px #000; behavior: url(PIE.htc);border-radius: 25px;width:90%;text-align:center;padding:10px">
			

			<!--END OF Account Maintenance Section -->
			
			<!--Account Connectivity Section -->
		<!--  <table  style="border: 5px solid #4f758b;border-radius: 25px;">-->
			<tr>
			 	<td class="subTitle" width="25%" name="acctConnect" id="acctConnect">Account Connectivity Setup</td>
			 	<td></td>
			 	<td></td>
			 	<td></td>
			</tr>
			<tr>
			<%if (dbUser.nsssoCustomer.equals("")) {%>
				<td width="25%" name="ssoCustomerNS" id="ssoCustomerNS" style="font-size:14px;"><strong>SSO Customer?</strong></td>
				<td width="25%"><input disabled value="No"/></td>
				<td width="25%"></td>
				<td width="25%"></td>
			</tr>
			<%} %>
			<%if (dbUser.nsssoCustomer.equals("Y")) {%>
				<td width="25%" name="ssoCustomerNS" id="ssoCustomerNS" style="font-size:14px;"><strong>SSO Customer?</strong></td>
				<td width="25%"><input disabled value="Yes"/></td>
				<td width="25%" name="ssoNotesNS" id="ssoNotesNS">SSO Notes:</td>
				<td width="25%"><textarea style="width:200px;height:130px;" name="nsssoNotes" id="nsssoNotes"></textarea></td>
			</tr>
			<%} %>
			<tr>
			<%if (dbUser.nspunchOut.equals("N")||dbUser.nspunchOut.equals("")) {%>
				<td width="25%" name="punchOutNS" id="punchOutNS" style="font-size:14px;"><strong>NetSupply Punchout?</strong></td>
				<td width="25%"><input disabled value="No"/></td>
				<td width="25%"></td>
				<td width="25%"></td>
			</tr>
			<%} %>
			<%if(dbUser.nspunchOut.equals("Y")){ %>
			<tr>
				<td name="punchOutNS" id="punchOutNS" style="font-size:14px;" width="25%"><strong>NetSupply Punchout?</strong></td>
				<td width="25%"><input disabled value="Yes"/></td>
				<td name="punchOutTypeNS" id="punchOutTypeNS" style="font-size:14px;" width="25%"><strong>Punchout Type (SoldTo or ShipTo)</strong></td>
				<td width="25%"><input disabled value="<%=dbUser.nspunchOutType %>"/></td>
			</tr>
			<tr>				
				<td name="sharedSecretNS" id="sharedSecretNS" style="font-size:14px;" width="25%"><strong>Shared Secret:</strong></td>
				<td width="25%"><input disabled value="<%=dbUser.nssharedSecret%>"/></td>
				<td name="punchoutProviderNS" id="punchoutProviderNS"style="font-size:14px;" width="25%"><strong>Punchout Provider:</strong></td>
				<td width="25%"><input disabled value="<%=dbUser.nspunchoutProvider%>"/></td>
			</tr>
			<tr>
				<td name="providerCodeNS" id="providerCodeNS"style="font-size:14px;" width="25%"><strong>Punchout Provider Code:</strong></td>
				<td width="25%"><input disabled value="<%=dbUser.nsproviderCode %>"/></td>
				<td name="cXmlNS" id="cXmlNS" style="font-size:14px;" width="25%"><strong>cXML Location # Exchanged:</strong></td>
				<td width="25%"><input disabled value="<%=dbUser.nscXml%>"/></td>
			</tr>
			<tr>	
				<td name="fullPunchOutNS" id="fullPunchOutNS" style="font-size:14px;" width="25%"><strong>Full Punchout:</strong></td>
				<% if(dbUser.nsfullPunchOut.equals("N")) { %>
				<td width="25%"><input disabled value="No"/></td>
				<%} else { %>
				<td width="25%"><input disabled value="Yes"/></td>
				<%} %>
				<td name="fullPunchOutNS" id="fullPunchOutNS" width="25%"><strong>Punchout Notes:</strong></td>
				<td width="25%"><input disabled name="nsfullPunchOut" id="nsfullPunchOut" size="20" value="<%=dbUser.nsfullPunchOut%>"/></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<% } %>
			<%if(dbUser.nspunchOut1.equals("Y")){ %>
			<tr>
				<td name="punchOutNS1" id="punchOutNS1" style="font-size:14px;" width="25%"><strong>NetSupply Punchout?</strong></td>
				<td width="25%"><input disabled value="Yes"/></td>
				<td name="punchOutTypeNS1" id="punchOutTypeNS1" style="font-size:14px;" width="25%"><strong>Punchout Type (SoldTo or ShipTo)</strong></td>
				<td width="25%"><input disabled value="<%=dbUser.nspunchOutType1%>"/></td>
			</tr>
			<tr>				
				<td name="sharedSecretNS1" id="sharedSecretNS1" style="font-size:14px;" width="25%"><strong>Shared Secret:</strong></td>
				<td width="25%"><input disabled value="<%=dbUser.nssharedSecret1%>"/></td>
				<td name="punchoutProviderNS1" id="punchoutProviderNS1"style="font-size:14px;" width="25%"><strong>Punchout Provider:</strong></td>
				<td width="25%"><input disabled value="<%=dbUser.nspunchoutProvider1%>"/></td>
			</tr>
			<tr>
				<td name="providerCodeNS1" id="providerCodeNS1"style="font-size:14px;" width="25%"><strong>Punchout Provider Code:</strong></td>
				<td width="25%"><input disabled value="<%=dbUser.nsproviderCode1%>"/></td>
				<td name="cXmlNS" id="cXmlNS" style="font-size:14px;" width="25%"><strong>cXML Location # Exchanged:</strong></td>
				<td width="25%"><input disabled value="<%=dbUser.nscXml1%>"/></td>
			</tr>
			<tr>	
				<td name="fullPunchOutNS1" id="fullPunchOutNS1" style="font-size:14px;" width="25%"><strong>Full Punchout:</strong></td>
				<% if(dbUser.nsfullPunchOut1.equals("N")) { %>
				<td width="25%"><input disabled value="No"/></td>
				<%} else { %>
				<td width="25%"><input disabled value="Yes"/></td>
				<%} %>
				<td name="fullPunchOutNS1" id="fullPunchOutNS1" width="25%"><strong>Punchout Notes:</strong></td>
				<td width="25%"><input disabled name="nsfullPunchOut1" id="nsfullPunchOut1" size="20" value="<%=dbUser.nsfullPunchOut1%>"/></td>
			</tr>
			<% } %>
			<!-- <tr>
			 	<td class="subTitle" name="acctMaint" id="acctMaint">Account Maintenance Setup</td>
			 	<td></td>
			 	<td></td>
			 	<td></td>
			</tr>
		<br> -->
			
		</table>
		<br>
			<!--END OF Account Connectivity Section -->
<%	} 



}%>
		<!-- <table style="border:0px;"> -->
		<br>
		



<% 
//} 

%>
		
		</div>
	</div>

</form>






</body>
</html>