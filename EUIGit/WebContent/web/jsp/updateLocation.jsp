<%@ include file="banner.jsp"%>
<%@ page import="java.util.Vector"%>
<%@ page
	import="java.lang.*, java.io.*, java.util.*, java.text.*, java.sql.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>
<html>
<body id="wrapper">
<%
String actionType = (String)request.getParameter("actionType");
%>
<script language="Javascript">
	
   function getNAFromMember() {
   //gets national account list based on member selected (ecommerce platform also passed)
   document.updtL.actionType.value="UpdateLocationMem";
   document.updtL.submit();
   }
   
   function getMemberFromNA() {
   //gets member listing based on national account selected (ecommerce platform also passed)
   document.updtL.actionType.value="UpdateLocationNA";
   document.updtL.submit();
   }
   
   function getLocationNAMin() {
   //gets member listing based on national account selected (ecommerce platform also passed)
   document.updtL.actionType.value="UpdateLocationNAMin";
   document.updtL.submit();
   }
   
   function getLocationDtl() {
   //gets member listing based on national account & member selected
   		if (document.updtL.natAcct.value=="none") {
		alert("Select a National Account.");
		document.updtL.natAcct.focus();
		}
		else if (document.updtL.member.value=="none") {
		alert("Select a Member Major/Minor.");
		document.updtL.member.focus();
		}
		else if (document.updtL.natAcctMin.value=="none") {
		alert("Select a Customer Minor or Location.");
		document.updtL.natAcctMin.focus();
		}
		else {		
   document.updtL.actionType.value="UpdateLocationDtl";
   document.updtL.submit();
   		}
   }
   
   
   //added 4/26/2011 if no member selected to filter customer locations
   function getLocationDtl_noMem() {
   //gets member listing based on national account & member selected
   		if (document.updtL.natAcct.value=="none") {
		alert("Select a National Account.");
		document.updtL.natAcct.focus();
		}
		else if (document.updtL.natAcctMin.value=="none") {
		alert("Select a Customer Minor or Location.");
		document.updtL.natAcctMin.focus();
		}
		else {		
   document.updtL.actionType.value="UpdateLocationDtl_noMem";
   document.updtL.submit();
   		}
   }
   
   
   function getLocationDtlACM() {
   //gets member listing based on national account & member selected
   		if (document.updtL.natAcct.value=="none") {
		alert("Select a National Account.");
		document.updtL.natAcct.focus();
		}
		else if (document.updtL.member.value=="none") {
		alert("Select a Member Major/Minor.");
		document.updtL.member.focus();
		}
		else if (document.updtL.natAcctMin.value=="none") {
		alert("Select a Customer Minor or Location.");
		document.updtL.natAcctMin.focus();
		}
		else if (document.updtL.custMinCode.value=="none") {
		alert("Select an Alternate Location ID.");
		document.updtL.custMinCode.focus();
		}
		else {		
   document.updtL.actionType.value="UpdateLocationDtlACM";
   document.updtL.submit();
   		}
   }

   
   function SaveUpdateLocation(){  
   			document.updtL.actionType.value = "SaveUpdateLocation";
			document.updtL.page.value="updateLocation.jsp";
			document.updtL.submit();
	}
	
	function Cancel(){
			document.updtL.actionType.value = "UpdateLocation";
			document.updtL.page.value="updateLocation.jsp";
			document.updtL.submit();
	}
   
  
  
function checkChars(field) {
var max=128;
if (field.value.length > max) {
alert("You have surpassed the 128 character maximum.  Please shorten your entry.");
field.focus();
field.select();
return false;
   }
else return true;
}

function replaceChars(entry) {
out = "'"; // replace this
add = "`"; // with this
temp = "" + entry; // temporary holder

while (temp.indexOf(out)>-1) {
pos= temp.indexOf(out);
temp = "" + (temp.substring(0, pos) + add + 
temp.substring((pos + out.length), temp.length));
}
document.updtL.comments.value = temp;
}


function changeActiveInactive() {

//var element = document.getElementById('orderGuide');
var element = document.getElementById('active');
var element1 = document.getElementById('activeI');

var element2 = document.getElementById('PrevOG');

	if (element2.value.length==0) {

	element.disabled=false;
	element1.disabled=false;
	
	} 

//if (element.checked==true)
   //{
    //var strng = element.checkbox1.id;
    //element = document.getElementById('send1');
    //element.disabled=false;
    //element = document.getElementById('recv1');
    //element.disabled=false;
    //}
    //else
    //{      
    //element = document.getElementById('send1');
    //element.disabled=true;
    //element = document.getElementById('recv1');
    //element.disabled=true;
    // }

}
</script>


<form action="ControllerServlet?page=updateLocation.jsp" method="post"
	name="updtL">
	<input type=hidden name='actionType' value=""> <input
		type=hidden name='page' value="">
	<div id="inputField">
<br>
<br>
		<span class="subTitle">Update Location</span> <br /> <br />


		<% 
int countACM=0;

if (actionType.equals("UpdateLocation")) { %>
		<table border="0" cellpadding="0">
			<tr>
				<td>Member:</td>
				<td><select name="member"
					onchange="javascript:getNAFromMember()">
						<option value="none" selected="selected">--- Select One
							---</option>
						<%
		for (int k = 0; k < dbUser.memberList.size(); k++) {
         Vector memberL = (Vector) dbUser.memberList.elementAt(k); %>
						<option
							value="<%=memberL.elementAt(0)%>,<%=memberL.elementAt(2)%>;<%=memberL.elementAt(5)%>"><%=memberL.elementAt(1)%>
							-
							<%=memberL.elementAt(3)%> -
							<%=memberL.elementAt(4)%> -
							<%=memberL.elementAt(5)%></option>
						<%    }			
%>
				</select></td>

				<td>National Account:</td>
				<td><select name="natAcct" id="natAcct"
					onchange="javascript:getMemberFromNA()">
						<option value="none" selected="selected">--- Select One
							---</option>
						<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j); %>
						<option
							value="<%=natAcct.elementAt(0)%>,<%=natAcct.elementAt(3)%>"><%=natAcct.elementAt(1)%>
							-
							<%=natAcct.elementAt(2)%> -
							<%=natAcct.elementAt(3)%></option>
						<%    }			
%>
				</select></td>
			</tr>
		</table>

		<% } if (actionType.equals("UpdateLocationNA")) { %>

		<table border="0" cellpadding="0">
			<tr>
				<td>Member:</td>
				<td><select name="member"
					onchange="javascript:getLocationNAMin()">
						<option value="none" selected="selected">--- Select One
							---</option>
						<%
		for (int k = 0; k < dbUser.memberList.size(); k++) {
         Vector memberL = (Vector) dbUser.memberList.elementAt(k); %>
						<option
							value="<%=memberL.elementAt(0)%>,<%=memberL.elementAt(2)%>"><%=memberL.elementAt(1)%>
							-
							<%=memberL.elementAt(3)%> -
							<%=memberL.elementAt(4)%></option>
						<%    }			
%>
				</select></td>

				<td>National Account:</td>
				<td>
					<!-- <%//=dbUser.naNbrF
	  %>  - <%//=dbUser.nationalAccountName
	  %> --> <select name="natAcct" id="natAcct"
					onchange="javascript:getMemberFromNA()">
						<option value="<%=dbUser.nationalAccountNbr%>" selected="selected"><%=dbUser.naNbrF%>
							-
							<%=dbUser.nationalAccountName%> -
							<%=dbUser.eplatform%></option>
						<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j); %>
						<option
							value="<%=natAcct.elementAt(0)%>,<%=natAcct.elementAt(3)%>"><%=natAcct.elementAt(1)%>
							-
							<%=natAcct.elementAt(2)%> -
							<%=natAcct.elementAt(3)%></option>
						<%    }			
%>
				</select> <input type="hidden" name="natAcct"
					value="<%=dbUser.nationalAccountNbr%>" /> <input type="hidden"
					name="eplatform" value="<%=dbUser.eplatform%>" />
				</td>

			</tr>

			<tr>
				<td>E-Commerce Platform:</td>
				<td><%=dbUser.eplatform%></td>

				<td>Customer Minor# or Location:</td>
				<td><select name="natAcctMin"
					onchange="javascript:getLocationDtl_noMem()">
						<option value="none" selected="selected">--- Select One
							---</option>
						<%
		for (int m = 0; m < dbUser.nationalAccountMinList.size(); m++) {
         Vector custMinL = (Vector) dbUser.nationalAccountMinList.elementAt(m); %>
						<option value="<%=custMinL.elementAt(0)%>"><%=custMinL.elementAt(1)%></option>
						<%    }			
%>
				</select></td>

			</tr>
		</table>

		<% } if (actionType.equals("UpdateLocationMem")) { %>

		<table border="0" cellpadding="0">
			<tr>
				<td>Member:</td>
				<td>
					<!-- <%//=dbUser.memNbrF
	  %> - <%//=dbUser.memMinNbrF
	  %> - <%//=dbUser.memberName
	  %> --> <select name="member" onchange="javascript:getNAFromMember()">
						<option value="<%=dbUser.memberNbr%>,<%=dbUser.memberMinNbr%>"
							selected="selected"><%=dbUser.memNbrF%> -
							<%=dbUser.memMinNbrF%> -
							<%=dbUser.memberName%> -
							<%=dbUser.eplatform%>
						</option>
						<%
		for (int k = 0; k < dbUser.memberList.size(); k++) {
         Vector memberL = (Vector) dbUser.memberList.elementAt(k); %>
						<option
							value="<%=memberL.elementAt(0)%>,<%=memberL.elementAt(2)%>;<%=memberL.elementAt(5)%>"><%=memberL.elementAt(1)%>
							-
							<%=memberL.elementAt(3)%> -
							<%=memberL.elementAt(4)%> -
							<%=memberL.elementAt(5)%></option>
						<%    }			
%>
				</select> <input type="hidden" name="member"
					value="<%=dbUser.memberNbr%>,<%=dbUser.memberMinNbr%>" /> <input
					type="hidden" name="eplatform" value="<%=dbUser.eplatform%>" />
				</td>

				<td>National Account:</td>
				<td><select name="natAcct" id="natAcct"
					onchange="javascript:getLocationNAMin()">
						<option value="none" selected="selected">--- Select One
							---</option>
						<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j); %>
						<option value="<%=natAcct.elementAt(0)%>"><%=natAcct.elementAt(1)%>
							-
							<%=natAcct.elementAt(2)%>
						</option>
						<%    }			
%>
				</select></td>
			</tr>

			<tr>
				<td>E-Commerce Platform:</td>
				<td><%=dbUser.eplatform%></td>

				<td>&nbsp;</td>
				<td>&nbsp;</td>

			</tr>
		</table>

		<% } else if (actionType.equals("UpdateLocationNAMin")) { %>

		<table border="0" cellpadding="0">
			<tr>
				<td>Member:</td>
				<td>
					<!-- <%//=dbUser.memNbrF
	  %> - <%//=dbUser.memMinNbrF
	  %> - <%//=dbUser.memberName
	  %> --> <select name="member" onchange="javascript:getNAFromMember()">
						<option value="<%=dbUser.memberNbr%>,<%=dbUser.memberMinNbr%>"
							selected="selected"><%=dbUser.memNbrF%> -
							<%=dbUser.memMinNbrF%> -
							<%=dbUser.memberName%> -
							<%=dbUser.eplatform%>
						</option>
						<%
		for (int k = 0; k < dbUser.memberList.size(); k++) {
         Vector memberL = (Vector) dbUser.memberList.elementAt(k); %>
						<option
							value="<%=memberL.elementAt(0)%>,<%=memberL.elementAt(2)%>;<%=memberL.elementAt(5)%>"><%=memberL.elementAt(1)%>
							-
							<%=memberL.elementAt(3)%> -
							<%=memberL.elementAt(4)%> -
							<%=memberL.elementAt(5)%></option>
						<%    }			
%>
				</select> <input type="hidden" name="member"
					value="<%=dbUser.memberNbr%>,<%=dbUser.memberMinNbr%>" /> <input
					type="hidden" name="eplatform" value="<%=dbUser.eplatform%>" />
				</td>

				<td>National Account:</td>
				<td>
					<!-- <%//=dbUser.naNbrF
	  %>  - <%//=dbUser.nationalAccountName
	  %> --> <select name="natAcct" id="natAcct"
					onchange="javascript:getMemberFromNA()">
						<option value="<%=dbUser.nationalAccountNbr%>" selected="selected"><%=dbUser.naNbrF%>
							-
							<%=dbUser.nationalAccountName%> -
							<%=dbUser.eplatform%></option>
						<%
		for (int j = 0; j < dbUser.nationalAccountList.size(); j++) {
         Vector natAcct = (Vector) dbUser.nationalAccountList.elementAt(j); %>
						<option
							value="<%=natAcct.elementAt(0)%>,<%=natAcct.elementAt(3)%>"><%=natAcct.elementAt(1)%>
							-
							<%=natAcct.elementAt(2)%> -
							<%=natAcct.elementAt(3)%></option>
						<%    }			
%>
				</select> <input type="hidden" name="natAcct"
					value="<%=dbUser.nationalAccountNbr%>" />
				</td>
			</tr>

			<tr>
				<td>E-Commerce Platform:</td>
				<td><%=dbUser.eplatform%></td>

				<td>Customer Minor# or Location:</td>
				<td><select name="natAcctMin"
					onchange="javascript:getLocationDtl()">
						<option value="none" selected="selected">--- Select One
							---</option>
						<%
		for (int m = 0; m < dbUser.nationalAccountMinList.size(); m++) {
         Vector custMinL = (Vector) dbUser.nationalAccountMinList.elementAt(m); %>
						<option value="<%=custMinL.elementAt(0)%>"><%=custMinL.elementAt(1)%></option>
						<%    }			
%>
				</select></td>

			</tr>
		</table>


		<% } if (actionType.equals("UpdateLocationDtl") || actionType.equals("UpdateLocationDtl_noMem")) { %>

		<table border="0" cellpadding="0">
			<tr>
				<td>Member:</td>
				<td><%=dbUser.memNbrF%> - <%=dbUser.memMinNbrF%> - <%=dbUser.memberName%>


				</td>
			</tr>

			<tr>

				<td>National Account Location:</td>
				<td><%=dbUser.naNbrF%> - <%=dbUser.naMinNbrF%> - <%=dbUser.nationalAccountName%>
					<input type="hidden" name="member"
					value="<%=dbUser.memberNbr%>,<%=dbUser.memberMinNbr%>" /> <input
					type="hidden" name="eplatform" value="<%=dbUser.eplatform%>" /> <input
					type="hidden" name="natAcct" value="<%=dbUser.nationalAccountNbr%>" />
					<input type="hidden" name="natAcctMin"
					value="<%=dbUser.nationalAccountNbrMin%>" /></td>
			</tr>

			<tr>
				<td>E-Commerce Platform:</td>
				<td><%=dbUser.eplatform%></td>
			</tr>

			<tr>
				<td>Zone:</td>
				<td><%=dbUser.zone%></td>
			</tr>

			<% if (dbUser.acmFlag.equals("Y")) { 
	//int countACM=0;
	for (int zz = 0; zz < dbUser.custMinCode.size(); zz++) {
        Vector acmList1 = (Vector) dbUser.custMinCode.elementAt(zz);        
        countACM++;
	    }			
	if (countACM >1) {

%>
			<tr>
				<td>Alternative Location ID:</td>
				<td><select name="custMinCode" id="custMinCode"
					onchange="javascript:getLocationDtlACM()">
						<option value="none" selected="selected">--- Select One
							---</option>
						<%
		for (int f = 0; f < dbUser.custMinCode.size(); f++) {
         Vector acmList = (Vector) dbUser.custMinCode.elementAt(f); %>
						<option value="<%=acmList.elementAt(0)%>"><%=acmList.elementAt(0)%>
						</option>
						<%    }			
%>
				</select></td>
			</tr>
			<% } //if vector includes more than 1 alt cust min code
  
  } //if acmFlag = Y
  %>
		</table>


		<% if (dbUser.acmFlag.equals("Y") && countACM > 1) { } else { %>
		<div id="actionFieldMM">

			<table>
				<%
		int count=0;
		for (int z = 0; z < dbUser.memberEmailList.size(); z++) {
         Vector memberULoc = (Vector) dbUser.memberEmailList.elementAt(z); 
		 %>

				<tr>
					<th>Alternative Location ID:</th>
					<td><%=memberULoc.elementAt(0)%> <input type="hidden"
						name="lpID" value="<%=memberULoc.elementAt(11)%>" /> <input
						name="acmCode" type="hidden" id="acmCode"
						value="<%=memberULoc.elementAt(0)%>" /></td>
					<th>PO Required:</th>
					<td>
						<% if (memberULoc.elementAt(1).equals("N")) { %> No <% } else { %> Yes
						<% } %> <%//=memberULoc.elementAt(1)
	 %>
					</td>

				</tr>
				<tr>
					<th>UserName:</th>
					<td><%=memberULoc.elementAt(3)%> <input name="username"
						type="hidden" id="username" value="<%=memberULoc.elementAt(3)%>" />
					</td>
					<th>Password:</th>
					<td>
						<% if (memberULoc.elementAt(4).equals("")) {} else { %><%=memberULoc.elementAt(4)%>
						<% } %> <input name="password" type="hidden" id="password"
						value="<%=memberULoc.elementAt(4)%>" /> <input name="companyCode"
						type="hidden" id="companyCode"
						value="<%=memberULoc.elementAt(12)%>" /> <input
						name="secondaryMember" type="hidden" id="secondaryMember"
						value="<%=memberULoc.elementAt(2)%>" />
					</td>

				</tr>
				<tr>
					<th>Last Updated By:</th>
					<td><%=memberULoc.elementAt(9)%></td>
					<th>Last Updated Date:</th>
					<td><%=memberULoc.elementAt(10)%></td>

				</tr>
				<tr>
					<th>Order Guide:</th>
					<td colspan="4"><input type="hidden"
						value="<%=memberULoc.elementAt(5)%>" name="prevOG" /> <select
						name="orderGuide" onChange="changeActiveInactive()">

							<% if (memberULoc.elementAt(5).toString().equals("")) {%>
							<option value="none" selected="selected" style="font-size: 8px;">---
								Select One ---</option>
							<% } else { %>
							<option value="<%=memberULoc.elementAt(5) %>" selected="selected"
								style="font-size: 8px;"><%=memberULoc.elementAt(5) %></option>
							<% } %>

							<%
Connection oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
Statement oStmt = oConn.createStatement();
PreparedStatement oPStmt = null;
ResultSet oRS = null;
ResultSet oRS1 = null;
Statement oStmt1 = oConn.createStatement();

//get list of custMaj based on company code - memberULoc.elementAt(12)
String custNbr = "";
String custList = "";
int rowN=1;
oRS = oStmt.executeQuery("select distinct(CustomerMaj) custMaj from "+dbUser.eplatform+"LocationProperties Where CompanyCode ="+memberULoc.elementAt(12).toString()+"");
while (oRS.next()) {
rowN = oRS.getRow();
custNbr = oRS.getString("custMaj");

	if (rowN==1) {
	custList = custNbr;
	} else {
	custList = custList.concat(", ").concat(custNbr);
	}
}

//select distinct(alp.CustomerMaj) custMaj, acm.catalogPrefix from dbo.AccessLocationProperties alp
//inner join dbo.Access_CustomerMaster acm on alp.customerMaj = acm.customerNumber
//Where alp.CompanyCode =8


String catalogPrefix = "";
//oRS = oStmt.executeQuery("Select CatalogPrefix from "+dbUser.eplatform+"_CustomerMaster Where CustomerNumber="+dbUser.nationalAccountNbr+"");
	//while (oRS.next()){
	//catalogPrefix = oRS.getString("CatalogPrefix");
	//}

String memMaj = "";
String memMaj_noF = ""; //used if customer minor OG, don't front fill member #
String memMin = "";
String memName = "";
String custMinNbr = "";
String custMinNbrF = "";
String custMinOG = "";
String zone = "";

String custName = "";
String custNum = "";
		
		//oPStmt = oConn.prepareCall("usp_EUI_GetFMTOrderGuide @custMaj ="+dbUser.nationalAccountNbr+", @mbrMaj = "+dbUser.memberNbr+"");
		
		//add 2/11/2011
		String countOG="";
		
		oRS = oStmt.executeQuery("Select count(*) total from SQL2.FormularyManagement.dbo.FormularyHdr where CustNbr in ((SELECT ISNULL(datavalue,'') FROM Ecommerce.dbo.ParseDelimtedStringToTable ('"+custList+"',','))) and MbrNbr='"+dbUser.memberNbr+"'");
			while (oRS.next()) {
			countOG = oRS.getString("total");
			}
			
			//System.out.println("OG Count "+countOG);
			
			if (!countOG.equals("0")) {
		//2/11/2011
		//System.out.println("match OG for customer/vendor");
			
		oPStmt = oConn.prepareCall("usp_EUI_GetFMTOrderGuide @custMaj = '"+custList+"', @mbrMaj = '"+dbUser.memberNbr+"'");
		oRS = oPStmt.executeQuery();
		
		//System.out.println("usp_EUI_GetFMTOrderGuide @custMaj ='"+custList+"', @mbrMaj = "+dbUser.memberNbr+"");
		 
		 while (oRS.next()) { 
		 memMaj = oRS.getString("memNbr_f");
		 memMaj_noF = oRS.getString("MbrNbr");
		 memMin = oRS.getString("memMin_f");
		 memName = oRS.getString("NameMember");
		 custMinNbr = oRS.getString("CustMinNbr");
		 custMinNbrF = oRS.getString("custMinNbr_f");
		 custName = oRS.getString("NameAcct");
		 custNum = oRS.getString("CustNbr");
		 zone = oRS.getString("zone");
		 
		 	oRS1 = oStmt1.executeQuery("Select CatalogPrefix from "+dbUser.eplatform+"_CustomerMaster Where CustomerNumber="+custNum+"");
			while (oRS1.next()) {
			catalogPrefix = oRS1.getString("CatalogPrefix");
			}
			
		 	//if (custMinNbr.equals("-1")) {
			if (custMinNbr.equals("-1") || custMinNbr.equals("0")) {
			custMinOG = ""; %>
							<option
								value="<%=catalogPrefix%><%=memMaj%><%=memMin%>Z<%=zone%>"
								style="font-size: 8px;"><%=memMaj%> -
								<%=memMin%> [Z<%=zone%>]
								<%=memName%> :
								<%=custNum%> -
								<%=custName%></option>
							<% } else { 
			custMinOG = custMinNbrF+" -- ";
			%>
							<option
								value="<%=catalogPrefix%><%=memMaj_noF%><%=custNum%><%=custMinNbr%>Z<%=zone%>"
								style="font-size: 8px;"><%=custMinOG%>
								<%=custNum%> -
								<%=custName%> :
								<%=memMaj%> -
								<%=memMin%> [Z<%=zone%>]
								<%=memName%></option>
							<!-- used dbUser.nationalAccountNbr in order guide instead of custNum - fixed 6/3/09 -->
							<% } %>
							<%    	

if (catalogPrefix.equals("")) { //no result from oRS		
			oRS1.close();
			oStmt1.close();
	}
} //end of recordset next loop	
	

 //02/11/2011
 oRS.close();
oPStmt.close();
oStmt.close();
oConn.close();

} //end of if no order guides available

if (!catalogPrefix.equals("")) { //no result from oRS		
			oRS1.close();
			oStmt1.close();
	}


//oRS.close();
//oPStmt.close();
//oStmt.close();
//oConn.close();

%>
					</select></td>
				</tr>
				<tr>
					<th>Location Email:</th>
					<td colspan="4"><input name="locationEmail" type="text"
						value="<% if (memberULoc.elementAt(6).equals("") || memberULoc.elementAt(6)==null) { } else { %><%=memberULoc.elementAt(6)%><% } %>"
						size="100" maxlength="200" /></td>
				</tr>

				<tr>
					<th>Member Email:</th>
					<td colspan="4">
						<% if (memberULoc.elementAt(7).equals("")) { } else { %> <%=memberULoc.elementAt(7)%>
						<% } %> <input type="hidden" name="memberEmail"
						value="<% if (memberULoc.elementAt(7).equals("")) { } else { %> <%=memberULoc.elementAt(7)%><% } %>" />
					</td>
				</tr>
				<tr>
					<th>Active/Inactive:</th>
					<td>
						<%// if (memberULoc.elementAt(8).equals("1")) {
 	if (memberULoc.elementAt(5).toString().equals("")) { //if no order guide selected, this is disabled
	%> <input name="active" id="active" type="radio" value="1"
						disabled="disabled" />Active <input name="active" id="activeI"
						type="radio" value="0" checked disabled="disabled" />Inactive <% } else {
		if (memberULoc.elementAt(8).equals("1")) {
	%> <input name="active" type="radio" value="1" checked /> Active <input
						name="active" type="radio" value="0" /> Inactive <% } else { %> <input
						name="active" type="radio" value="1" /> Active <input
						name="active" type="radio" value="0" checked /> Inactive <% } 
	  } //if order guide is selected
	  %>
					</td>
					<th></th>
					<td colspan="3"></td>
				</tr>
				<tr>
					<th>Current Comments:</th>
					<td colspan="4">
						<% 
	  int countR=0;
	  for (int y = 0; y < dbUser.locationList.size(); y++) {
         Vector locC = (Vector) dbUser.locationList.elementAt(y); %> <%=locC.elementAt(0)%>
						- Saved by: <%=locC.elementAt(2)%> on <%=locC.elementAt(1)%> <br />
						<% 
		 countR++;
		 } %> <% if (countR==0) { %> <span class="errorField">There are
							no comments saved for this location</span> <% } %>
					</td>
				</tr>
				<tr>
					<th>Comments:</th>
					<td colspan="4"><textarea name="comments" cols="50" rows="5"
							onBlur="replaceChars(this.value); checkChars(this);"></textarea></td>
				</tr>

				<% 
	count++;
	} %>

				<% if (count==0) { %>
				<tr>
					<td colspan="5"><span class="errorField">No Location
							information is saved based on the customer and member information
							selected.</span></td>
				</tr>
				<% } else { %>

				<tr>
					<td colspan="5"><input type="button" name="Submit" id="Submit"
						value="Save" onclick="SaveUpdateLocation()" /> <input
						type="button" name="Submit" id="Submit" value="Cancel"
						onclick="Cancel()" /> <input name="typeAction" type="hidden"
						id="typeAction" value="U" /></td>
				</tr>
				<% } %>
			</table>

		</div>
		<% } //get additinal alt cust min code filter
		%>


		<% } if (actionType.equals("UpdateLocationDtlACM")) { %>

		<table border="0" cellpadding="0">
			<tr>
				<td>Member:</td>
				<td><%=dbUser.memNbrF%> - <%=dbUser.memMinNbrF%> - <%=dbUser.memberName%>
				</td>
			</tr>

			<tr>

				<td>National Account Location:</td>
				<td><%=dbUser.naNbrF%> - <%=dbUser.naMinNbrF%> - <%=dbUser.nationalAccountName%>
					<input type="hidden" name="member"
					value="<%=dbUser.memberNbr%>,<%=dbUser.memberMinNbr%>" /> <input
					type="hidden" name="eplatform" value="<%=dbUser.eplatform%>" /> <input
					type="hidden" name="natAcct" value="<%=dbUser.nationalAccountNbr%>" />
					<input type="hidden" name="natAcctMin"
					value="<%=dbUser.nationalAccountNbrMin%>" /></td>
			</tr>

			<tr>
				<td>E-Commerce Platform:</td>
				<td><%=dbUser.eplatform%></td>
			</tr>

		</table>


		<div id="actionFieldMM">

			<table>
				<%
		int count=0;
		for (int z = 0; z < dbUser.memberEmailList.size(); z++) {
         Vector memberULoc = (Vector) dbUser.memberEmailList.elementAt(z); %>

				<tr>
					<th>Alternative Location ID:</th>
					<td><%=memberULoc.elementAt(0)%> <input type="hidden"
						name="lpID" value="<%=memberULoc.elementAt(11)%>" /></td>
					<th>PO Required:</th>
					<td>
						<% if (memberULoc.elementAt(1).equals("N")) { %> No <% } else { %> Yes
						<% } %> <%//=memberULoc.elementAt(1)
	 %>
					</td>


				</tr>
				<tr>
					<th>UserName:</th>
					<td><%=memberULoc.elementAt(3)%></td>
					<th>Password:</th>
					<td>
						<% if (memberULoc.elementAt(4).equals("")) {} else { %><%=memberULoc.elementAt(4)%>
						<% } %>
					</td>

				</tr>
				<tr>
					<th>Last Updated By:</th>
					<td><%=memberULoc.elementAt(9)%></td>
					<th>Last Updated Date:</th>
					<td><%=memberULoc.elementAt(10)%></td>

				</tr>
				<tr>
					<th>Order Guide:</th>
					<td colspan="4"><input type="hidden"
						value="<%=memberULoc.elementAt(5)%>" name="prevOG" /> <select
						name="orderGuide" onChange="changeActiveInactive()">

							<% if (memberULoc.elementAt(5).toString().equals("")) {%>
							<option value="none" selected="selected" style="font-size: 8px;">---
								Select One ---</option>
							<% } else { %>
							<option value="<%=memberULoc.elementAt(5) %>" selected="selected"
								style="font-size: 8px;"><%=memberULoc.elementAt(5) %></option>
							<% } %>

							<%
Connection oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
Statement oStmt = oConn.createStatement();
PreparedStatement oPStmt = null;
ResultSet oRS = null;
ResultSet oRS1 = null;
Statement oStmt1 = oConn.createStatement();

//get list of custMaj based on company code - memberULoc.elementAt(12)
String custNbr = "";
String custList = "";
int rowN=1;
oRS = oStmt.executeQuery("select distinct(CustomerMaj) custMaj from "+dbUser.eplatform+"LocationProperties Where CompanyCode ="+memberULoc.elementAt(12).toString()+"");
while (oRS.next()) {
rowN = oRS.getRow();
custNbr = oRS.getString("custMaj");

	if (rowN==1) {
	custList = custNbr;
	} else {
	custList = custList.concat(", ").concat(custNbr);
	}
}

//select distinct(alp.CustomerMaj) custMaj, acm.catalogPrefix from dbo.AccessLocationProperties alp
//inner join dbo.Access_CustomerMaster acm on alp.customerMaj = acm.customerNumber
//Where alp.CompanyCode =8


String catalogPrefix = "";
//oRS = oStmt.executeQuery("Select CatalogPrefix from "+dbUser.eplatform+"_CustomerMaster Where CustomerNumber="+dbUser.nationalAccountNbr+"");
	//while (oRS.next()){
	//catalogPrefix = oRS.getString("CatalogPrefix");
	//}

String memMaj = "";
String memMaj_noF = ""; //used if customer minor OG, don't front fill member #
String memMin = "";
String memName = "";
String custMinNbr = "";
String custMinNbrF = "";
String custMinOG = "";
String zone = "";

String custName = "";
String custNum = "";
		
		//oPStmt = oConn.prepareCall("usp_EUI_GetFMTOrderGuide @custMaj ="+dbUser.nationalAccountNbr+", @mbrMaj = "+dbUser.memberNbr+"");
		oPStmt = oConn.prepareCall("usp_EUI_GetFMTOrderGuide @custMaj = '"+custList+"', @mbrMaj = '"+dbUser.memberNbr+"'");
		oRS = oPStmt.executeQuery();
		
		//System.out.println("usp_EUI_GetFMTOrderGuide @custMaj ='"+custList+"', @mbrMaj = "+dbUser.memberNbr+"");
		 
		 while (oRS.next()) {
		 memMaj = oRS.getString("memNbr_f");
		 memMaj_noF = oRS.getString("MbrNbr");
		 memMin = oRS.getString("memMin_f");
		 memName = oRS.getString("NameMember");
		 custMinNbr = oRS.getString("CustMinNbr");
		 custMinNbrF = oRS.getString("custMinNbr_f");
		 custName = oRS.getString("NameAcct");
		 custNum = oRS.getString("CustNbr");	
		 zone = oRS.getString("zone");	 
		 
		 	oRS1 = oStmt1.executeQuery("Select CatalogPrefix from "+dbUser.eplatform+"_CustomerMaster Where CustomerNumber="+custNum+"");
			while (oRS1.next()) {
			catalogPrefix = oRS1.getString("CatalogPrefix");
			}
			
		 	//if (custMinNbr.equals("-1")) {
			if (custMinNbr.equals("-1") || custMinNbr.equals("0")) {
			custMinOG = ""; %>
							<option
								value="<%=catalogPrefix%><%=memMaj%><%=memMin%>Z<%=zone%>"
								style="font-size: 8px;"><%=memMaj%> -
								<%=memMin%> [Z<%=zone%>]
								<%=memName%> :
								<%=custNum%> -
								<%=custName%></option>
							<% } else { 
			custMinOG = custMinNbrF+" -- ";
			%>
							<option
								value="<%=catalogPrefix%><%=memMaj_noF%><%=custNum%><%=custMinNbr%><%=zone%>"
								style="font-size: 8px;"><%=custMinOG%>
								<%=custNum%> -
								<%=custName%> :
								<%=memMaj%> -
								<%=memMin%> [Z<%=zone%>]
								<%=memName%></option>

							<!-- used dbUser.nationalAccountNbr in order guide instead of custNum - fixed 6/3/09 -->
							<% } %>
							<% 
   		
if (catalogPrefix.equals("")) { //no result from oRS		
			oRS1.close();
			oStmt1.close();
	}
} //end of recordset next loop	
	
	if (!catalogPrefix.equals("")) { //no result from oRS		
			oRS1.close();
			oStmt1.close();
	}

%>

							<%
oRS.close();
oPStmt.close();
oStmt.close();
oConn.close();
%>
					</select></td>
				</tr>

				<tr>
					<th>Location Email:</th>
					<td colspan="4"><input name="locationEmail" type="text"
						value="<% if (memberULoc.elementAt(6).equals("") || memberULoc.elementAt(6)==null) { } else { %><%=memberULoc.elementAt(6)%><% } %>"
						size="100" maxlength="200" /></td>
				</tr>

				<tr>
					<th>Member Email:</th>
					<td colspan="4">
						<% if (memberULoc.elementAt(7).equals("")) { } else { %> <%=memberULoc.elementAt(7)%>
						<% } %> <input type="hidden" name="memberEmail"
						value="<% if (memberULoc.elementAt(7).equals("")) { } else { %> <%=memberULoc.elementAt(7)%><% } %>" />
					</td>
				</tr>
				<tr>
					<th>Active/Inactive:</th>
					<td>
						<%// if (memberULoc.elementAt(8).equals("1")) {
 	if (memberULoc.elementAt(5).toString().equals("")) { //if no order guide selected, this is disabled
	%> <input name="active" id="active" type="radio" value="1"
						disabled="disabled" />Active <input name="active" id="activeI"
						type="radio" value="0" checked disabled="disabled" />Inactive <% } else {
		if (memberULoc.elementAt(8).equals("1")) {
	%> <input name="active" type="radio" value="1" checked /> Active <input
						name="active" type="radio" value="0" /> Inactive <% } else { %> <input
						name="active" type="radio" value="1" /> Active <input
						name="active" type="radio" value="0" checked /> Inactive <% } 
	  } //if order guide is selected
	  %>
					</td>

					<th>&nbsp;</th>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<th>Current Comments:</th>
					<td colspan="4">
						<% 
	  int countR=0;
	  for (int y = 0; y < dbUser.locationList.size(); y++) {
         Vector locC = (Vector) dbUser.locationList.elementAt(y); %> <%=locC.elementAt(0)%>
						- Saved by:<%=locC.elementAt(2)%> on <%=locC.elementAt(1)%> <br />
						<% 
		 countR++;
		 } %> <% if (countR==0) { %> <span class="errorField">There are
							no comments saved for this location</span> <% } %>
					</td>
				</tr>
				<tr>
					<th>Comments:</th>
					<td colspan="4"><textarea name="comments" cols="50" rows="5"
							onblur="replaceChars(this.value); checkChars(this);"></textarea></td>
				</tr>

				<% 
	count++;
	} %>

				<% if (count==0) { %>
				<tr>
					<td colspan="5"><span class="errorField">No Location
							information is saved based on the customer and member information
							selected.</span></td>
				</tr>
				<% } else { %>

				<tr>
					<td colspan="6"><input type="button" name="Submit" id="Submit"
						value="Save" onclick="SaveUpdateLocation()" /> <input
						type="button" name="Submit" id="Submit" value="Cancel"
						onclick="Cancel()" /> <input name="typeAction" type="hidden"
						id="typeAction" value="U" /></td>
				</tr>

				<% } %>
			</table>

		</div>


		<% } 
if (actionType.equals("SaveUpdateLocation")) { 

String confirmMsg = "";
String addMsg = "";

	if (dbUser.catalogName.equals("") && dbUser.memberActive.equals("0")) {
	addMsg = "  No order guide was selected for this location; therefore, it remains inactive.";
	}
	//if (dbUser.successF.equals("Y")) {

confirmMsg = "The location information was successfully updated. <br>"+addMsg;
	
	//}
%>

		<table>
			<tr>
				<td colspan="4"><span class="subTitle"><%=confirmMsg%></span><br />
					<br /></td>
			</tr>


			<% } //national account was successfully saved 
%>
		</table>
	</div>

</form>



<%@ include file="navMenu.jsp"%>


</body>
</html>