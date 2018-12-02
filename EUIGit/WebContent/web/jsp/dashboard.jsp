<html>
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
</head>
<%@ include file="banner.jsp"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>

<%
String actionType = (String)request.getParameter("actionType");
String [] alternatingColors ={"#e5e5e5", "#ffffff"}; 

%>
<body id="wrapper">
<form action="ControllerServlet" method="post" name="dashB">
	<input type=hidden name='actionType' value=""> 
	<input type=hidden name='page' value="">
	<div id="actionFieldMM">
<br>


		<!-- <span class="subTitle">Dashboard</span>--> <br /> <br />
		<table width="100%">
		<span class="subTitle">Missing Order Guides</span>
			<tr>
				<td valign="top"><span class="requiredField">Action</span></td>
				<td valign="top"><span class="requiredField">Update Date</span></td>
				<td valign="top"><span class="requiredField">Customer</span></td>
				<td valign="top"><span class="requiredField">Member</span></td>
				<td valign="top"><span class="requiredField">Previous <br />
						Member Assignment
				</span></td>
			</tr>
			<% int i =0;
			   int j = 0;
		for (int k = 0; k < dbUser.reportList.size(); k++) {
         Vector rptL = (Vector) dbUser.reportList.elementAt(k); 
	%>
			<tr bgcolor="<%=alternatingColors[j%2]%>">
				<td><%=rptL.elementAt(0)%></td>
				<td><%=rptL.elementAt(7)%></td>
				<td>
					<% if (rptL.elementAt(0).toString().equals("Member Re-Assignment") || rptL.elementAt(0).toString().equals("No Catalog Name") ||
	rptL.elementAt(0).toString().equals("Re-opened Location")) {
		if (!rptL.elementAt(0).toString().equals("Closed Location")) {
		 %> <a
					href="ControllerServlet?page=updateLocation.jsp&actionType=UpdateLocationDtl_noMem&natAcct=<%=rptL.elementAt(1)%>&eplatform=netSupply&natAcctMin=<%=rptL.elementAt(8)%>"
					title="Update Order Guide Info"><%=rptL.elementAt(1)%> - <%=rptL.elementAt(2)%></a>

					<% } else { %> <%=rptL.elementAt(1)%> - <%=rptL.elementAt(2)%> <% } %>
				</td>
				<td><%=rptL.elementAt(3)%> - <%=rptL.elementAt(4)%></td>
				<td><%=rptL.elementAt(5)%> - <%=rptL.elementAt(6)%></td>
			</tr>
			<% i++;
			   j++;
  			} 
					
		}
		
  if (i==0) {
	  //System.out.println("Here is a system out");
  %>
			<tr>
				<td colspan="8"><span class="errorField"> There are no
						new locations, member re-assignments, closed and/or reopened
						locations, or super buyer location changes within the last 7 days.</span></td>
			</tr>
			<% } %>
		</table>
		<table width="100%">
			<!-- Changes added 03/06/2018 S.R. -->
			<span class="subTitle">Unprocessed Orders</span>
			<tr>
				<td valign="top"><span class="requiredField">ShipTo</span></td>
				<td valign="top"><span class="requiredField">Order Date</span></td>
				<td valign="top"><span class="requiredField">Member</span></td>
				<td valign="top"><span class="requiredField">Order #</span></td>
				<td valign="top"><span class="requiredField">Order Total</span></td>
			</tr>
		
			<tr bgcolor="<%=alternatingColors[j%2]%>">
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
				<%j++; %>
		</table>
		 <br>
		 <br>
		<table width="100%">
			<span class="subTitle">Unable to Punchout (last 7 days)</span>
			<tr>
				<td valign="top"><span class="requiredField">UserID</span></td>
				<td valign="top"><span class="requiredField">First & Last Name</span></td>
				<td valign="top"><span class="requiredField">Email Address</span></td>
				<td valign="top"><span class="requiredField">SoldTo</span></td>
				<td valign="top"><span class="requiredField">ShipTo</span></td>
			</tr>
			<tr bgcolor="<%=alternatingColors[j%2]%>">
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
				<%j++; %>
		 </table>
		 <br>
		 <br>
		 <table width="100%">
			<span class="subTitle">Jobs</span>
			<tr>
				<td valign="top"><span class="requiredField">Job Name</span></td>
				<td valign="top"><span class="requiredField">Start Time</span></td>
				<td valign="top"><span class="requiredField">End Time</span></td>
				<td valign="top"><span class="requiredField">Status</span></td>
			</tr>	
			<tr bgcolor="<%=alternatingColors[j%2]%>">
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
				<%j++; %>
			<!--End of changes 3/6/18 S.R.-->
		</table>
		 <br><br>
		<table width="100%">
			<span class="subTitle">New Locations</span>
			<tr>
				<td valign="top"><span class="requiredField">Active Flag</span></td>
				<td valign="top"><span class="requiredField">Order Guide ID</span></td>
				<td valign="top"><span class="requiredField">LSOG Account</span></td>
			</tr>
			<tr bgcolor="<%=alternatingColors[j%2]%>">
				<td></td>
				<td></td>
				<td></td>
			</tr>
				<%j++; %>
		</table>
	</div>

</form>


<%@ include file="navMenu.jsp"%>


</body>
</html>