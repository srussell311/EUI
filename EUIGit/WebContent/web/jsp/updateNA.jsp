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
    $("#nslaunchDate").datepicker();
        var edilaunch = $("#nslaunchDate").val();

});

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

<%@ include file="banner.jsp" %>
<%@ page import="java.util.Vector"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>
<%@ page import="java.util.Calendar"%>
<body id="wrapper" onload="loadFunction()">
<%
String punchout = dbUser.nspunchOut;
//System.out.println(dbUser.nspunchOut);
//System.out.println("SSO Customer = "+dbUser.nsssoCustomer);
String addPunchout = dbUser.nspunchOut1;
//System.out.println(dbUser.nspunchOut1);
//System.out.println(dbUser.nsaddPunchOut);
String actionType = (String)request.getParameter("actionType");
System.out.println(actionType);
String ordSource = dbUser.orderSource;
//System.out.println(ordSource);
//System.out.println("DB User Order Source ="+dbUser.orderSource);
dbUser = (EUIUser) session.getAttribute("EUIUser");
//System.out.println(dbUser);
//System.out.println("Catalog View="+dbUser.catView);


if(dbUser == null){
	//System.out.println("dbUser Is null");
}

%>
<script language="Javascript">
	
   
   function getNationalAccountDtl() {

	   document.updtAcct.actionType.value = "UpdateNA_1";
	   document.updtAcct.page.value="updateNA.jsp"
	   document.updtAcct.submit();
	
   }   
   
   function UpdateAccount(){

   			document.updtAcct.actionType.value = "SaveUpdateNA";
			document.updtAcct.page.value="updateNA.jsp"
			document.updtAcct.submit();
		
	}
	
   function Cancel(){
		document.updtAcct.actionType.value = "UpdateNA";
		document.updtAcct.page.value="updateNA.jsp"
		document.updtAcct.submit();
		//location.reload();
	}
	
	function loadFunction(){
		   var catalog = '<%=dbUser.catView%>' 
		   var action = '<%=actionType%>';
		   var ordSrc = '<%=ordSource%>';
		   var addpnchOut = '<%=addPunchout%>';
		   var userApproval = '<%=dbUser.nscorpApproval%>';
		   var itmApproval = '<%=dbUser.nsitemApproval%>'
			//alert(catalog)	
			//alert(itmApproval)
		   
		   
		if(action == "UpdateNA_1"){
			//alert ("HEEEY")
			if(ordSrc == "NetSupply" || ordSrc != "NetSupply" && catalog == "Y"){
				//alert("start")
			//////////////////Account Setup
			document.getElementById('netsupplySetup').style.display = "block";
			document.getElementById('netSetup').style.display = "block";
			document.getElementById('acctActiveNS').style.display = "block";
			document.getElementById('nsacctActive').style.display = "block";
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
			/////////Catalog Update Section
			document.getElementById('catalogSetup').style.display = "block";
			document.getElementById('catSetup').style.display = "block";
			document.getElementById('catViewNS').style.display = "block";
			document.getElementById('nscatView').style.display = "block";
			document.getElementById('imgUsedNS').style.display = "block";
			document.getElementById('nsimgUsed').style.display = "block";
			document.getElementById('enrichmentNS').style.display = "block";
			document.getElementById('nsenrichMent').style.display = "block";
			document.getElementById('dualOrdGuideNS').style.display = "block";
			document.getElementById('nsdualOrdGuide').style.display = "block";
			document.getElementById('catViewNS').style.display = "block";
			document.getElementById('nscatView').style.display = "block";
			document.getElementById('sDsNS').style.display = "block";
			document.getElementById('nssDs').style.display = "block";
			document.getElementById('barCodesNS').style.display = "block";
			document.getElementById('nsbarCodes').style.display = "block";
			document.getElementById('cancelnetSetup').style.display = "block";
			document.getElementById('netSetupStep').style.display = "block";
			//////////////////////////User Setup Section
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
			//////////////////Corporate Account Section
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
			document.getElementById('netSetupStep1Back').style.display = "none";
			document.getElementById('netSetupStep1').style.display = "none";
			//////////Account Maint /Account Connectivity
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
			document.getElementById('nscustomerID').style.display = "none";;
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
			document.getElementById('addPunchOutNS').style.display = "none";
			document.getElementById('nsaddPunchOut').style.display = "none";
			document.getElementById('networkIDNS1').style.display = "none";
			document.getElementById('nsnetworkID1').style.display = "none";
			document.getElementById('customerIDNS1').style.display = "none";
			document.getElementById('nscustomerID1').style.display = "none";
			document.getElementById('sharedSecretNS1').style.display = "none";
			document.getElementById('nssharedSecret1').style.display = "none";
			document.getElementById('punchoutProviderNS1').style.display = "none";
			document.getElementById('nspunchoutProvider1').style.display = "none";
			document.getElementById('providerCodeNS1').style.display = "none";
			document.getElementById('nsproviderCode1').style.display = "none";
			document.getElementById('cXmlNS1').style.display = "none";
			document.getElementById('nscXml1').style.display = "none";
			document.getElementById('fullPunchOutNS1').style.display = "none";
			document.getElementById('nsfullPunchOut1').style.display = "none";
			document.getElementById('saveCancel').style.display = "none";
			document.getElementById('netSetupStep3Back').style.display = "none";
			document.getElementById('SubmitNS').style.display = "none";
			document.getElementById('CancelNS').style.display = "none";
			///////EDI fields//////////////////////////////////////////////
			document.getElementById('ediTable').style.display = "none";
			document.getElementById('ediSetup').style.display = "none";
			document.getElementById('catViewOnly').style.display = "none";
			document.getElementById('catView').style.display = "none";
			document.getElementById('acctActiveEDI').style.display = "none";
			document.getElementById('acctActive').style.display = "none";
			document.getElementById('ddMTUsed').style.display = "none";
			document.getElementById('ddMT').style.display = "none";
			document.getElementById('imagedUsed').style.display = "none";
			document.getElementById('imgUsed').style.display = "none";
			document.getElementById('itemEnrich').style.display = "none";
			document.getElementById('enrichMent').style.display = "none";
			document.getElementById('sdsProvided').style.display = "none";
			document.getElementById('sDs').style.display = "none";
			document.getElementById('barAvail').style.display = "none";
			document.getElementById('barCodes').style.display = "none";
			document.getElementById('ediDate').style.display = "none";
			document.getElementById('ediLaunch').style.display = "none";
			document.getElementById('Submitedi').style.display = "none";
			document.getElementById('Canceledi').style.display = "none";
			}
			
			if(ordSrc != "NetSupply" && catalog == "N"){
				//////////////////Account Setup
				document.getElementById('netsupplySetup').style.display = "none";
				document.getElementById('netSetup').style.display = "none";
				document.getElementById('acctSetupNS').style.display = "none";
				document.getElementById('acctActiveNS').style.display = "none";
				document.getElementById('nsacctActive').style.display = "none";
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
				/////////Catalog Update Section
				document.getElementById('catalogSetup').style.display = "none";
				document.getElementById('catSetup').style.display = "none";
	            document.getElementById('catViewNS').style.display = "none";
			    document.getElementById('nscatView').style.display = "none";
				document.getElementById('imgUsedNS').style.display = "none";
				document.getElementById('nsimgUsed').style.display = "none";
				document.getElementById('enrichmentNS').style.display = "none";
				document.getElementById('nsenrichMent').style.display = "none";
				document.getElementById('dualOrdGuideNS').style.display = "none";
				document.getElementById('nsdualOrdGuide').style.display = "none";
				document.getElementById('catViewNS').style.display = "none";
				document.getElementById('nscatView').style.display = "none";
				document.getElementById('sDsNS').style.display = "none";
				document.getElementById('nssDs').style.display = "none";
				document.getElementById('barCodesNS').style.display = "none";
				document.getElementById('nsbarCodes').style.display = "none";
				document.getElementById('cancelnetSetup').style.display = "none";
				document.getElementById('netSetupStep').style.display = "none";
				//////////////////////////User Setup Section
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
				//////////////////Corporate Account Section
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
				document.getElementById('netSetupStep1Back').style.display = "none";
				document.getElementById('netSetupStep1').style.display = "none";
				//////////Account Maint /Account Connectivity
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
				//document.getElementById('punchOutTypeNS').style.display = "none";
				//document.getElementById('nspunchOutType').style.display = "none";
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
				document.getElementById('addPunchOutNS').style.display = "none";
				document.getElementById('nsaddPunchOut').style.display = "none";
				//document.getElementById('punchOutTypeNS1').style.display = "none";
				//document.getElementById('nspunchOutType1').style.display = "none";
				document.getElementById('networkIDNS1').style.display = "none";
				document.getElementById('nsnetworkID1').style.display = "none";
				document.getElementById('customerIDNS1').style.display = "none";
				document.getElementById('nscustomerID1').style.display = "none";
				document.getElementById('sharedSecretNS1').style.display = "none";
				document.getElementById('nssharedSecret1').style.display = "none";
				document.getElementById('punchoutProviderNS1').style.display = "none";
				document.getElementById('nspunchoutProvider1').style.display = "none";
				document.getElementById('providerCodeNS1').style.display = "none";
				document.getElementById('nsproviderCode1').style.display = "none";
				document.getElementById('cXmlNS1').style.display = "none";
				document.getElementById('nscXml1').style.display = "none";
				document.getElementById('fullPunchOutNS1').style.display = "none";
				document.getElementById('nsfullPunchOut1').style.display = "none";
				document.getElementById('saveCancel').style.display = "none";
				document.getElementById('netSetupStep3Back').style.display = "none";
				document.getElementById('SubmitNS').style.display = "none";
				document.getElementById('CancelNS').style.display = "none";
				////////////////////EDI Section
				document.getElementById('ediTable').style.display = "block";
				document.getElementById('ediSetup').style.display = "block";
				document.getElementById('catViewOnly').style.display = "block";
				document.getElementById('catView').style.display = "block";
				document.getElementById('acctActiveEDI').style.display = "block";
				document.getElementById('acctActive').style.display = "block";
				document.getElementById('ddMTUsed').style.display = "block";
				document.getElementById('ddMT').style.display = "block";
				document.getElementById('imagedUsed').style.display = "block";
				document.getElementById('imgUsed').style.display = "block";
				document.getElementById('itemEnrich').style.display = "block";
				document.getElementById('enrichMent').style.display = "block";
				document.getElementById('sdsProvided').style.display = "block";
				document.getElementById('sDs').style.display = "block";
				document.getElementById('barAvail').style.display = "block";
				document.getElementById('barCodes').style.display = "block";
				document.getElementById('ediDate').style.display = "block";
				document.getElementById('ediLaunch').style.display = "block";
				document.getElementById('Submitedi').style.display = "block";
				document.getElementById('Canceledi').style.display = "block";	
				}
		
			}
		
		}
	
	function netSupply(){
		
		   var userApproval = '<%=dbUser.nscorpApproval%>';
		   var itmApproval = '<%=dbUser.nsitemApproval%>';
			
		if((document.updtAcct.netSetupStep.value =='Next>>')){
			document.getElementById('netsupplySetup').style.display = "block";
			document.getElementById('netSetup').style.display = "none";
			document.getElementById('acctSetupNS').style.display = "none";
			document.getElementById('acctActiveNS').style.display = "none";
			document.getElementById('nsacctActive').style.display = "none";
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
            /////////Catalog Update Section
            document.getElementById('catalogSetup').style.display = "none";
			document.getElementById('catSetup').style.display = "none";
            document.getElementById('catViewNS').style.display = "none";
			document.getElementById('nscatView').style.display = "none";
			document.getElementById('imgUsedNS').style.display = "none";
			document.getElementById('nsimgUsed').style.display = "none";
			document.getElementById('enrichmentNS').style.display = "none";
			document.getElementById('nsenrichMent').style.display = "none";
			document.getElementById('dualOrdGuideNS').style.display = "none";
			document.getElementById('nsdualOrdGuide').style.display = "none";
			document.getElementById('catViewNS').style.display = "none";
			document.getElementById('nscatView').style.display = "none";
			document.getElementById('sDsNS').style.display = "none";
			document.getElementById('nssDs').style.display = "none";
			document.getElementById('barCodesNS').style.display = "none";
			document.getElementById('nsbarCodes').style.display = "none";
			document.getElementById('cancelnetSetup').style.display = "none";
			document.getElementById('netSetupStep').style.display = "none";
			//////////////////////////User Setup Section
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
			//////////////////Corporate Account Section
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
			if(userApproval != "2"){
			document.getElementById('contactEmailNS').style.display = "block";
			document.getElementById('nscontactEmail').style.display = "block";////////////////
			} else {
				document.getElementById('contactEmailNS').style.display = "none";
				document.getElementById('nscontactEmail').style.display = "none";
			}
			document.getElementById('itemApprovalNS').style.display = "block";
			document.getElementById('nsitemApproval').style.display = "block";
			if(itmApproval != "2"){
			document.getElementById('itemApprovalNoteNS').style.display = "block";////////////////
			document.getElementById('nsitemApprovalNote').style.display = "block";
			} else {
				document.getElementById('itemApprovalNoteNS').style.display = "none";////////////////
				document.getElementById('nsitemApprovalNote').style.display = "none";
			}
			document.getElementById('netSetupStep1Back').style.display = "block";
			document.getElementById('netSetupStep1').style.display = "block";
			//////////Account Maint /Account Connectivity
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
			//document.getElementById('punchOutTypeNS').style.display = "none";
			//document.getElementById('nspunchOutType').style.display = "none";
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
			document.getElementById('addPunchOutNS').style.display = "none";
			document.getElementById('nsaddPunchOut').style.display = "none";
			//document.getElementById('punchOutTypeNS1').style.display = "none";
			//document.getElementById('nspunchOutType1').style.display = "none";
			document.getElementById('networkIDNS1').style.display = "none";
			document.getElementById('nsnetworkID1').style.display = "none";
			document.getElementById('customerIDNS1').style.display = "none";
			document.getElementById('nscustomerID1').style.display = "none";
			document.getElementById('sharedSecretNS1').style.display = "none";
			document.getElementById('nssharedSecret1').style.display = "none";
			document.getElementById('punchoutProviderNS1').style.display = "none";
			document.getElementById('nspunchoutProvider1').style.display = "none";
			document.getElementById('providerCodeNS1').style.display = "none";
			document.getElementById('nsproviderCode1').style.display = "none";
			document.getElementById('cXmlNS1').style.display = "none";
			document.getElementById('nscXml1').style.display = "none";
			document.getElementById('fullPunchOutNS1').style.display = "none";
			document.getElementById('nsfullPunchOut1').style.display = "none";
			document.getElementById('saveCancel').style.display = "none";
			document.getElementById('netSetupStep3Back').style.display = "none";
			document.getElementById('SubmitNS').style.display = "none";
			document.getElementById('CancelNS').style.display = "none";
			////////////////EDI Section
			document.getElementById('ediTable').style.display = "none";
			document.getElementById('ediSetup').style.display = "none";
			document.getElementById('catViewOnly').style.display = "none";
			document.getElementById('catView').style.display = "none";
			document.getElementById('acctActiveEDI').style.display = "none";
			document.getElementById('acctActive').style.display = "none";
			document.getElementById('ddMTUsed').style.display = "none";
			document.getElementById('ddMT').style.display = "none";
			document.getElementById('imagedUsed').style.display = "none";
			document.getElementById('imgUsed').style.display = "none";
			document.getElementById('itemEnrich').style.display = "none";
			document.getElementById('enrichMent').style.display = "none";
			document.getElementById('sdsProvided').style.display = "none";
			document.getElementById('sDs').style.display = "none";
			document.getElementById('barAvail').style.display = "none";
			document.getElementById('barCodes').style.display = "none";
			document.getElementById('ediDate').style.display = "none";
			document.getElementById('ediLaunch').style.display = "none";
			document.getElementById('Submitedi').style.display = "none";
			document.getElementById('Canceledi').style.display = "none";	
			
		}
	}

	function netSupply1(){
		
		var ssoNote = '<%=dbUser.nsssoCustomer%>'
		var punchout = '<%=dbUser.nspunchOut%>'
		var addpnchOut = '<%=dbUser.nspunchOut1%>'
		//alert(ssoNote)
		
		if(document.updtAcct.netSetupStep1.value=="Next>>"||document.updtAcct.netSetupStep1Back.value=="<<Back"){

		document.getElementById('netsupplySetup').style.display = "block";
		document.getElementById('netSetup').style.display = "none";
		document.getElementById('acctSetupNS').style.display = "none";
		document.getElementById('acctActiveNS').style.display = "none";
		document.getElementById('nsacctActive').style.display = "none";
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
            /////////Catalog Update Section
        document.getElementById('catalogSetup').style.display = "none";
		document.getElementById('catSetup').style.display = "none";
        document.getElementById('catViewNS').style.display = "none";
		document.getElementById('nscatView').style.display = "none";
		document.getElementById('imgUsedNS').style.display = "none";
		document.getElementById('nsimgUsed').style.display = "none";
		document.getElementById('enrichmentNS').style.display = "none";
		document.getElementById('nsenrichMent').style.display = "none";
		document.getElementById('dualOrdGuideNS').style.display = "none";
		document.getElementById('nsdualOrdGuide').style.display = "none";
		document.getElementById('catViewNS').style.display = "none";
		document.getElementById('nscatView').style.display = "none";
		document.getElementById('sDsNS').style.display = "none";
		document.getElementById('nssDs').style.display = "none";
		document.getElementById('barCodesNS').style.display = "none";
		document.getElementById('nsbarCodes').style.display = "none";
		document.getElementById('cancelnetSetup').style.display = "none";
		document.getElementById('netSetupStep').style.display = "none";
			//////////////////Corporate Account Section
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
		document.getElementById('netSetupStep1Back').style.display = "none";
		document.getElementById('netSetupStep1').style.display = "none";
			//////////////////////////User Setup Section
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
			//////////Account Maint /Account Connectivity
		document.getElementById('accountMain').style.display = "block";
		document.getElementById('acctMaint').style.display = "block";
		document.getElementById('cleanupFlagNS').style.display = "block";
		document.getElementById('nscleanupFlag').style.display = "block";
		document.getElementById('acctConnect').style.display = "block";
		document.getElementById('ssoCustomerNS').style.display = "block";
		document.getElementById('nsssoCustomer').style.display = "block";
		if(ssoNote == "Y"){
			document.getElementById("nspunchOut").disabled = true;
			document.getElementById("nsaddPunchOut").disabled = true;
			document.getElementById('ssoNotesNS').style.display = "block";
			document.getElementById('nsssoNotes').style.display = "block";
		}
				
		document.getElementById('punchOutNS').style.display = "block";
		document.getElementById('nspunchOut').style.display = "block";
		document.getElementById('saveCancel').style.display = "block";
		document.getElementById('netSetupStep3Back').style.display = "block";
		document.getElementById('SubmitNS').style.display = "block";
		document.getElementById('CancelNS').style.display = "block";
		////////Punchout
		if(punchout == "Y"){
		//document.getElementById('punchOutTypeNS').style.display = "block";
		//document.getElementById('nspunchOutType').style.display = "block";
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
		document.getElementById('addPunchOutNS').style.display = "block";
		document.getElementById('nsaddPunchOut').style.display = "block";
		}
		//alert(addpnchOut)
		if(addpnchOut == "Y"){
		//document.getElementById('punchOutTypeNS1').style.display = "block";
		//document.getElementById('nspunchOutType1').style.display = "block";
		document.getElementById("nsssoCustomer").disabled = true;
		document.getElementById('networkIDNS1').style.display = "block";
		document.getElementById('nsnetworkID1').style.display = "block";
		document.getElementById('customerIDNS1').style.display = "block";
		document.getElementById('nscustomerID1').style.display = "block";
		document.getElementById('sharedSecretNS1').style.display = "block";
		document.getElementById('nssharedSecret1').style.display = "block";
		document.getElementById('punchoutProviderNS1').style.display = "block";
		document.getElementById('nspunchoutProvider1').style.display = "block";
		document.getElementById('providerCodeNS1').style.display = "block";
		document.getElementById('nsproviderCode1').style.display = "block";
		document.getElementById('cXmlNS1').style.display = "block";
		document.getElementById('nscXml1').style.display = "block";
		document.getElementById('fullPunchOutNS1').style.display = "block";
		document.getElementById('nsfullPunchOut1').style.display = "block";
		}
		
        //////////////////EDI Section
		document.getElementById('ediTable').style.display = "none";
		document.getElementById('ediSetup').style.display = "none";
		document.getElementById('catViewOnly').style.display = "none";
		document.getElementById('catView').style.display = "none";
		document.getElementById('acctActiveEDI').style.display = "none";
		document.getElementById('acctActive').style.display = "none";
		document.getElementById('ddMTUsed').style.display = "none";
		document.getElementById('ddMT').style.display = "none";
		document.getElementById('imagedUsed').style.display = "none";
		document.getElementById('imgUsed').style.display = "none";
		document.getElementById('itemEnrich').style.display = "none";
		document.getElementById('enrichMent').style.display = "none";
		document.getElementById('sdsProvided').style.display = "none";
		document.getElementById('sDs').style.display = "none";
		document.getElementById('barAvail').style.display = "none";
		document.getElementById('barCodes').style.display = "none";
		document.getElementById('ediDate').style.display = "none";
		document.getElementById('ediLaunch').style.display = "none";
		document.getElementById('Submitedi').style.display = "none";
		document.getElementById('Canceledi').style.display = "none";	

		
		}
	}
	
	function punchOut(){
		var addpnchOut = document.getElementById('nspunchOut').value;
			//alert(addpnchOut)
			
			if(addpnchOut == "N"){
				//alert(addpnchOut)
			//document.getElementById('punchOutTypeNS').style.display = "none";
			//document.getElementById('nspunchOutType').style.display = "none";
			document.getElementById("nsssoCustomer").disabled = false;
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
			document.getElementById('addPunchOutNS').style.display = "none";
			document.getElementById('nsaddPunchOut').style.display = "none";
			}
			
			if(addpnchOut == "Y"){
			//document.getElementById('punchOutTypeNS').style.display = "block";
			//document.getElementById('nspunchOutType').style.display = "block";
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
			document.getElementById('addPunchOutNS').style.display = "block";
			document.getElementById('nsaddPunchOut').style.display = "block";
			}
	}
	
	function SSO(){
		//alert("SSO alert")
		if(document.updtAcct.nsssoCustomer.value=="Y"){
			document.getElementById("nspunchOut").disabled = true;
			document.getElementById('ssoNotesNS').style.display = "block";
			document.getElementById('nsssoNotes').style.display = "block";
		}
		if(document.updtAcct.nsssoCustomer.value=="N"){
			document.getElementById("nspunchOut").disabled = false;
			document.getElementById('ssoNotesNS').style.display = "none";
			document.getElementById('nsssoNotes').style.display = "none";
		}
	}
	
	function addPO(){
		var addpnchOut = document.getElementById('nsaddPunchOut').value;
			//alert(addpnchOut)
			
			if(addpnchOut == "N"){
				//alert(addpnchOut)
			//document.getElementById('punchOutTypeNS1').style.display = "none";
			//document.getElementById('nspunchOutType1').style.display = "none";
			document.getElementById("nsssoCustomer").disabled = true;
			document.getElementById('networkIDNS1').style.display = "none";
			document.getElementById('nsnetworkID1').style.display = "none";
			document.getElementById('customerIDNS1').style.display = "none";
			document.getElementById('nscustomerID1').style.display = "none";
			document.getElementById('sharedSecretNS1').style.display = "none";
			document.getElementById('nssharedSecret1').style.display = "none";
			document.getElementById('punchoutProviderNS1').style.display = "none";
			document.getElementById('nspunchoutProvider1').style.display = "none";
			document.getElementById('providerCodeNS1').style.display = "none";
			document.getElementById('nsproviderCode1').style.display = "none";
			document.getElementById('cXmlNS1').style.display = "none";
			document.getElementById('nscXml1').style.display = "none";
			document.getElementById('fullPunchOutNS1').style.display = "none";
			document.getElementById('nsfullPunchOut1').style.display = "none";
			}
			
			if(addpnchOut == "Y"){
			//document.getElementById('punchOutTypeNS1').style.display = "block";
			//document.getElementById('nspunchOutType1').style.display = "block";
			document.getElementById("nsssoCustomer").disabled = true;
			document.getElementById('networkIDNS1').style.display = "block";
			document.getElementById('nsnetworkID1').style.display = "block";
			document.getElementById('customerIDNS1').style.display = "block";
			document.getElementById('nscustomerID1').style.display = "block";
			document.getElementById('sharedSecretNS1').style.display = "block";
			document.getElementById('nssharedSecret1').style.display = "block";
			document.getElementById('punchoutProviderNS1').style.display = "block";
			document.getElementById('nspunchoutProvider1').style.display = "block";
			document.getElementById('providerCodeNS1').style.display = "block";
			document.getElementById('nsproviderCode1').style.display = "block";
			document.getElementById('cXmlNS1').style.display = "block";
			document.getElementById('nscXml1').style.display = "block";
			document.getElementById('fullPunchOutNS1').style.display = "block";
			document.getElementById('nsfullPunchOut1').style.display = "block";
			}
	}
	
	function getUserApproval(){
		var newUserApproval = document.getElementById('nscorpApproval').value;
		//alert(newUserApproval)
		
		if(document.updtAcct.nscorpApproval.value != "2"){
			document.getElementById('contactEmailNS').style.display = "block";
			document.getElementById('nscontactEmail').style.display = "block";
		}
		if(document.updtAcct.nscorpApproval.value == "2"){
			document.getElementById('contactEmailNS').style.display = "none";
			document.getElementById('nscontactEmail').style.display = "none";
		}
		
	}
	
	function getItemApproval(){
		var itemApproval = document.getElementById('nsitemApproval').value;
		//alert(itemApproval)
		
		if(document.updtAcct.nsitemApproval.value != "2"){
			document.getElementById('itemApprovalNoteNS').style.display = "block";
			document.getElementById('nsitemApprovalNote').style.display = "block";
		}
		if(document.updtAcct.nsitemApproval.value == "2"){
			document.getElementById('itemApprovalNoteNS').style.display = "none";
			document.getElementById('nsitemApprovalNote').style.display = "none";
		}
	}
	
	

</script>
<%@ include file="navMenu.jsp"%>

<form action="ControllerServlet?page=updateNA.jsp" method="post" name="updtAcct">
	<input type=hidden name='actionType' value=""> <input type=hidden name='page' value=""><input type="hidden" name='routeToViewDtl' id='routeToViewDtl' value="viewNADtl"/>
	<div id="inputField">

		<span class="subTitle">Update National Account</span> <br /> <br />
		<div id="centerTable">
		<!--  <table border="0" cellpadding="0">-->
			<% if (actionType.equals("UpdateNA")) { %>

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
			<!--</table>  -->


			<% } 
			//System.out.println("Sr="+dbUser);
 //display details after all necessary selections made
if (actionType.equals("UpdateNA_1")) {%>
<!--  <div id="inputField">-->
<!-- <table border="0" cellpadding="0"> -->

<tr>
				<td><strong>National Account:</strong></td>
				<td colspan="3"><select name="natAcct" id="natAcct"
					onchange="javascript:getNationalAccountDtl();">
						<option selected="selected" value="<%=dbUser.nationalAccountNbr%>"><%=dbUser.nationalAccountNbr%></option>
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
			<!-- <tr>
				<td name="nationalAcct" id="nationalAcct"><strong>National Account:</strong></td>
				<td name="nationalAcctNameID" id="nationalAcctNameID"><input name="natAcct" type="hidden"
					value="<%=dbUser.nationalAccountNbr%>" /> <%=dbUser.naNbrF%> - <%=dbUser.nationalAccountName%>
				</td>
			</tr> -->
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><strong>Order Source:</strong></td>
				<td name="orderSource" id="orderSource" value="<%=dbUser.orderSource%>"><%=dbUser.orderSource%></td>
			</tr>
			
			 <!--<p align="left" style="padding:0px 0px 0px 300px " class="subTitle" name="netsupplySetup" id="netsupplySetup">NetSupply Setup</p> -->
			 <p  name="ediSetup" id="ediSetup" style="postion:absolute;padding:15px 0px 0px 0px"><strong>EDI Setup Update</strong></p>
               <p style="postion:absolute;padding:15px 0px 0px 0px" name="netsupplySetup" id="netsupplySetup"><strong>NetSupply Setup Update</strong></p>
		<%//if(dbUser.orderSource.equals("NetSupply")) {%>
			<!--Account Setup Section -->
			<div>
		<table name="netSetup" id="netSetup">
			<tr>
			 	<td class="subTitle" name="acctSetupNS" id="acctSetupNS">Account Setup</td>
			 	<td></td>
			</tr>
			<tr>
				<td name="acctActiveNS" id="acctActiveNS">Account is Active on NetSupply?</td>
				<%if(dbUser.nsacctActive.equals("N")){%>
				<td><select name="nsacctActive" id="nsacctActive">
				<option value="N" selected>No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nsacctActive" id="nsacctActive">
				<option value="Y" selected>Yes</option>
				<option value="N">No</option>
				</select></td>
				<% } %>
				<input type="hidden" name="activeCheckNS" id="activeCheckNS" value="<%=dbUser.nsacctActive%>" />
			</tr>
			<tr>
				<td name="ddmtNS" id="ddmtNS">DDMT Used?</td>
				<%if(dbUser.nsddMT.equals("N")){%>
				<td><select name="nsddMT" id="nsddMT">
				<option value="N" selected>No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nsddMT" id="nsddMT">
				<option value="Y" selected>Yes</option>
				<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="custLocNS" id="custLocNS">Display Customer Location Number?</td>
				<%if(dbUser.nscustLocNbr.equals("N")){%>
				<td><select name="nscustLocNbr" id="nscustLocNbr">
				<option value="N" selected>No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nscustLocNbr" id="nscustLocNbr">
				<option value="Y" selected>Yes</option>
				<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="custURLNS" id="custURLNS">URL posted to Customers Intranet?</td>
				<%if(dbUser.nscustURL.equals("N")){%>
				<td><select name="nscustURL" id="nscustURL">
					<option value="N" selected>No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nscustURL" id="nscustURL">
					<option value="Y" selected>Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="launchDateNS" id="launchDateNS">NetSupply Launch Date:</td>
				<td><input readonly="true" type="text" id="nslaunchDate" name="nslaunchDate" value="<%=dbUser.nslaunchDate%>"/></td>
			</tr>
			<tr>
				<td name="specNotesNS" id="specNotesNS">Special Setup Notes:</td>
				<td><textarea style="height:115px;" name="nsaddNotes" id="nsaddNotes"><%=dbUser.nsaddNotes%></textarea></td>
			</tr>
		</table>
		</div>
		<br>
			<!--END OF Account Setup Section -->
			
			<!--Catalog Setup Section -->
		<table name="catalogSetup" id="catalogSetup">
			<tr>
			 	<td class="subTitle" name="catSetup" id="catSetup">Catalog Update</td>
			 	<td></td>
			</tr>
			<tr>
				<td name="catViewNS" id="catViewNS">Catalog View Only Account?</td>
				<%if(dbUser.nscatView.equals("N")){%>
				<td><select name="nscatView" id="nscatView">
				<option value="N" selected>No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nscatView" id="nscatView">
				<option value="Y" selected>Yes</option>
				<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="imgUsedNS" id="imgUsedNS">Item Images Used?</td>
				<%if(dbUser.nsimgUsed.equals("N")){%>
				<td><select name="nsimgUsed" id="nsimgUsed">
				<option value="N" selected>No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nsimgUsed" id="nsimgUsed">
				<option value="Y" selected>Yes</option>
				<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="enrichmentNS" id="enrichmentNS">Item Enrichment?</td>
				<%if(dbUser.nsenrichMent.equals("N")){%>
				<td><select name="nsenrichMent" id="nsenrichMent">
					<option value="N" selected>No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nsenrichMent" id="nsenrichMent">
					<option value="Y" selected>Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="dualOrdGuideNS" id="dualOrdGuideNS">Dual Order Guide Setup?</td>
				<%if(dbUser.nsdualOrdGuide.equals("N")){%>
				<td><select name="nsdualOrdGuide" id="nsdualOrdGuide">
					<option value="N" selected>No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nsdualOrdGuide" id="nsdualOrdGuide">
					<option value="Y" selected>Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="catViewNS" id="catViewNS">Catalog Viewing Only Account?</td>
				<%if(dbUser.nscatView.equals("N")){%>
				<td><select name="nscatView" id="nscatView">
					<option value="N" selected>No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nscatView" id="nscatView">
					<option value="Y" selected>Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="sDsNS" id="sDsNS">SDS Provided?</td>
				<%if(dbUser.nssDs.equals("N")){%>
				<td><select name="nssDs" id="nssDs">
					<option value="N" selected>No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nssDs" id="nssDs">
					<option value="Y" selected>Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="barCodesNS" id="barCodesNS">Barcodes Available?</td>
				<%if(dbUser.nsbarCodes.equals("N")){%>
				<td><select name="nsbarCodes" id="nsbarCodes">
					<option value="N" selected>No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nsbarCodes" id="nsbarCodes">
					<option value="Y" selected>Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			</table>
			<br>
			<input type="button" name="cancelnetSetup" id="cancelnetSetup" style="position:absolute;top:550px;left:535px;right:0px;bottom:0px;width: 100px;height:25px;" value="Cancel" onclick="javascript:Cancel()" />
			<input name="netSetupStep" id="netSetupStep" style="position:absolute;top:550px;left:655px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="Next>>" onclick="javascript:netSupply()"/>
	
			<!-- END OF Catalog Setup Section -->
			
			<!--User Setup Section -->
		<table name="usrSetup" id="usrSetup">
			<tr>
			 	<td class="subTitle" name="userSetup" id="userSetup">User Setup</td>
			 	<td></td>
			</tr>
			<tr>
				<td name="userNamesTextNS" id="userNamesTextNS">Username Example:</td>
				<td><input name="nsuserNamesText" id="nsuserNamesText" value="<%=dbUser.nsuserNamesText%>"/></td>
				<td name="userPasswordTextNS" id="userPasswordTextNS">Password Example:</td>
				<td><input name="nsuserPasswordText" id="nsuserPasswordText" value="<%=dbUser.nsuserPasswordText%>"/></td>
			</tr>
			<tr>
				<td name="favListNS" id="favListNS">Startup Favorite List use?</td>
				<% if(dbUser.nsfavList.equals("N")) { %>
				<td><select name="nsfavList" id="nsfavList">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
				<% } else { %>
				<td><select name="nsfavList" id="nsfavList">
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
				<td name="favListNoteNS" id="favListNoteNS">Favorite List Notes:</td>
				<td><textarea name="nsfavListNote" id="nsfavListNote"><%=dbUser.nsfavListNote%></textarea></td>
			</tr>
		</table>
		<br>
		<!--  <input name="netSetupStep2Back" id="netSetupStep2Back" style="position:absolute;top:525px;left:530px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="<<Back" onclick="javascript:netSupply()"/>
		<input name="netSetupStep2" id="netSetupStep2" style="position:absolute;top:525px;left:650px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="Next>>" onclick="javascript:netSupply2()"/>-->

			<!--END OF User Setup Section -->
			
			<!--Corporate Contact and Approval Rules Section-->
		<table name="corpCont" id="corpCont" >
			<tr>
			 	<td class="subTitle" name="contactApprovalNS" id="contactApprovalNS">Corporate Contact and Approval Rules</td>
			 	<td></td>
			</tr>
			<tr>
				<td name="authContactNS" id="authContactNS">Corporate Account Contact:</td>
				<td><input size="40" name="nsauthContact" id="nsauthContact" value="<%=dbUser.nsauthContact%>"/></td><!-- I GOT HERE -->
			</tr>
			<tr>
				<td name="adminEmailNS" id="adminEmailNS">Corporate Account Contact Copied on PO Emails:</td>
				<td><input name="nsadminEmail" id="nsadminEmail" value="<%=dbUser.nsadminEmail%>"/></td>
			</tr>
			<tr>
				<td name="ccLoginNS" id="ccLoginNS">Corporate Account Contact Copied on Logon Emails:</td>
				<td><input name="nsccLogin" id="nsccLogin" size="50" value="<%=dbUser.nsccLogin%>"/></td>
			</tr>
			<tr>
				<td name="corpApprovalNS" id="corpApprovalNS">Approval Needed for New Users?</td>
				<% if(dbUser.nscorpApproval.equals("1")) { %>
				<td><select name="nscorpApproval" id="nscorpApproval" onchange="javascript:getUserApproval()">
					<option value="2">No</option>
					<option selected value="1">Yes</option>
					<option value="3">Not with company email</option>
					<option value="4">Company email mandated</option>
				</select></td>
				<%} else if (dbUser.nscorpApproval.equals("2")) { %>
				<td><select name="nscorpApproval" id="nscorpApproval" onchange="javascript:getUserApproval()"">
					<option selected value="2">No</option>
					<option value="1">Yes</option>
					<option value="3">Not with company email</option>
					<option value="4">Company email mandated</option>
				</select></td>
				<% } else if (dbUser.nscorpApproval.equals("3")){ %>
				<td><select name="nscorpApproval" id="nscorpApproval" onchange="javascript:getUserApproval()">
					<option value="2">No</option>
					<option value="1">Yes</option>
					<option selected value="3">Not with company email</option>
					<option value="4">Company email mandated</option>
				</select></td>
				<% } else { %>
				<td><select name="nscorpApproval" id="nscorpApproval" onchange="javascript:getUserApproval()">
					<option value="2">No</option>
					<option value="1">Yes</option>
					<option value="3">Not with company email</option>
					<option selected value="4">Company email mandated</option>
				</select></td>
				<% } %>
			</tr>
			<%//if(!dbUser.nscorpApproval.equals("2")){ %>
			<tr>
				<td name="contactEmailNS" id="contactEmailNS">Approver's Email:</td>
				<td><input name="nscontactEmail" id="nscontactEmail" size="50" value="<%=dbUser.nscontactEmail%>"/></td>
			</tr>
			<% //} %>
			<tr>
				<td name="itemApprovalNS" id="itemApprovalNS">Approval Needed for New Item Adds?</td>
				<% if(dbUser.nsitemApproval.equals("1")) { %>
				<td><select name="nsitemApproval" id="nsitemApproval" onchange="javascript:getItemApproval()">
					<option value="2">No</option>
					<option selected value="1">Yes</option>
					<option value="3">Mfr. Based</option>
				</select></td>
				<%} else if (dbUser.nsitemApproval.equals("2")) { %>
				<td><select name="nsitemApproval" id="nsitemApproval" onchange="javascript:getItemApproval()">
					<option selected value="2">No</option>
					<option value="1">Yes</option>
					<option value="3">Mfr. Based</option>
				</select></td>
				<% } else { %>
				<td><select name="nsitemApproval" id="nsitemApproval" onchange="javascript:getItemApproval()">
					<option selected value="2">No</option>
					<option value="1">Yes</option>
					<option selected value="3">Mfr. Based</option>
				</select></td>
				<% } %>
			</tr>
			<%//if(!dbUser.nsitemApproval.equals("2")){ %>
			<tr>
				<td name="itemApprovalNoteNS" id="itemApprovalNoteNS">Approver's Email:</td>
				<td><input name="nsitemApprovalNote" id="nsitemApprovalNote" size="50" value="<%=dbUser.nsitemApprovalNote%>"/></td>
			</tr>
			<% //} %>
			</tr>
		</table>
		<br>
		<input name="netSetupStep1Back" id="netSetupStep1Back" style="position:absolute;top:665px;left:530px;right:0px;bottom:0px;width: 100px;height:25px;" 
		type="button" value="<<Back" onclick="javascript:loadFunction()"/>
		<input name="netSetupStep1" id="netSetupStep1" style="position:absolute;top:665px;left:650px;right:0px;bottom:0px;width: 100px;height:25px;" 
		type="button" value="Next>>" onclick="javascript:netSupply1()"/>
			<!--END OF Corporate Contact and Approval Rules Section-->
	
	
			
	
			<!--Account Maintenance Section -->
		<table name="accountMain" id="accountMain">
			<tr>
			 	<td class="subTitle" name="acctMaint" id="acctMaint">Account Maintenance</td>
			 	<td></td>
			</tr>
			<tr>
				<td name="cleanupFlagNS" id="cleanupFlagNS">Disregard User Cleanup?</td>
				<% if(dbUser.nscleanupFlag.equals("N")) { %>
				<td><select name="nscleanupFlag" id="nscleanupFlag">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
				<% } else { %>
				<td><select name="nscleanupFlag" id="nscleanupFlag">
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
		<!-- </table> -->
		<br>

			<!--END OF Account Maintenance Section -->
			

			<tr>
			 	<td class="subTitle" name="acctConnect" id="acctConnect">Account Connectivity</td>
			 	<td></td>
			</tr>
			<tr>
				<td name="ssoCustomerNS" id="ssoCustomerNS">SSO Customer?</td>
				<% if(dbUser.nsssoCustomer ==null||dbUser.nsssoCustomer.equals("")){ %>
				<td><select name="nsssoCustomer" id="nsssoCustomer" onchange="javascript:SSO()">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
				<% } else { %>
				<td><select name="nsssoCustomer" id="nsssoCustomer" onchange="javascript:SSO()">
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
				<%} %>
			</tr>
			<tr>
				<td name="ssoNotesNS" id="ssoNotesNS">SSO Notes:</td>
				<td><textarea style="width:200px;height:130px;" name="nsssoNotes" id="nsssoNotes"></textarea></td>
			</tr>
			<tr>
				<td name="punchOutNS" id="punchOutNS">NetSupply Punchout?</td>
				<% if(dbUser.nspunchOut.equals("N")||dbUser.nspunchOut.equals("")) { %>
				<td><select name="nspunchOut" id="nspunchOut" onchange="javascript:punchOut()">
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
				<% } else { %>
				<td><select name="nspunchOut" id="nspunchOut" onchange="javascript:punchOut()">
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
				
			</tr>
			<% } %>
			
			<tr>
				<td name="networkIDNS" id="networkIDNS">Network Identity:</td>
				<td><input name="nsnetworkID" id="nsnetworkID" value="<%=dbUser.nsnetworkID%>"/></td>
			</tr>
			<tr>
				<td name="customerIDNS" id="customerIDNS">Customer Identity:</td>
				<td><input name="nscustomerID" id="nscustomerID" value="<%=dbUser.nscustomerID%>"/></td>
			</tr>
			
			
			<tr>
				<td name="sharedSecretNS" id="sharedSecretNS">Shared Secret:</td>
				<td><input name="nssharedSecret" id="nssharedSecret" value="<%=dbUser.nssharedSecret%>"/></td>
			</tr>
			<tr>
				<td name="punchoutProviderNS" id="punchoutProviderNS">Punchout Provider:</td>
				<td><input name="nspunchoutProvider" id="nspunchoutProvider" value="<%=dbUser.nspunchoutProvider%>"/></td>
			</tr>
			<tr>
				<td name="providerCodeNS" id="providerCodeNS">Punchout Provider Code:</td>
				<td><input name="nsproviderCode" id="nsproviderCode" value="<%=dbUser.nsproviderCode%>"/></td>
			</tr>
			<tr>
				<td name="cXmlNS" id="cXmlNS">cXML Location # Exchanged:</td>
				<td><input name="nscXml" id="nscXml" value="<%=dbUser.nscXml%>"/></td>
			</tr>
			<tr>
				<td name="fullPunchOutNS" id="fullPunchOutNS">Punchout Notes:</td>
				<td><input name="nsfullPunchOut" id="nsfullPunchOut" size="20" value="<%=dbUser.nsfullPunchOut%>"></td>
			</tr>
			<tr>
				<td name="addPunchOutNS" id="addPunchOutNS">Add Additional Punchout?</td>
				<%if(dbUser.nspunchOut1.equals("N")){ %>
				<td><select name="nsaddPunchOut" id="nsaddPunchOut" onchange="javascript:addPO()">					
					<option selected value="N">No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="nsaddPunchOut" id="nsaddPunchOut" onchange="javascript:addPO()">					
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
				<%}%>
			</tr>
			</tr>
			<tr>
				<td name="networkIDNS1" id="networkIDNS1">Network Identity:</td>
				<td><input name="nsnetworkID1" id="nsnetworkID1" value="<%=dbUser.nsnetworkID1%>"/></td>
			</tr>
			<tr>
				<td name="customerIDNS1" id="customerIDNS1">Customer Identity:</td>
				<td><input name="nscustomerID1" id="nscustomerID1" value="<%=dbUser.nscustomerID1%>"/></td>
			</tr>
			<tr>
				<td name="sharedSecretNS1" id="sharedSecretNS1">Shared Secret:</td>
				<td><input name="nssharedSecret1" id="nssharedSecret1" value="<%=dbUser.nssharedSecret1%>"/></td>
			</tr>
			<tr>
				<td name="punchoutProviderNS1" id="punchoutProviderNS1">Punchout Provider:</td>
				<td><input name="nspunchoutProvider1" id="nspunchoutProvider1" value="<%=dbUser.nspunchoutProvider1%>"/></td>
			</tr>
			<tr>
				<td name="providerCodeNS1" id="providerCodeNS1">Punchout Provider Code:</td>
				<td><input name="nsproviderCode1" id="nsproviderCode1" value="<%=dbUser.nsproviderCode1%>"/></td>
			</tr>
			<tr>
				<td name="cXmlNS1" id="cXmlNS1">cXML Location # Exchanged:</td>
				<td><input name="nscXml1" id="nscXml1" value="<%=dbUser.nscXml1%>"/></td>
			</tr>
			<tr>
				<td name="fullPunchOutNS1" id="fullPunchOutNS1">Punchout Notes:</td>
				<td><input name="nsfullPunchOut1" id="nsfullPunchOut1" size="20" value="<%=dbUser.nsfullPunchOut1%>"/></td>
			</tr>
			<% 
				//}
			 %>
		</table>
		<br>
		<table id="saveCancel" name="saveCancel">
			<tr>
				<td><input name="netSetupStep3Back" id="netSetupStep3Back" style="position:absolute;top:750px;left:460px;right:0px;bottom:0px;width: 100px;height:25px;" type="button" value="<<Back" onclick="javascript:netSupply()"/></td>
				<td></td>
			</tr>
			<tr>
				<td><input type="button" name="SubmitNS" id="SubmitNS" style="position:absolute;top:750px;left:650px;right:0px;bottom:0px;width: 100px;height:25px;" value="Save" onclick="javascript:UpdateAccount()"/></td>
				<td><input type="button" name="CancelNS" id="CancelNS" style="position:absolute;top:750px;left:760px;right:0px;bottom:0px;width: 100px;height:25px;" value="Cancel" onClick="window.location='ControllerServlet?page=updateNA.jsp&actionType=UpdateNA'" /><input type="hidden" id="orderSource" name="orderSource" value="<%=dbUser.orderSource%>"/></td>
			</tr>
		</table>

			<!-- EDI Section -->
		

			
			<table name="ediTable" id="ediTable">
			<tr>
			 <td></td>
			 <td></td>
			</tr>
			<tr>
				<td name="catViewOnly" id="catViewOnly">Catalog View Only Account?</td>
				<%if(dbUser.catView.equals("N")){%>
				<td><select name="catView" id="catView">
					<option value="N" selected>No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="catView" id="catView">
					<option value="Y" selected>Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="acctActiveEDI" id="acctActiveEDI">Account is Active?</td>
				<%if(dbUser.acctActive.equals("N")){%>
				<td><select name="acctActive" id="nsacctActive">
				<option value="N" selected>No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="acctActive" id="acctActive">
				<option value="Y" selected>Yes</option>
				<option value="N">No</option>
				</select></td>
				<% } %>
				<input type="hidden" name="activeCheck" id="activeCheck" value="<%=dbUser.acctActive%>" />
			</tr>
			<tr>
			<td name="ddMTUsed" id="ddMTUsed">DDMT Used?</td>
				<%if(dbUser.ddMT.equals("N")){ %>
				<td><select name="ddMT" id="ddMT">
				<option value="N" selected>No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="ddMT" id="ddMT">
				<option value="Y" selected>Yes</option>
				<option value="N">No</option>
				</select></td>
			  <% } %>
			</tr>
			<tr>
				<td name="imagedUsed" id="imagedUsed">Item Images Used?</td>
				<%if(dbUser.imgUsed.equals("N")){ %>
				<td><select name="imgUsed" id="imgUsed">
				<option value="N" selected>No</option>
				<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="imgUsed" id="imgUsed">
				<option value="Y" selected>Yes</option>
				<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="itemEnrich" id="itemEnrich">Item Enrichment?</td>
				<%if(dbUser.enrichMent.equals("N")){%>
				<td><select name="enrichMent" id="enrichMent">
					<option value="N" selected>No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="enrichMent" id="enrichMent">
					<option value="Y" selected>Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="sdsProvided" id="sdsProvided">SDS Provided?</td>
				<%if(dbUser.sDs.equals("N")){%>
				<td><select name="sDs" id="sDs">
					<option value="N" selected>No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="sDs" id="sDs">
					<option value="Y" selected>Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
				<td name="barAvail" id="barAvail">Barcodes Available?</td>
				<%if(dbUser.barCodes.equals("N")){%>
				<td><select name="barCodes" id="barCodes">
					<option value="N" selected>No</option>
					<option value="Y">Yes</option>
				</select></td>
				<%} else { %>
				<td><select name="barCodes" id="barCodes">
					<option value="Y" selected>Yes</option>
					<option value="N">No</option>
				</select></td>
				<% } %>
			</tr>
			<tr>
			<%//System.out.println("Launch date = "+dbUser.ediLaunch); %>
				<td name="ediDate" id="ediDate">Launch Date:</td>
				<td><input readonly="true" type="text" id="ediLaunch" name="ediLaunch" value="<%=dbUser.ediLaunch%>"/></td>
			</tr>
			<tr>
				<td name="specNotesNS" id="specNotesNS">Special Setup Notes:</td>
				<td><textarea name="addNotes" id="addNotes"><%=dbUser.addNotes%></textarea></td> 
			</tr>
		</table>
		<br>
		<br>
		<br>
		<table>
			<tr colspan="4">
				<td><input type="button" name="Submitedi" id="Submitedi" value="Save" style="position:absolute;top:540px;left:670px;right:0px;bottom:0px;width: 100px;height:25px;" value="Save" onclick="javascript:UpdateAccount()" /></td> 
				<td><input type="button" name="Canceledi" id="Canceledi" value="Cancel" style="position:absolute;top:540px;left:550px;right:0px;bottom:0px;width: 100px;height:25px;" value="Cancel" onClick="javascript:Cancel()"  />
					<input name="typeAction" type="hidden" id="typeAction" value="I" /><input type="hidden" id="orderSource" name="orderSource" value="<%=dbUser.orderSource%>"/></td>
			</tr>
			</table>


			<% 
		
} if (actionType.equals("SaveUpdateNA")) { 

String confirmMsg = "The National Account was successfully updated.";

%>
		<table style="margin: 0 auto;">
			<tr>
				<td ><span class="subTitle"><%=confirmMsg%></span><br />
					<br /></td>
			</tr>

			<%

}//national account was successfully updated 
		

%>
		</table>
		</div>
	</div>

</form>





</body>
</html>