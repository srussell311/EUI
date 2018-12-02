<%@ include file="banner.jsp"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>

<%
String actionType = (String)request.getParameter("actionType");
%>
<script language="Javascript">
	
   function NewUser() {
		if (document.addU.userN.value=="") {
			alert("Enter the name for the new user. i.e. jhallida");
			document.addU.userN.focus();
		} else if (document.addU.userP.value=="") {
			alert("Enter a password for the user to user.");
			document.addU.userP.focus();
		} else {
			document.addU.page.value = "addUser.jsp";
			document.addU.actionType.value = "NewUser";
			document.addU.submit();
		}
	}
   
</script>


<form action="ControllerServlet" method="post" name="addU">
	<input type=hidden name='actionType' value=""> <input
		type=hidden name='page' value="">
	<div id="inputField">
		<span class="subTitle">Add User</span><br /> <br />

		<% if (actionType.equals("AddUser")) { %>

		<table border="0" cellpadding="0">
			<tr>
				<td>User Name:</td>
				<td><input name="userN" type="text" id="userN" size="20"
					maxlength="20" /></td>
			</tr>
			<tr>
				<td>User Password:</td>
				<td><input name="userP" type="password" id="userP" size="20"
					maxlength="20" /></td>
			</tr>
			<tr>
				<td>Role:</td>
				<td><select name="role" id="role">
						<option value="EC" selected="selected">EC</option>
						<option value="CSR">CSR</option>
						<option value="A">Admin</option>
						<option value="O">Other</option>
						<option value="AI">AI</option>
						<option value="AD">AD</option>
				</select></td>
			</tr>
			<tr>
				<td>Active:</td>
				<td><select name="active" id="active">
						<option value="Y" selected="selected">Yes</option>
						<option value="N">No</option>
				</select></td>
			</tr>
			<tr>
				<td colspan="2"><input name="save" type="button" id="save"
					value="Add User" onClick="javascript:NewUser()" /></td>
			</tr>
		</table>

		<% } else if (actionType.equals("NewUser")) { 
   		if (dbUser.userUpdate.equals("Y")) {
   		%>
		<span class="requiredField">The new user, <%=dbUser.uName%>,
			was successfully added.
		</span>
		<% } else { %>
		<span class="requiredField">The user, <%=dbUser.uName%>,
			already exists and was not added.
		</span>
		<% } %>

		<% } else {} %>

	</div>
</form>



<%@ include file="navMenu.jsp"%>
