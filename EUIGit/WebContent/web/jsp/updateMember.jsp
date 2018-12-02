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
   document.updtM.actionType.value="UpdateMemberMem";
   document.updtM.submit();
   }
   
   function getMemberFromNA() {
   //gets member listing based on national account selected (ecommerce platform also passed)
   document.updtM.actionType.value="UpdateMemberNA";
   document.updtM.submit();
   }
   
   function getMemberDtl() {
   //gets member listing based on national account & member selected
   document.updtM.actionType.value="UpdateMemberDtl";
   document.updtM.submit();
   }

   //function getMemberMinDtl() {
   		//gets member listing based on national account & member major and minor selected
   //document.updtM.actionType.value="UpdateMemberMinDtl";
   //document.updtM.submit();
   //}
   
   function SaveUpdateMember(){
			document.updtM.actionType.value = "SaveUpdateMember";
			document.updtM.page.value="updateMember.jsp"
			document.updtM.submit();
	}
	
	function Cancel(){
			document.updtM.actionType.value = "UpdateMember";
			document.updtM.page.value="updateMember.jsp"
			document.updtM.submit();
	}
   
  
function changeActiveInactive(input) {

var count = input;
var element = document.getElementById('active'+input);
var element1 = document.getElementById('activeI'+input);
var element2 = document.getElementById('PrevOG'+input);

	if (element2.value.length==0) {

	element.disabled=false;
	element1.disabled=false;
	
	}
}

</script>


<form action="ControllerServlet?page=updateMember.jsp" method="post"
	name="updtM">
	<input type=hidden name='actionType' value=""> <input
		type=hidden name='page' value="">
	<div id="inputField">

		<span class="subTitle">Update Member</span> <br /> <br />


		<% if (actionType.equals("UpdateMember")) { %>
		
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
							<%=memberL.elementAt(5)%>
						</option>
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

		<% } if (actionType.equals("UpdateMemberNA")) { %>

		<table border="0" cellpadding="0">
			<tr>
				<td>Member:</td>
				<td><select name="member" onchange="javascript:getMemberDtl()">
						<option value="none" selected="selected">--- All Members
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
			</tr>

			<tr>
				<td>National Account:</td>
				<td>
					<!-- <%//=dbUser.naNbrF
	  %> - <%//=dbUser.nationalAccountName
	  %> --> <select name="natAcct" id="natAcct"
					onchange="javascript:getMemberFromNA()">
						<option value="<%=dbUser.nationalAccountNbr%>" selected="selected"><%=dbUser.naNbrF%>
							-
							<%=dbUser.nationalAccountName%> - netSupply
						</option>
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
					name="eplatform" value="netSupply" />
				</td>
			</tr>

			<tr>
				<td>E-Commerce Platform:</td>
				<td>netSupply</td>
			</tr>
		</table>

		<% } if (actionType.equals("UpdateMemberMem")) { %>

		<table border="0" cellpadding="0">
			<tr>
				<td>Member:</td>
				<td>
					<!--<%//=dbUser.memNbrF
	  %> - <%//=dbUser.memMinNbrF
	  %> - <%//=dbUser.memberName
	  %> --> <select name="member" onchange="javascript:getNAFromMember()">
						<option value="<%=dbUser.memberNbr%>,<%=dbUser.memberMinNbr%>"
							selected="selected"><%=dbUser.memNbrF%> -
							<%=dbUser.memMinNbrF%> -
							<%=dbUser.memberName%> - netSupply
						</option>
						<%
		for (int k = 0; k < dbUser.memberList.size(); k++) {
         Vector memberL = (Vector) dbUser.memberList.elementAt(k); %>
						<option
							value="<%=memberL.elementAt(0)%>,<%=memberL.elementAt(2)%>;<%=memberL.elementAt(5)%>"><%=memberL.elementAt(1)%>
							-
							<%=memberL.elementAt(3)%> -
							<%=memberL.elementAt(4)%> -
							<%=memberL.elementAt(5)%>
						</option>
						<%    }			
%>
				</select> <input type="hidden" name="member"
					value="<%=dbUser.memberNbr%>,<%=dbUser.memberMinNbr%>" /> <input
					type="hidden" name="eplatform" value="netSupply" />
				</td>
			</tr>

			<tr>
				<td>National Account:</td>
				<td><select name="natAcct" id="natAcct"
					onchange="javascript:getMemberDtl()">
						<option value="none" selected="selected">--- All National
							Accounts ---</option>
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
				<td>netSupply</td>
			</tr>
		</table>


		<% } if (actionType.equals("UpdateMemberDtl")) { %>

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
							<%=dbUser.memberName%> - netSupply
						</option>
						<%
		for (int k = 0; k < dbUser.memberList.size(); k++) {
         Vector memberL = (Vector) dbUser.memberList.elementAt(k); %>
						<option
							value="<%=memberL.elementAt(0)%>,<%=memberL.elementAt(2)%>;<%=memberL.elementAt(5)%>"><%=memberL.elementAt(1)%>
							-
							<%=memberL.elementAt(3)%> -
							<%=memberL.elementAt(4)%> -
							<%=memberL.elementAt(5)%>
						</option>
						<%    }			
%>
				</select>
				</td>
			</tr>

			<tr>
				<td>National Account:</td>
				<td>
					<!-- <%//=dbUser.naNbrF
  %> - <%//=dbUser.nationalAccountName
  %> --> <select name="natAcct" id="natAcct"
					onchange="javascript:getMemberFromNA()">
						<option value="<%=dbUser.nationalAccountNbr%>" selected="selected"><%=dbUser.naNbrF%>
							-
							<%=dbUser.nationalAccountName%> - netSupply
						</option>
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
				</select> <input type="hidden" name="member"
					value="<%=dbUser.memberNbr%>,<%=dbUser.memberMinNbr%>" /> <input
					type="hidden" name="eplatform" value="netSupply" /> <input
					type="hidden" name="natAcct" value="<%=dbUser.nationalAccountNbr%>" />
				</td>
			</tr>

			<tr>
				<td>E-Commerce Platform:</td>
				<td>netSupply</td>

			</tr>

		</table>


		<% } %>


		<% if (actionType.equals("UpdateMemberNA")) { 
//only customer selected, no Member

String [] alternatingColors = {"#e5e5e5", "#ffffff"};
int j = 0;
//alternationg row color

Connection oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
Statement oStmt = oConn.createStatement();
PreparedStatement oPStmt = null;
ResultSet oRS = null;
ResultSet oRS1 = null;

String memMaj = "";
String memMaj_noF = ""; //used if customer minor OG, don't front fill member #
String memMin = "";
String memName = "";
String custMinNbr = "";
String custMinNbrF = "";
String custMinOG = "";
String zone = "";

String custNum = "";
String custName = "";
String custNbr = "";
String custList = "";
String numOG = ""; //count OG first before running query to avoid null pointer
int rowN=1;

String companyCode = "";
oRS = oStmt.executeQuery("select distinct(CompanyCode) ccode from ecommerce.dbo.NetSupplyLocationProperties Where CustomerMaj ="+dbUser.nationalAccountNbr+"");
while (oRS.next()) {
companyCode = oRS.getString("ccode");
}

//get list of custMaj based on company code queried above
oRS = oStmt.executeQuery("select distinct(CustomerMaj) custMaj from ecommerce.dbo.NetSupplyLocationProperties Where CompanyCode ="+companyCode+"");
while (oRS.next()) {
rowN = oRS.getRow();
custNbr = oRS.getString("custMaj");

	if (rowN==1) {
	custList = custNbr;
	} else {
	custList = custList.concat(", ").concat(custNbr);
	}
}

String catalogPrefix = "";

%>
		<div id="actionFieldMM">
			<!-- 1 to many update -->

			<table>
				<tr>
					<th>National Account:</th>
					<th>Zone:</th>
					<th>Member:</th>
					<th>Email Address:</th>
					<!--<th>Order Guide:</th> -->
					<th>Active/Inactive:</th>
				</tr>

				<%
		int count=0;
		for (int z = 0; z < dbUser.memberEmailList.size(); z++) {
         Vector memberUL = (Vector) dbUser.memberEmailList.elementAt(z); %>

				<tr bgcolor="<%=alternatingColors[j%2]%>">
					<td><%=memberUL.elementAt(5)%> - <%=dbUser.nationalAccountName%>
						<input type="hidden" name="natAcct<%=count%>"
						value="<%=memberUL.elementAt(4)%>" /></td>

					<td><%=memberUL.elementAt(11)%></td>

					<td><%=memberUL.elementAt(0)%> - <%=memberUL.elementAt(1)%> -
						<%=memberUL.elementAt(7)%> <input type="hidden"
						name="member<%=count%>" value="<%=memberUL.elementAt(8)%>" /> <input
						type="hidden" name="memberMin<%=count%>"
						value="<%=memberUL.elementAt(9)%>" /></td>


					<td><input name="memberEmail<%=count%>" type="text"
						value="<% if (memberUL.elementAt(2).toString().equals("")) {%>orders@networkdistribution.com<% } else { %><%=memberUL.elementAt(2) %><% } %>"
						size="65" maxlength="200" /> <br /></td>
					<!--<td> old order guide</td>-->

					<td>
						<% if (memberUL.elementAt(3).toString().equals("") || memberUL.elementAt(3).toString().length()==0) { //no order guide selected - disable active/inactive
%> <input type="radio" name="active<%=count%>" id="active<%=count%>"
						value="1" disabled="disabled" /> Active<br /> <input
						type="radio" name="active<%=count%>" id="activeI<%=count%>"
						value="0" checked disabled="disabled" /> InActive <% } else { %> <% if (memberUL.elementAt(6).equals("1")) { 
	//all active
	%> <input type="radio" name="active<%=count%>" value="1"
						checked="checked" /> Active<br /> <input type="radio"
						name="active<%=count%>" value="0" /> InActive <% } else if (memberUL.elementAt(6).equals("0")) { 
	//all inactive
	%> <input type="radio" name="active<%=count%>" value="1" /> Active <br />
						<input type="radio" name="active<%=count%>" value="0"
						checked="checked" /> InActive <% } else { 
	//mix of active and inactive
	%> <input type="radio" name="activeD<%=count%>" value="1"
						disabled="disabled" /> Active <br /> <input type="radio"
						name="activeD<%=count%>" value="0" disabled="disabled" />
						InActive <input type="hidden" name="active<%=count%>" value="" />
						<!--pass value to indicate not to update inactive/active flag -->
						<% } %> <% } //order guide selected
%>
					</td>
				</tr>
				<tr bgcolor="<%=alternatingColors[j%2]%>">
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<th><div align="right">Order Guide:</div></th>
					<td colspan="3"><input type="hidden"
						value="<%=memberUL.elementAt(3)%>" name="prevOG<%=count%>" /> <select
						name="orderGuide<%=count%>"
						onChange="changeActiveInactive(<%=count%>)">

							<% if (memberUL.elementAt(3).toString().equals("")  || memberUL.elementAt(3).toString().length()==0) { %>
							<option value="none" selected="selected" style="font-size: 8px;">---
								Select One ---</option>
							<% } else { %>
							<option value="<%=memberUL.elementAt(3) %>" selected="selected"
								style="font-size: 8px;"><%=memberUL.elementAt(3) %></option>
							<% } %>

							<%
		oPStmt = oConn.prepareCall("usp_EUI_GetFMTOrderGuideCount @custMaj ='"+custList+"', @mbrMaj = '"+memberUL.elementAt(0)+"', @zone="+memberUL.elementAt(11)+"");
		  while (oRS.next()) {
		  numOG = oRS.getString("total");
		  }
		  
		  System.out.println(custList + memberUL.elementAt(0) + numOG);
		  
		if (numOG.equals("0")) {} else {
			
		//oPStmt = oConn.prepareCall("usp_EUI_GetFMTOrderGuide @custMaj ='"+custList+"', @mbrMaj = '"+memberUL.elementAt(0)+"'");
		oPStmt = oConn.prepareCall("usp_EUI_GetFMTOrderGuideZone @custMaj ='"+custList+"', @mbrMaj = '"+memberUL.elementAt(0)+"', @zone="+memberUL.elementAt(11)+"");
		//System.out.println("usp_EUI_GetFMTOrderGuideZone @custMaj ='"+custList+"', @mbrMaj = '"+memberUL.elementAt(0)+"', @zone="+memberUL.elementAt(11)+"");
		
		oRS = oPStmt.executeQuery();
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
		 
		 	oRS1 = oStmt.executeQuery("Select CatalogPrefix from ecommerce.dbo.NetSupply_CustomerMaster Where CustomerNumber="+custNum+"");
			while (oRS1.next()) {
			catalogPrefix = oRS1.getString("CatalogPrefix");
			}
			
	
			if (custMinNbr.equals("")) {}
			else if (custMinNbr.equals("0")) { 
			custMinOG = ""; %>
							<option
								value="<%=catalogPrefix%><%=memMaj%><%=memMin%>Z<%=zone%>"
								style="font-size: 8px;"><%=memMaj%> -
								<%=memMin%> [Z<%=zone%>]
								<%=memName%> :
								<%=custNum%> -
								<%=custName%></option>
							<!-- old value for catlogprefix memberUL.elementAt(10) -->

							<% } else { 
			custMinOG = custMinNbrF+" -- ";
			%>
							<option
								value="<%=catalogPrefix%><%=memMaj_noF%><%=custNum%><%=custMinNbr%>Z<%=zone%>"
								style="font-size: 8px;"><%=custMinOG%><%=memMaj%> -
								<%=memMin%> [Z<%=zone%>]
								<%=memName%> :
								<%=custNum%> -
								<%=custName%></option>
							<% } 
			
			} //count on # of OG by cust/mem
			%>
							<%   

} //end of RS 
%>

					</select></td>
				</tr>

				<tr>
					<td colspan="5"></td>
				</tr>

				<% 
	j++;
	count++;
	}	

oRS1.close();	
oRS.close();
oPStmt.close();
oStmt.close();
oConn.close();
	%>


				<tr>
					<td colspan="5"><input type="hidden" name="totR"
						value="<%=count%>" /> <input type="button" name="Submit"
						id="Submit" value="Save" onclick="SaveUpdateMember()" /> <input
						type="button" name="Submit" id="Submit" value="Cancel"
						onclick="Cancel()" /> <input name="typeAction" type="hidden"
						id="typeAction" value="U" /></td>
				</tr>
			</table>

		</div>

		<% 
} 

if (actionType.equals("UpdateMemberMem")) { 
//only Member selected - no customer
String [] alternatingColors = {"#e5e5e5", "#ffffff"};
int j = 0;
//alternationg row color


Connection oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
Statement oStmt = oConn.createStatement();
PreparedStatement oPStmt = null;
ResultSet oRS = null;
ResultSet oRS1 = null;
ResultSet oRS2 = null;

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

String custNbr = "";
String custList = "";
int rowN=1;
String catalogPrefix = "";


String eMail = "";
String catalog = "";
String active = "";
String countRec =null;
String countActive=null;
String countInactive=null;
	      
int countR =0;
int countA =0;
int countI =0;
%>

		<div id="actionFieldMM">
			<!-- 1 to many update -->

			<table>
				<tr>
					<th>National Account:</th>

					<th>Zone:</th>

					<th>Member:</th>
					<th>Email Address:</th>
					<!--<th>Order Guide:</th> -->
					<th>Active/Inactive:</th>
				</tr>

				<%
		int count=0;
		for (int z = 0; z < dbUser.memberEmailList.size(); z++) {
         Vector memberUL = (Vector) dbUser.memberEmailList.elementAt(z); %>
				<tr bgcolor="<%=alternatingColors[j%2]%>">
					<td><%=memberUL.elementAt(1)%> - <%=memberUL.elementAt(2)%> <input
						type="hidden" name="natAcct<%=count%>"
						value="<%=memberUL.elementAt(0)%>" /></td>

					<td><%=memberUL.elementAt(4)%></td>

					<td><%=dbUser.memNbrF%> - <%=dbUser.memMinNbrF%> - <%=dbUser.memberName%>
						<input type="hidden" name="member<%=count%>"
						value="<%=dbUser.memberNbr%>" /> <input type="hidden"
						name="memberMin<%=count%>" value="<%=dbUser.memberMinNbr%>" /></td>

					<td>
						<% 
		oPStmt = oConn.prepareCall("usp_EUI_GetTotalMemberUpdate @custMaj="+memberUL.elementAt(0)+", @mbrMaj='"+dbUser.memberNbr+"', @mbrMin='"+dbUser.memberMinNbr+"', @platform='netSupply'");

//System.out.println("jsp usp_EUI_GetTotalMemberUpdate @custMaj="+memberUL.elementAt(0)+", @mbrMaj='"+dbUser.memberNbr+"', @mbrMin='"+dbUser.memberMinNbr+"', @platform='"+dbUser.eplatform+"'");

		oRS = oPStmt.executeQuery();
					         while (oRS.next())
					         { 
					       	 countRec = oRS.getString("total");
					         }
					         countR = Integer.parseInt(countRec);
		
		oPStmt = oConn.prepareCall("usp_EUI_GetTotalInactiveMemberUpdate @custMaj="+memberUL.elementAt(0)+", @mbrMaj='"+dbUser.memberNbr+"', @mbrMin='"+dbUser.memberMinNbr+"', @platform='netSupply'");
		
		//System.out.println("jsp usp_EUI_GetTotalInactiveMemberUpdate @custMaj="+memberUL.elementAt(0)+", @mbrMaj='"+dbUser.memberNbr+"', @mbrMin='"+dbUser.memberMinNbr+"', @platform='"+dbUser.eplatform+"'");
		
		oRS = oPStmt.executeQuery();
								 while (oRS.next())
								 { 
								 countInactive= oRS.getString("total");
								 }
								 countI = Integer.parseInt(countInactive);
								 
								 if (countI==countR) { //all are inactive
								 active="0";
								 } else if (countI==0) { //no inactive => all are active
								 active = "1";
								 } else {
								 active ="-1"; //mix of active and inactive
								 }
								 
							
							if (countR==0) { //no record in alp or nlp based on member maj/min from DW
					        	 
					          eMail= "orders@networkdistribution.com"; //email Address
						      catalog = "";
						      active = "0";
					        	 
					         } else { //record return
							
							oPStmt = oConn.prepareCall("usp_EUI_GetMemberUpdatesDtl @custMaj="+memberUL.elementAt(0)+", @mbrMaj='"+dbUser.memberNbr+"', @mbrMin='"+dbUser.memberMinNbr+"', @platform='netSupply', @zone="+memberUL.elementAt(4)+"");
							
						//System.out.println("jsp MemOnly usp_EUI_GetMemberUpdatesDtl @custMaj="+memberUL.elementAt(0)+", @mbrMaj='"+dbUser.memberNbr+"', @mbrMin='"+dbUser.memberMinNbr+"', @platform='"+dbUser.eplatform+"', @zone="+memberUL.elementAt(4)+"");
							
				    		oRS1 = oPStmt.executeQuery();
				            		
					         while (oRS1.next())
					         {  
				            eMail = oRS1.getString("mEmail"); //email Address
				            catalog =  oRS1.getString("CatalogName"); 
					        } //end of RS1a
					          
					         } //if more than 1 record
		 %> <input name="memberEmail<%=count%>" type="text"
						value="<% if (eMail.equals("")) {%>orders@networkdistribution.com<% } else { %><%=eMail%><% } %>"
						size="65" maxlength="200" />


					</td>
					<!--<td>old order guide  </td> -->
					<td>
						<% if (catalog.equals("")) { //no order guide selected
	%> <input type="radio" name="active<%=count%>" id="active<%=count%>"
						value="1" disabled="disabled" /> Active <br /> <input
						type="radio" name="active<%=count%>" id="activeI<%=count%>"
						value="0" checked disabled="disabled" /> InActive <% } else { %> <% if (active.equals("1")) { 
	//all active
	%> <input type="radio" name="active<%=count%>" value="1"
						checked="checked" /> Active <br /> <input type="radio"
						name="active<%=count%>" value="0" /> InActive <% } else if (active.equals("0")) { 
	//all inactive
	%> <input type="radio" name="active<%=count%>" value="1" /> Active <br />
						<input type="radio" name="active<%=count%>" value="0"
						checked="checked" /> InActive <% } else { 
	//mix of active and inactive
	%> <input type="radio" name="activeD<%=count%>" value="1"
						disabled="disabled" /> Active <br /> <input type="radio"
						name="activeD<%=count%>" value="0" disabled="disabled" />
						InActive <input type="hidden" name="active<%=count%>" value="" />
						<!-- pass -1 to indicate no update in active or inactive status -->
						<% } %> <% } //if order guide is selected
 %>
					</td>
				</tr>

				<tr bgcolor="<%=alternatingColors[j%2]%>">
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<th><div align="right">Order Guide:</div></th>
					<td colspan="3"><input type="hidden" value="<%=catalog%>"
						name="prevOG<%=count%>" /> <select name="orderGuide<%=count%>"
						onChange="changeActiveInactive(<%=count%>)">

							<% if (catalog.equals("")) {%>
							<option value="none" selected="selected">--- Select One
								---</option>
							<% } else { %>
							<option value="<%=catalog%>" selected="selected"><%=catalog%>
							</option>
							<% } %>

							<%
//get company code
oRS = oStmt.executeQuery("Select distinct(CompanyCode) ccode from ecommerce.dbo.NetSupplyLocationProperties Where CustomerMaj="+memberUL.elementAt(0)+"");
while (oRS.next()) {
dbUser.companyCode = oRS.getString("ccode");
}

//get customer list based on company code - push into getOG 
oRS = oStmt.executeQuery("select distinct(CustomerMaj) custMaj from ecommerce.dbo.NetSupplyLocationProperties Where CompanyCode ="+dbUser.companyCode+"");
while (oRS.next()) {
rowN = oRS.getRow();
custNbr = oRS.getString("custMaj");
	if (rowN==1) {
	custList = custNbr;
	} else {
	custList = custList.concat(", ").concat(custNbr);
	}
}

		
		//oPStmt = oConn.prepareCall("usp_EUI_GetFMTOrderGuide @custMaj ="+memberUL.elementAt(2)+", @mbrMaj = "+dbUser.memberNbr+"");
		oPStmt = oConn.prepareCall("usp_EUI_GetFMTOrderGuide @custMaj ='"+custList+"', @mbrMaj = '"+dbUser.memberNbr+"'");
		oRS2 = oPStmt.executeQuery();
		
		 while (oRS2.next()) {
		 memMaj = oRS2.getString("memNbr_f");
		 memMaj_noF = oRS2.getString("MbrNbr");
		 memMin = oRS2.getString("memMin_f");
		 memName = oRS2.getString("NameMember");
		 custMinNbr = oRS2.getString("CustMinNbr");
		 custMinNbrF = oRS2.getString("custMinNbr_f");
		 custName = oRS2.getString("NameAcct");
		 custNum = oRS2.getString("CustNbr");
		 zone = oRS2.getString("zone");
		 
		    oRS1 = oStmt.executeQuery("Select CatalogPrefix from ecommerce.dbo.NetSupply_CustomerMaster Where CustomerNumber="+custNum+"");
			while (oRS1.next()) {
			catalogPrefix = oRS1.getString("CatalogPrefix");
			}
		 
		 	if (custMinNbr=="" || custMinNbr==null) {}
			else if (custMinNbr.equals("-1") || custMinNbr.equals("0")) {
			custMinOG = ""; %>
							<option
								value="<%=catalogPrefix%><%=memMaj%><%=memMin%>Z<%=zone%>"><%=memMaj%>
								-
								<%=memMin%> [Z<%=zone%>]
								<%=memName%> :
								<%=custNum%> -
								<%=custName%></option>
							<!-- old value for catalog prefix: memberUL.elementAt(5) -->
							<% } else { 
			custMinOG = custMinNbrF+" -- ";
			%>
							<option
								value="<%=catalogPrefix%><%=memMaj_noF%><%=custNum%><%=custMinNbr%>Z<%=zone%>"><%=custMinOG%>
								<%=custNum%> -
								<%=custName%> :
								<%=memMaj%> -
								<%=memMin%> [Z<%=zone%>]
								<%=memName%></option>
							<% } %>
							<%  

  }			
%>
					</select></td>
				</tr>

				<tr>
					<td colspan="5"></td>
					<!--<tr> -->
				</tr>

				<% 
	active = "";
	catalog = "";
	eMail = "";
	//re-initalize values
	countRec = "";
	countActive = "";
	countInactive = "";
	countR = 0;
	countA = 0;
	countI = 0;
	
	j++;
	count++;
	}
	
oRS1.close();	
oRS.close();
oRS2.close();
oPStmt.close();
oStmt.close();
oConn.close();
	%>


				<tr>
					<td colspan="5"><input type="hidden" name="totR"
						value="<%=count%>" /> <input type="button" name="Submit"
						id="Submit" value="Save" onclick="SaveUpdateMember()" /> <input
						type="button" name="Submit" id="Submit" value="Cancel"
						onclick="Cancel()" /> <input name="typeAction" type="hidden"
						id="typeAction" value="U" /></td>
				</tr>
			</table>

		</div>

		<% 

}

if (actionType.equals("UpdateMemberDtl")) { 
//member and customer selected
String [] alternatingColors = {"#e5e5e5", "#ffffff"};
int j = 0;
//alternationg row color

String custMinOG = "";
%>

		<div id="actionFieldMM">
			<!-- 1 to many update -->

			<table>
				<tr>
					<th>National Account:</th>
					<th>Zone:</th>
					<th>Member:</th>
					<th>Email Address:</th>
					<!--<th>Order Guide:</th> -->
					<th>Active/Inactive:</th>
				</tr>

				<%
		int count=0;
		for (int z = 0; z < dbUser.memberEmailList.size(); z++) {
         Vector memberUL = (Vector) dbUser.memberEmailList.elementAt(z); %>

				<tr bgcolor="<%=alternatingColors[j%2]%>">

					<td><%=dbUser.naNbrF%> - <%=dbUser.nationalAccountName%> <input
						type="hidden" name="natAcct<%=count%>"
						value="<%=dbUser.nationalAccountNbr%>" />
					<td><%=memberUL.elementAt(4)%></td>

					<td><%=dbUser.memNbrF%> - <%=dbUser.memMinNbrF%> - <%=dbUser.memberName%>
						<input type="hidden" name="member<%=count%>"
						value="<%=dbUser.memberNbr%>" /> <input type="hidden"
						name="memberMin<%=count%>" value="<%=dbUser.memberMinNbr%>" /></td>
					<td><input name="memberEmail<%=count%>" type="text"
						value="<% if (memberUL.elementAt(0).toString().equals("")) {%>orders@networkdistribution.com<% } else { %><%=memberUL.elementAt(0) %><% } %>"
						size="65" maxlength="200" /> <br /></td>
					<!--<td> old order guuide </td> -->
					<td>
						<% if (memberUL.elementAt(1).toString().equals("")) { 
%> <input type="radio" name="active<%=count%>" id="active<%=count%>"
						value="1" disabled="disabled" /> Active <br /> <input
						type="radio" name="active<%=count%>" id="activeI<%=count%>"
						value="0" checked disabled="disabled" /> InActive <% } else { %> <% if (memberUL.elementAt(2).toString().equals("1")) { 
	//all active
	%> <input type="radio" name="active<%=count%>" value="1"
						checked="checked" /> Active <br /> <input type="radio"
						name="active<%=count%>" value="0" /> InActive <% } else if (memberUL.elementAt(2).toString().equals("0")) { 
	//all inactive
	%> <input type="radio" name="active<%=count%>" value="1" /> Active <br />
						<input type="radio" name="active<%=count%>" value="0"
						checked="checked" /> InActive <% } else { 
	//mix of active and inactive
	%> <input type="radio" name="activeD<%=count%>" value="1"
						disabled="disabled" /> Active <br /> <input type="radio"
						name="activeD<%=count%>" value="0" disabled="disabled" />
						InActive <input type="hidden" name="active<%=count%>" value="" />
						<!-- pass -1 to indicate no update in active or inactive status -->
						<% } %> <% } //if order guide is selected
%>
					</td>
				</tr>

				<tr bgcolor="<%=alternatingColors[j%2]%>">
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<th><div align="right">Order Guide:</div></th>
					<td colspan="3"><input type="hidden"
						value="<%=memberUL.elementAt(3)%>" name="prevOG<%=count%>" /> <select
						name="orderGuide<%=count%>"
						onChange="changeActiveInactive(<%=count%>)">

							<% if (memberUL.elementAt(1).toString().equals("")) {%>
							<option value="none" selected="selected">--- Select One
								---</option>
							<% } else { %>
							<option value="<%=memberUL.elementAt(1) %>" selected="selected"><%=memberUL.elementAt(1) %>
							</option>
							<% } %>

							<%
String catalogPrefix = "";
Connection oConn = ConnectionFactory.getInstance().getConnection(Constants.ECOMMERCE_DATASOURCE);
Statement oStmt = oConn.createStatement();
ResultSet oRS = null;

		for (int y = 0; y < dbUser.ogList.size(); y++) {
         Vector ogL = (Vector) dbUser.ogList.elementAt(y); 		 
		 
		 //within OG vector, query for correct catalog prefix based on cust Nbr
		oRS = oStmt.executeQuery("Select CatalogPrefix from ecommerce.dbo.NetSupply_CustomerMaster Where CustomerNumber="+ogL.elementAt(7)+"");
			while (oRS.next()) {
			catalogPrefix = oRS.getString("CatalogPrefix");
			}
		 
		if (ogL.elementAt(6).toString().equals("")) {}
		else if (ogL.elementAt(6).toString().equals("0")) { //old way equals -1 for customerMin
		%>
							<option
								value="<%=catalogPrefix%><%=ogL.elementAt(1)%><%=ogL.elementAt(3)%>Z<%=ogL.elementAt(9)%>"><%=ogL.elementAt(1)%>
								-
								<%=ogL.elementAt(3)%> [Z<%=ogL.elementAt(9)%>]
								<%=ogL.elementAt(4)%> :
								<%=ogL.elementAt(7)%> -
								<%=ogL.elementAt(8)%></option>

							<!-- old catalogPrefix value - dbUser.ogPrefix -->

							<% } else { //customer minor location OG
		 custMinOG = ogL.elementAt(5)+" -- ";
		 %>
							<option
								value="<%=catalogPrefix%><%=ogL.elementAt(0)%><%=ogL.elementAt(7)%><%=ogL.elementAt(6)%>Z<%=ogL.elementAt(9)%>"><%=custMinOG%>
								<%=ogL.elementAt(7)%> - [Z<%=ogL.elementAt(9)%>]
								<%=ogL.elementAt(8)%> :
								<%=ogL.elementAt(1)%> -
								<%=ogL.elementAt(3)%>
								<%=ogL.elementAt(4)%></option>
							<%   
		} //end of if cust min location 

	if (catalogPrefix.equals("")) { //no result from vector		
			oRS.close();
			oStmt.close();
	}
	
 }	//end for loop		
 
 	if (!catalogPrefix.equals("")) { //no result from vector		
			oRS.close();
			oStmt.close();
	}
 //oRS.close();
 //oStmt.close();
 
 oConn.close();
%>
					</select></td>
				</tr>
				<tr>
					<td colspan="5"></td>
				<tr>
					<% 
	j++;
	count++;
	}
	
	 
	%>
				
				<tr>
					<td colspan="5"><input type="hidden" name="totR"
						value="<%=count%>" /> <input type="button" name="Submit"
						id="Submit" value="Save" onclick="SaveUpdateMember()" /> <input
						type="button" name="Submit" id="Submit" value="Cancel"
						onclick="Cancel()" /> <input name="typeAction" type="hidden"
						id="typeAction" value="U" /></td>
				</tr>
			</table>

		</div>

		<% } 

if (actionType.equals("SaveUpdateMember")) { 

String confirmMsg = "";

	//if (dbUser.successF.equals("Y")) {

confirmMsg = "The member information was successfully updated.  <br>If no order guide was selected, the location(s) will remain inactive.";
	
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