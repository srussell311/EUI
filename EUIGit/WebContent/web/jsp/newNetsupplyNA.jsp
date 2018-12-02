<html>
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <style type="text/css">
            html.js .nojs { display: none; }
        </style>
  <script type="text/javascript">
  	function hide(){
  		document.documentElement.className += ' js';
  	}
  </script>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        
  <script>
$(document).ready(function() {
	var $datepicker = $('#ui-datepicker-div');
    $("#nslaunchDate").datepicker();
        var nslaunchDate = $("#nslaunchDate").val();

});

</script>
<script>document.body.className='js;'</script>
<style>
.ui-datepicker {
	 position: absolute !important;
    top: 540px !important;
    left: 400px !important;

}
</style>
</head>
<%@ include file="banner.jsp"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>
<%@ page import="java.util.Calendar"%>
<body id="wrapper" onload="Hide()">
<%
System.out.println("PLatform = "+dbUser.orderSource);
String actionType = (String)request.getParameter("actionType");
//System.out.println(actionType);
String orderSource = request.getParameter("orderSource");
if(orderSource == null){
	orderSource = "";
}
String catalogView = request.getParameter("catalogView");
System.out.println(catalogView);
dbUser.nscatView = (String)request.getSession().getAttribute("catalogView");
System.out.println("Catalog View only? ="+dbUser.nscatView);

//System.out.println("Catalog View only? ="+dbUser.nscatView);
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
			document.newAcct.page.value="viewNA.jsp";
			document.newAcct.submit();
	}

	function Hide(){
		
			///////////////Start of first display
			document.getElementById('netsupplySetup').style.display = "block";
			document.getElementById('netSetup').style.display = "block";
			document.getElementById('acctSetupNS').style.display = "block";
			document.getElementById('ddmtNS').style.display = "block";
			document.getElementById('nsddMT').style.display = "block";
			document.getElementById('custLocNS').style.display = "block";
			document.getElementById('nscustLocNbr').style.display = "block";
			document.getElementById('custURLNS').style.display = "block";
			document.getElementById('nscustURL').style.display = "block";
			document.getElementById('launchDateNS').style.display = "block";
			document.getElementById('nslaunchDate').style.display = "block";
			document.getElementById('specNotesNS').style.display = "block";
			document.getElementById('nsaddNotes').style.display = "block";
			document.getElementById('catalogSetup').style.display = "block";
			document.getElementById('catSetup').style.display = "block";
			document.getElementById('imgUsedNS').style.display = "block";
			document.getElementById('nsimgUsed').style.display = "block";
			document.getElementById('enrichmentNS').style.display = "block";
			document.getElementById('nsenrichMent').style.display = "block";
			document.getElementById('dualOrdGuideNS').style.display = "block";
			document.getElementById('nsdualOrdGuide').style.display = "block";
			document.getElementById('sDsNS').style.display = "block";
			document.getElementById('nssDs').style.display = "block";
			document.getElementById('barCodesNS').style.display = "block";
			document.getElementById('nsbarCodes').style.display = "block";
			document.getElementById('cancelnetSetup').style.display = "block";
			document.getElementById('netSetupStep').style.display = "block";
			
			//////////////////////////////////////document.getElementById("usrSetup").style.display = 'none'; 
			
			/*document.getElementById("usrSetup").style.display = 'none'; 
			document.getElementById("corpCont").style.display = 'none'; 
			document.getElementById("accountMain").style.display = 'none'; 
			document.getElementById("saveCancel").style.display = 'none'; 
			document.getElementById('netSetupStep1').style.display = "none";
			document.getElementById('netSetupStep1Back').style.display = "none";*/
			///////////////////End of first display
			                  /////User Setup Section//////
			document.getElementById('usrSetup').style.display = "none";
			document.getElementById('userSetup').style.display = "none";
			document.getElementById('userNamesTextNS').style.display = "none";
			document.getElementById('nsuserNamesText').style.display = "none";
			document.getElementById('userPasswordTextNS').style.display = "none";
			document.getElementById('nsuserPasswordText').style.display = "none";
			document.getElementById('favListNS').style.display = "none";
			document.getElementById('nsfavList').style.display = "none";
			document.getElementById('favListNoteNS').style.display = "none";
			document.getElementById('nsfavListNote').style.display = "none";
			document.getElementById('favListNS').style.display = "none";
			document.getElementById('nsfavList').style.display = "none";
			//document.getElementById('netSetupStep2').style.display = "none";
			//document.getElementById('netSetupStep2Back').style.display = "none";
			             //////Corporate Contact Section//////////
			document.getElementById('corpCont').style.display = "none";
			document.getElementById('contactApprovalNS').style.display = "none";
			document.getElementById('authContactNS').style.display = "none";
			document.getElementById('nsauthContact').style.display = "none";
			document.getElementById('adminEmailNS').style.display = "none";
			document.getElementById('nsadminEmail').style.display = "none";
			document.getElementById('ccLoginNS').style.display = "none";
			document.getElementById('nsccLogin').style.display = "none";
			document.getElementById('corpApprovalNS').style.display = "none";
			document.getElementById('nscorpApproval').style.display = "none";
			document.getElementById('contactEmailNS').style.display = "none";
			document.getElementById('nscontactEmail').style.display = "none";
			document.getElementById('itemApprovalNS').style.display = "none";
			document.getElementById('nsitemApproval').style.display = "none";
			document.getElementById('itemApprovalNoteNS').style.display = "none";
			document.getElementById('nsitemApprovalNote').style.display = "none";
			document.getElementById('netSetupStep1').style.display = "none";
			document.getElementById('netSetupStep1Back').style.display = "none";
			//////////Account Maintenance & Acct. Connectivity
			document.getElementById('accountMain').style.display = "none";
			document.getElementById('acctMaint').style.display = "none";
			document.getElementById('cleanupFlagNS').style.display = "none";
			document.getElementById('nscleanupFlag').style.display = "none";
			document.getElementById('acctConnect').style.display = "none";
			document.getElementById('ssoCustomerNS').style.display = "none";
			document.getElementById('nsssoCustomer').style.display = "none";
			document.getElementById('ssoNotesNS').style.display = "none";
			document.getElementById('nsssoNotes').style.display = "none";
			document.getElementById('punchOutNS').style.display = "none";
			document.getElementById('nspunchOut').style.display = "none";
			document.getElementById('networkIDNS').style.display = "none";
			document.getElementById('nsnetworkID').style.display = "none";
			document.getElementById('customerIDNS').style.display = "none";
			document.getElementById('nscustomerID').style.display = "none";
			document.getElementById('sharedSecretNS').style.display = "none";
			document.getElementById('nssharedSecret').style.display = "none";
			document.getElementById('punchoutProviderNS').style.display = "none";
			document.getElementById('nspunchoutProvider').style.display = "none";
			document.getElementById('providerCodeNS').style.display = "none";
			document.getElementById('nsproviderCode').style.display = "none";
			document.getElementById('cXmlNS').style.display = "none";
			document.getElementById('nscXml').style.display = "none";
			document.getElementById('fullPunchOutNS').style.display = "none";
			document.getElementById('nsfullPunchOut').style.display = "none";
			document.getElementById('netSetupStep3Back').style.display = "none";
			document.getElementById('SubmitNS').style.display = "none";
			document.getElementById('CancelNS').style.display = "none";
			
		}

		function netSupply(){
			var source = document.getElementById('netSetupStep').value;
			
			if(document.newAcct.netSetupStep.value=="Next>>"||document.newAcct.netSetupStep.value=="<<Back"){
				
				document.getElementById('netsupplySetup').style.display = "block";
				document.getElementById('netSetup').style.display = "none";
				document.getElementById('acctSetupNS').style.display = "none";
				document.getElementById('ddmtNS').style.display = "none";
				document.getElementById('nsddMT').style.display = "none";
				document.getElementById('custLocNS').style.display = "none";
				document.getElementById('nscustLocNbr').style.display = "none";
				document.getElementById('custURLNS').style.display = "none";
				document.getElementById('nscustURL').style.display = "none";
				document.getElementById('launchDateNS').style.display = "none";
				document.getElementById('nslaunchDate').style.display = "none";
				document.getElementById('specNotesNS').style.display = "none";
				document.getElementById('nsaddNotes').style.display = "none";
				document.getElementById('catalogSetup').style.display = "none";
				document.getElementById('catSetup').style.display = "none";
				document.getElementById('imgUsedNS').style.display = "none";
				document.getElementById('nsimgUsed').style.display = "none";
				document.getElementById('enrichmentNS').style.display = "none";
				document.getElementById('nsenrichMent').style.display = "none";
				document.getElementById('dualOrdGuideNS').style.display = "none";
				document.getElementById('nsdualOrdGuide').style.display = "none";
				document.getElementById('sDsNS').style.display = "none";
				document.getElementById('nssDs').style.display = "none";
				document.getElementById('barCodesNS').style.display = "none";
				document.getElementById('nsbarCodes').style.display = "none";
				document.getElementById('cancelnetSetup').style.display = "none";
				document.getElementById('netSetupStep').style.display = "none";
				///////////////////Start of second display
				                  /////User Setup Section//////
				document.getElementById('usrSetup').style.display = "block";
				document.getElementById('userSetup').style.display = "block";
				document.getElementById('userNamesTextNS').style.display = "block";
				document.getElementById('nsuserNamesText').style.display = "block";
				document.getElementById('userPasswordTextNS').style.display = "block";
				document.getElementById('nsuserPasswordText').style.display = "block";
				document.getElementById('favListNS').style.display = "block";
				document.getElementById('nsfavList').style.display = "block";
				document.getElementById('favListNoteNS').style.display = "block";
				document.getElementById('nsfavListNote').style.display = "block";
				document.getElementById('favListNS').style.display = "block";
				document.getElementById('nsfavList').style.display = "block";
				//document.getElementById('netSetupStep2').style.display = "none";
				//document.getElementById('netSetupStep2Back').style.display = "none";
				             //////Corporate Contact Section//////////
				document.getElementById('corpCont').style.display = "block";
				document.getElementById('contactApprovalNS').style.display = "block";
				document.getElementById('authContactNS').style.display = "block";
				document.getElementById('nsauthContact').style.display = "block";
				document.getElementById('adminEmailNS').style.display = "block";
				document.getElementById('nsadminEmail').style.display = "block";
				document.getElementById('ccLoginNS').style.display = "block";
				document.getElementById('nsccLogin').style.display = "block";
				document.getElementById('corpApprovalNS').style.display = "block";
				document.getElementById('nscorpApproval').style.display = "block";
				document.getElementById('contactEmailNS').style.display = "none";
				document.getElementById('nscontactEmail').style.display = "none";
				document.getElementById('itemApprovalNS').style.display = "block";
				document.getElementById('nsitemApproval').style.display = "block";
				document.getElementById('itemApprovalNoteNS').style.display = "none";
				document.getElementById('nsitemApprovalNote').style.display = "none";
				document.getElementById('netSetupStep1').style.display = "block";
				document.getElementById('netSetupStep1Back').style.display = "block";
				//////End of Second display
				//////////Account Maintenance & Acct. Connectivity
				document.getElementById('accountMain').style.display = "none";
				document.getElementById('acctMaint').style.display = "none";
				document.getElementById('cleanupFlagNS').style.display = "none";
				document.getElementById('nscleanupFlag').style.display = "none";
				document.getElementById('acctConnect').style.display = "none";
				document.getElementById('ssoCustomerNS').style.display = "none";
				document.getElementById('nsssoCustomer').style.display = "none";
				document.getElementById('ssoNotesNS').style.display = "none";
				document.getElementById('nsssoNotes').style.display = "none";
				document.getElementById('punchOutNS').style.display = "none";
				document.getElementById('nspunchOut').style.display = "none";
				document.getElementById('networkIDNS').style.display = "none";
				document.getElementById('nsnetworkID').style.display = "none";
				document.getElementById('customerIDNS').style.display = "none";
				document.getElementById('nscustomerID').style.display = "none";
				document.getElementById('sharedSecretNS').style.display = "none";
				document.getElementById('nssharedSecret').style.display = "none";
				document.getElementById('punchoutProviderNS').style.display = "none";
				document.getElementById('nspunchoutProvider').style.display = "none";
				document.getElementById('providerCodeNS').style.display = "none";
				document.getElementById('nsproviderCode').style.display = "none";
				document.getElementById('cXmlNS').style.display = "none";
				document.getElementById('nscXml').style.display = "none";
				document.getElementById('fullPunchOutNS').style.display = "none";
				document.getElementById('nsfullPunchOut').style.display = "none";
				document.getElementById('netSetupStep3Back').style.display = "none";
				document.getElementById('SubmitNS').style.display = "none";
				document.getElementById('CancelNS').style.display = "none";	

			}
		}
		
		function netSupply1(){
			var source = document.getElementById('netSetupStep1').value;
			//alert("Next Button Value ="+source)
			
			if(document.newAcct.netSetupStep1.value=="Next>>"||document.newAcct.netSetupStep.value=="<<Back"){
				document.getElementById('netsupplySetup').style.display = "block";
				document.getElementById('netSetup').style.display = "none";
				document.getElementById('acctSetupNS').style.display = "none";
				document.getElementById('ddmtNS').style.display = "none";
				document.getElementById('nsddMT').style.display = "none";
				document.getElementById('custLocNS').style.display = "none";
				document.getElementById('nscustLocNbr').style.display = "none";
				document.getElementById('custURLNS').style.display = "none";
				document.getElementById('nscustURL').style.display = "none";
				document.getElementById('launchDateNS').style.display = "none";
				document.getElementById('nslaunchDate').style.display = "none";
				document.getElementById('specNotesNS').style.display = "none";
				document.getElementById('nsaddNotes').style.display = "none";
				document.getElementById('catalogSetup').style.display = "none";
				document.getElementById('catSetup').style.display = "none";
				document.getElementById('imgUsedNS').style.display = "none";
				document.getElementById('nsimgUsed').style.display = "none";
				document.getElementById('enrichmentNS').style.display = "none";
				document.getElementById('nsenrichMent').style.display = "none";
				document.getElementById('dualOrdGuideNS').style.display = "none";
				document.getElementById('nsdualOrdGuide').style.display = "none";
				document.getElementById('sDsNS').style.display = "none";
				document.getElementById('nssDs').style.display = "none";
				document.getElementById('barCodesNS').style.display = "none";
				document.getElementById('nsbarCodes').style.display = "none";
				document.getElementById('cancelnetSetup').style.display = "none";
				document.getElementById('netSetupStep').style.display = "none";
				///////////////////Start of second display
				                  /////User Setup Section//////
				document.getElementById('usrSetup').style.display = "none";
				document.getElementById('userSetup').style.display = "none";
				document.getElementById('userNamesTextNS').style.display = "none";
				document.getElementById('nsuserNamesText').style.display = "none";
				document.getElementById('userPasswordTextNS').style.display = "none";
				document.getElementById('nsuserPasswordText').style.display = "none";
				document.getElementById('favListNS').style.display = "none";
				document.getElementById('nsfavList').style.display = "none";
				document.getElementById('favListNoteNS').style.display = "none";
				document.getElementById('nsfavListNote').style.display = "none";
				document.getElementById('favListNS').style.display = "none";
				document.getElementById('nsfavList').style.display = "none";
				//document.getElementById('netSetupStep2').style.display = "none";
				//document.getElementById('netSetupStep2Back').style.display = "none";
				             //////Corporate Contact Section//////////
				document.getElementById('corpCont').style.display = "none";
				document.getElementById('contactApprovalNS').style.display = "none";
				document.getElementById('authContactNS').style.display = "none";
				document.getElementById('nsauthContact').style.display = "none";
				document.getElementById('adminEmailNS').style.display = "none";
				document.getElementById('nsadminEmail').style.display = "none";
				document.getElementById('ccLoginNS').style.display = "none";
				document.getElementById('nsccLogin').style.display = "none";
				document.getElementById('corpApprovalNS').style.display = "none";
				document.getElementById('nscorpApproval').style.display = "none";
				document.getElementById('contactEmailNS').style.display = "none";
				document.getElementById('nscontactEmail').style.display = "none";
				document.getElementById('itemApprovalNS').style.display = "none";
				document.getElementById('nsitemApproval').style.display = "none";
				document.getElementById('itemApprovalNoteNS').style.display = "none";
				document.getElementById('nsitemApprovalNote').style.display = "none";
				document.getElementById('netSetupStep1').style.display = "none";
				document.getElementById('netSetupStep1Back').style.display = "none";
				//////End of Second display
				//////////Account Maintenance & Acct. Connectivity
				document.getElementById('accountMain').style.display = "block";
				document.getElementById('acctMaint').style.display = "block";
				document.getElementById('cleanupFlagNS').style.display = "block";
				document.getElementById('nscleanupFlag').style.display = "block";
				document.getElementById('acctConnect').style.display = "block";
				document.getElementById('ssoCustomerNS').style.display = "block";
				document.getElementById('nsssoCustomer').style.display = "block";
				document.getElementById('ssoNotesNS').style.display = "none";
				document.getElementById('nsssoNotes').style.display = "none";
				document.getElementById('punchOutNS').style.display = "block";
				document.getElementById('nspunchOut').style.display = "block";
				document.getElementById('networkIDNS').style.display = "none";
				document.getElementById('nsnetworkID').style.display = "none";
				document.getElementById('customerIDNS').style.display = "none";
				document.getElementById('nscustomerID').style.display = "none";
				document.getElementById('sharedSecretNS').style.display = "none";
				document.getElementById('nssharedSecret').style.display = "none";
				document.getElementById('punchoutProviderNS').style.display = "none";
				document.getElementById('nspunchoutProvider').style.display = "none";
				document.getElementById('providerCodeNS').style.display = "none";
				document.getElementById('nsproviderCode').style.display = "none";
				document.getElementById('cXmlNS').style.display = "none";
				document.getElementById('nscXml').style.display = "none";
				document.getElementById('fullPunchOutNS').style.display = "none";
				document.getElementById('nsfullPunchOut').style.display = "none";
				document.getElementById('netSetupStep3Back').style.display = "block";
				document.getElementById('SubmitNS').style.display = "block";
				document.getElementById('CancelNS').style.display = "block";
				
			}
		}
		
		function SSO(){
			if(document.newAcct.nsssoCustomer.value=="Y"){
				document.getElementById("nspunchOut").disabled = true;
				document.getElementById('ssoNotesNS').style.display = "block";
				document.getElementById('nsssoNotes').style.display = "block";
			}
			if(document.newAcct.nsssoCustomer.value=="N"){
				document.getElementById("nspunchOut").disabled = false;
				document.getElementById('ssoNotesNS').style.display = "none";
				document.getElementById('nsssoNotes').style.display = "none";
			}
		}
		
		function getNetSupplyPunchOut(){
			
			var punchOut = document.getElementById('nspunchOut').value;
			//alert(punchOut)
			
			if(document.newAcct.nspunchOut.value=="Y"){
			document.getElementById("nsssoCustomer").disabled = true;
			document.getElementById('networkIDNS').style.display = "block";
			document.getElementById('nsnetworkID').style.display = "block";
			document.getElementById('customerIDNS').style.display = "block";
			document.getElementById('nscustomerID').style.display = "block";
			document.getElementById('sharedSecretNS').style.display = "block";
			document.getElementById('nssharedSecret').style.display = "block";
			document.getElementById('punchoutProviderNS').style.display = "block";
			document.getElementById('nspunchoutProvider').style.display = "block";
			document.getElementById('providerCodeNS').style.display = "block";
			document.getElementById('nsproviderCode').style.display = "block";
			document.getElementById('cXmlNS').style.display = "block";
			document.getElementById('nscXml').style.display = "block";
			document.getElementById('fullPunchOutNS').style.display = "block";
			document.getElementById('nsfullPunchOut').style.display = "block";
			}
			if(document.newAcct.nspunchOut.value=="N"){
				document.getElementById("nsssoCustomer").disabled = false;
				document.getElementById('networkIDNS').style.display = "none";
				document.getElementById('nsnetworkID').style.display = "none";
				document.getElementById('customerIDNS').style.display = "none";
				document.getElementById('nscustomerID').style.display = "none"
				document.getElementById('sharedSecretNS').style.display = "none";
				document.getElementById('nssharedSecret').style.display = "none";
				document.getElementById('punchoutProviderNS').style.display = "none";
				document.getElementById('nspunchoutProvider').style.display = "none";
				document.getElementById('providerCodeNS').style.display = "none";
				document.getElementById('nsproviderCode').style.display = "none";
				document.getElementById('cXmlNS').style.display = "none";
				document.getElementById('nscXml').style.display = "none";
				document.getElementById('fullPunchOutNS').style.display = "none";
				document.getElementById('nsfullPunchOut').style.display = "none";
				}
		}
		
		function getUserApproval(){
			var newUserApproval = document.getElementById('nscorpApproval').value;
			//alert(newUserApproval)
			
			if(document.newAcct.nscorpApproval.value != "2"){
				document.getElementById('contactEmailNS').style.display = "block";
				document.getElementById('nscontactEmail').style.display = "block";
			}
			if(document.newAcct.nscorpApproval.value == "2"){
				document.getElementById('contactEmailNS').style.display = "none";
				document.getElementById('nscontactEmail').style.display = "none";
			}
			
		}
		
		function getItemApproval(){
			var itemApproval = document.getElementById('nsitemApproval').value;
			//alert(passwordGeneric)
			
			if(document.newAcct.nsitemApproval.value != "2"){
				document.getElementById('itemApprovalNoteNS').style.display = "block";
				document.getElementById('nsitemApprovalNote').style.display = "block";
			}
			if(document.newAcct.nsitemApproval.value == "2"){
				document.getElementById('itemApprovalNoteNS').style.display = "none";
				document.getElementById('nsitemApprovalNote').style.display = "none";
			}
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
<!--  <script language=JavaScript type="text/javascript" src="web/jsp/calendar2.jsp"></script>-->




<%@ include file="navMenu.jsp"%>
<form action="ControllerServlet?page=newNetsupplyNA.jsp" method="post" name="newAcct" onSubmit="return (disableSubmit() & disableCancel());">
<script type="text/javascript">
//alert("form load")
     //hide(); 
   </script>
	<input type=hidden name='actionType' value=""> <input type=hidden name='page' value=""><input type="hidden" name='routeToViewDtl' id='routeToViewDtl' value="viewNADtl"/>
	<div id="inputField">

		<span class="subTitle">New National Account</span> <br /> <br />
		<div id="centerTable">

		<!--  <table border="0" cellpadding="0" width="100%">-->
		<!--  <table style="margin-left:auto;margin-right:auto;">-->

			<% if (actionType.equals("NewNANetSupply")) {%>
			
			<tr>
				<td style="font-size:14px;"><strong>National Account:</strong></td>
				<td name="natAcct" id="natAcct" value="<%=dbUser.nationalAccountNbr%>"> <%=dbUser.nationalAccountNbr%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td style="font-size:14px;"><strong>Order Source:</strong></td>
				<td name="orderSource" id="orderSource" value="<%=dbUser.orderSource%>"><%=dbUser.orderSource%></td>
			</tr>
		<!--  </table>-->
			<br>
			<br>
				<%if((!dbUser.orderSource.equals("NetSupply")) & (dbUser.nscatView.equals("Y"))){ %>
			 	<p valign="top" style="postion:absolute;padding:-200px 0px 0px 0px" class="subTitle" name="netsupplySetup" id="netsupplySetup"><strong>EDI Platform NetSupply Catalog Setup</strong></p>
			 	<%} else { %>
				<p valign="top" style="postion:absolute;padding:-200px 0px 0px 0px" class="subTitle" name="netsupplySetup" id="netsupplySetup"><strong>NetSupply Setup</strong></p>
				<%} %>
			<!--Account Setup Section -->
		<table name="netSetup" id="netSetup" style="">
			<tr>
			 	<td class="subTitle" name="acctSetupNS" id="acctSetupNS">Account Setup</td>
			 	<td></td>
			</tr>
			<!--  <tr>
				<td name="catView" id="catView">Catalog View Only Account?</td>
				<%//if(dbUser.nscatView.equals("N")){%>
				<td><select name="nscatView" id="nscatView">
				<option value="N" selected>No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%//} else { %>
				<td><select name="nscatView" id="nscatView">
				<option value="Y" selected>Yes</option>
				<option value="N">No</option>
				</select></td>
				<% //} %>
			</tr>-->
			<tr>
				<td name="ddmtNS" id="ddmtNS">DDMT Used?</td>
				<%if(dbUser.nscatView.equals("N")){ %>
				<td><select name="nsddMT" id="nsddMT">
				<option selected value="Y">Yes</option>
				<option value="N">No</option>
				</select></td>
				<%} else{ %>
				<td><select name="nsddMT" id="nsddMT">
				<option selected value="N">No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%} %>
			</tr>
			<tr>
				<td name="custLocNS" id="custLocNS">Display Customer Location Number?</td>
				<td><select name="nscustLocNbr" id="nscustLocNbr">
				<option selected value="N">No</option>
				<option value="Y">Yes</option>
				</select></td>
			</tr>
			<tr>
				<td name="custURLNS" id="custURLNS">URL posted to Customers Intranet?</td>
				<td><select name="nscustURL" id="nscustURL">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
			</tr>
			<tr>
				<td name="launchDateNS" id="launchDateNS">NetSupply Launch Date:</td>
				<div id="datepicker">
				<td><input type="text" readonly="true" id="nslaunchDate" name="nslaunchDate"/></div>   
				</td>
			</tr>
			<tr>
				<td name="specNotesNS" id="specNotesNS">Special Setup Notes:</td>
				<td><textarea name="nsaddNotes" id="nsaddNotes"></textarea></td>
			</tr>
		</table>
		<!-- </div> -->
		<br>
			<!--END OF Account Setup Section -->
			
			<!--Catalog Setup Section -->
	<!--<div style="position:absolute;padding:0px 0px 0px 625px">  -->
		<table name="catalogSetup" id="catalogSetup" style="">
			<tr>
			 	<td class="subTitle" name="catSetup" id="catSetup">Catalog Setup</td>
			 	<td></td>
			</tr>
			<tr>
				<td name="imgUsedNS" id="imgUsedNS">Item Images Used?</td>
				<td><select name="nsimgUsed" id="nsimgUsed">
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
			</tr>
			<tr>
				<td name="enrichmentNS" id="enrichmentNS">Item Enrichment?</td>
				<td><select name="nsenrichMent" id="nsenrichMent">
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
			</tr>
			<tr>
				<td name="dualOrdGuideNS" id="dualOrdGuideNS">Dual Order Guide Setup?</td>
				<td><select name="nsdualOrdGuide" id="nsdualOrdGuide">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
			</tr>			
			<!--  <tr>  This is now the catalog view button value
				<td name="catViewNS" id="catViewNS">Catalog Viewing Only Account?</td>
				<td><select name="nscatView" id="nscatView">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
			</tr>-->
			<tr>
				<td name="sDsNS" id="sDsNS">SDS Provided?</td>
				<td><select name="nssDs" id="nssDs">
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
			</tr>
			<tr>
				<td name="barCodesNS" id="barCodesNS">Barcodes Available?</td>
				<td><select name="nsbarCodes" id="nsbarCodes">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
			</tr>
			</table>
			<!-- </div>	 -->
			<br>
			<input type="button" name="cancelnetSetup" id="cancelnetSetup" style="position:absolute;top:560px;left:535px;right:0px;bottom:0px;width: 100px;height:25px;" value="Cancel" onClick="window.location='ControllerServlet?page=newNA.jsp&actionType=NewNA';" />
			<input name="netSetupStep" id="netSetupStep" style="position:absolute;top:560px;left:655px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="Next>>" onclick="javascript:netSupply()"/><!--</p> -->
			
			<!-- END OF Catalog Setup Section -->
			
			<!--User Setup Section -->
<div class="nojs">
	<!-- <div style="position:absolute;padding:487px 0px 0px 150px"> -->
		<table name="usrSetup" id="usrSetup" style="">
			<tr>
			 	<td class="subTitle" name="userSetup" id="userSetup">User Setup</td>
			 	<td></td>
			 	<td></td>
			 	<td></td>
			</tr>
			<tr>
				<td name="userNamesTextNS" id="userNamesTextNS">Username Example:</td>
				<td><input name="nsuserNamesText" id="nsuserNamesText"/></td>
				<td name="userPasswordTextNS" id="userPasswordTextNS">Password Example:</td>
				<td><input name="nsuserPasswordText" id="nsuserPasswordText"/></td>
				
			</tr>
			<tr>
			<td name="favListNS" id="favListNS">Startup Favorite List use?</td>
				<td><select name="nsfavList" id="nsfavList" onchange="javascript:Function()">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
				<td name="favListNoteNS" id="favListNoteNS">Favorite List Notes:</td>
				<td><textarea name="nsfavListNote" id="nsfavListNote"></textarea></td>
			</tr>
			<!-- display is yes to favorite list text box -->
			<tr>
				
			</tr>
			<!-- end of favorite list text box -->

		</table>
		<!--</div>-->
		<br>
		<!--<input name="netSetupStep2Back" id="netSetupStep2Back" style="position:absolute;top:525px;left:535px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="<<Back" onclick="javascript:netSupply()"/>
		<input name="netSetupStep2" id="netSetupStep2" style="position:absolute;top:525px;left:655px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="Next>>" onclick="javascript:netSupply2()"/>-->
		
			
			<!--Corporate Contact and Approval Rules Section-->
	<!--  <div style="position:absolute;padding:250px 0px 0px 150px">-->
	
		<table name="corpCont" id="corpCont" style="">
			<tr>
			 	<td class="subTitle" name="contactApprovalNS" id="contactApprovalNS">Corporate Contact and Approval Rules</td>
			 	<td></td>
			</tr>
			<tr>
				<td name="authContactNS" id="authContactNS">Corporate Account Contact:</td>
				<td><input name="nsauthContact" id="nsauthContact" size="50"/></td>
			</tr>
			<tr>
				<td name="adminEmailNS" id="adminEmailNS">Corporate Account Contact Copied on PO Emails:</td>
				<td><input name="nsadminEmail" id="nsadminEmail" size="50"/></td>
			</tr>
			<tr>
				<td name="ccLoginNS" id="ccLoginNS">Corporate Account Contact Copied on Logon Emails:</td>
				<td><input name="nsccLogin" id="nsccLogin" size="50"/></td>
			</tr>
			<tr>
				<td name="corpApprovalNS" id="corpApprovalNS" >Approval Needed for New Users?</td>
				<td><select name="nscorpApproval" id="nscorpApproval" onchange="javascript:getUserApproval()">
					<option value="2" selected>No</option>
					<option value="1">Yes</option>
					<option value="3">Not with company email</option>
					<option value="4">Company email mandated</option>
				</select></td>
			</tr>
			<tr>
				<td name="contactEmailNS" id="contactEmailNS">Approver's Email:</td>
				<td><input name="nscontactEmail" id="nscontactEmail" size="50"/></td>
			</tr>
			<tr>
				<td name="itemApprovalNS" id="itemApprovalNS" >Approval Needed for New Item Adds?</td>
				<td><select name="nsitemApproval" id="nsitemApproval" onchange="javascript:getItemApproval()">
					<option value="2" selected>No</option>
					<option value="1">Yes</option>
					<option value="3">Mfr. Based</option>
				</select></td>
			</tr>
			<tr>
				<td name="itemApprovalNoteNS" id="itemApprovalNoteNS">Approver's Email:</td>
				<td><input name="nsitemApprovalNote" id="nsitemApprovalNote" size="50"/></td>
			</tr>
		</table>
		<!-- </div> -->
		<br>
		<input name="netSetupStep1Back" id="netSetupStep1Back" style="position:absolute;top:660px;left:535px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="<<Back" onclick="javascript:Hide()"/>
		<input name="netSetupStep1" id="netSetupStep1" style="position:absolute;top:660px;left:655px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="Next>>" onclick="javascript:netSupply1()"/>
			<!--END OF Corporate Contact and Approval Rules Section-->
	
	
			
		
			<!--END OF User Setup Section -->
	
			<!--Account Maintenance Section -->
	<!-- <div style="position:absolute;padding:687px 0px 0px 150px"> -->
		<table name="accountMain" id="accountMain" >
			<tr>
			 	<td class="subTitle" name="acctMaint" id="acctMaint">Account Maintenance</td>
			 	<td></td>
			</tr>
			<tr>
				<td name="cleanupFlagNS" id="cleanupFlagNS">Disregard User Cleanup?</td>
				<%if(dbUser.nscatView.equals("N")){ %>
				<td><select name="nscleanupFlag" id="nscleanupFlag">
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
				<%} else { %>
				<td><select name="nscleanupFlag" id="nscleanupFlag">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
				<% } %>
			</tr>
		<!--  </table>-->
	<!--</div>-->
		<br>
			<!--END OF Account Maintenance Section -->

			<tr>
			 	<td class="subTitle" name="acctConnect" id="acctConnect">Account Connectivity</td>
			 	<td></td>
			</tr>
			<tr>
				<td name="ssoCustomerNS" id="ssoCustomerNS">SSO Customer?</td>
				<td><select name="nsssoCustomer" id="nsssoCustomer" onchange="javascript:SSO()">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
			</tr>
			<tr>
				<td name="ssoNotesNS" id="ssoNotesNS">SSO Notes:</td>
				<td><textarea style="width:200px;height:130px;" name="nsssoNotes" id="nsssoNotes"></textarea></td>
			</tr>
			<tr>
				<td name="punchOutNS" id="punchOutNS">NetSupply Punchout?</td>
				<td><select name="nspunchOut" id="nspunchOut" onchange="javascript:getNetSupplyPunchOut()">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
			</tr>
			<tr>
				<td name="networkIDNS" id="networkIDNS">Network Identity:</td>
				<td><input name="nsnetworkID" id="nsnetworkID"/></td>
			</tr>
			<tr>
				<td name="customerIDNS" id="customerIDNS">Customer Identity:</td>
				<td><input name="nscustomerID" id="nscustomerID"/></td>
			</tr>
			<tr>
				<td name="sharedSecretNS" id="sharedSecretNS">Shared Secret:</td>
				<td><input name="nssharedSecret" id="nssharedSecret"/></td>
			</tr>
			<tr>
				<td name="punchoutProviderNS" id="punchoutProviderNS">Punchout Provider:</td>
				<td><input name="nspunchoutProvider" id="nspunchoutProvider"/></td>
			</tr>
			<tr>
				<td name="providerCodeNS" id="providerCodeNS">Punchout Provider Code:</td>
				<td><input name="nsproviderCode" id="nsproviderCode"/></td>
			</tr>
			<tr>
				<td name="cXmlNS" id="cXmlNS">cXML Location # Exchanged:</td>
				<td><input name="nscXml" id="nscXml"/></td>
			</tr>
			<tr>
				<td name="fullPunchOutNS" id="fullPunchOutNS">Punchout Notes:</td>
				<td><textarea style="height:125px;" name="nsfullPunchOut" id="nsfullPunchOut" size="20"></textarea></td>
			</tr>
		</table>
		<br>
			<!--END OF Account Connectivity Section -->
<%//} %>
		<table id="saveCancel" name="saveCancel">
			<tr>
				<td><input name="netSetupStep3Back" id="netSetupStep3Back" style="position:absolute;top:680px;left:460px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="<<Back" onclick="javascript:netSupply()"/></td>
				<td></td>
			</tr>
			<tr>
			<td><input type="button" name="CancelNS" id="CancelNS" style="position:absolute;top:680px;left:650px;right:0px;bottom:0px;width: 100px;height:25px;" value="Cancel" onClick="window.location='ControllerServlet?page=newNA.jsp&actionType=NewNA';" /></td>
				<td><input type="button" name="SubmitNS" id="SubmitNS" style="position:absolute;top:680px;left:760px;right:0px;bottom:0px;width: 100px;height:25px;" value="Save" onclick="javascript:SaveAccount()"/></td>
				
			</tr>
		</table>

		<input name="typeAction" type="hidden" id="typeAction" value="I" />
<br><br>
</div>
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