<%@ include file="banner1.jsp"%>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>
<html>
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
</head>
<body id="wrapper">
<%
String actionType = (String)request.getParameter("actionType");
String msg = (String)request.getParameter("msg");
msg = (String) request.getSession().getAttribute("msg");
System.out.println(msg);
%>
<script language="Javascript">
	
   function Login(){
   		if (document.login.userName.value=="" || document.login.passWord.value=="") {
			alert("Enter your username and password to login");
			document.login.userName.focus();
		} else {
			alert("HEY")
			document.login.actionType.value ="Login";
			alert("HEY")
			document.login.page.value="dashboard.jsp";
			alert("HEY")
			document.login.submit();
		}
	}
   
</script>         

<form action="ControllerServlet" method="post" name="login">
	<input type=hidden name='actionType' value=""> <input
		type=hidden name='page' value="">
	<div id="inputFieldM">
		<span class="subTitle"> Login to the E-Commerce User Interface</span><br />
		<br /> <span> <% if (msg.equals("sessionExp")) { %>Your
			session has expired. Please login again.<% } else if (msg.equals("noLogin")) { %>
			There is a problem with your access to the EUI tool. Please try to
			login again. <% } else { } %>
		</span><br />

		<table width="100%" border="0" cellpadding="0">
			<tr>
				<td>Username: <input type="text" name="userName" id="userName" /></td>
			</tr>
			<tr>
				<td>Password:&nbsp; <input type="password" name="passWord"
					id="passWord" /></td>
			</tr>
			<tr>
				<td><input name="login" type="button" value="Login"
					onclick="javascript:Login()" /></td>
			</tr>
		</table>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
	</div>
</form>
</body>
</html>
