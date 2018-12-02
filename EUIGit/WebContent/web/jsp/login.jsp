<html>
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
</head>
<%@ page import="java.lang.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="com.nsc.eui.*, com.nsc.utils.*, com.nsc.dataaccess.*"%>

<%
String actionType = (String)request.getParameter("actionType");
//System.out.println("Action Type= "+actionType);
String msg = (String)request.getParameter("msg");
msg = (String) request.getSession().getAttribute("msg");
if(msg == null){
	msg = "";
}
System.out.println(msg);
%>

<link href="./web/css/nsc_eui.css" rel="stylesheet" type="text/css"
	media="screen" />
<link href="./web/css/menu.css" rel="stylesheet" type="text/css" />
<body id="wrapper">
<br>
	<br>
	<br>
	<a name="topOfForm" id="topOfForm"></a>
	<div id="header">
		<!--  <h2>DISTRIBUTION BY DESIGN</h2>-->
		<h2>NETWORK DISTRIBUTION</h2>
		<!--<img src="./web/images/Network_LogoDBD.jpg"
			alt="Distribution By Design" />-->
			<img src="./web/images/logo.png" alt="Distribution By Design" />
		<div id="background">
		<br>
			<h1>
				Ecommerce User Interface (EUI)
			</h1>
		</div>
		<!-- <img src="./web/images/ChainImage.png" alt="Forging America's Supply Chains"/> -->
	</div>
	<div id="listmenu">
	<ul>
	<li></li>
	</ul>
	
	</div>
<script language="Javascript">
	
   function Login(){

		if (document.login.userName.value=="" || document.login.passWord.value=="") {
			alert("Enter your username and password to login");
			document.login.userName.focus();
		} else {
			document.login.actionType.value ="Login";
			document.login.page.value="dashboard.jsp";
			document.login.submit();
		}
	}
   
</script>



<form action="ControllerServlet" method="post" name="login">    
	<input type=hidden name='actionType' value=""> <input
		type=hidden name='page' value="">
	<div id="inputFieldM">
		<span class="subTitle"><br />
		<br /> <span class="errorField"> <% if (msg.equals("sessionExp")) { %>Your
			session has expired. Please login again.<% } else if (msg.equals("noLogin")) { %>
			There is a problem with your access to the EUI tool. Please try to
			login again. <% } else if(msg.equals("Logout")) { %>You have been successfully logged out<% } else { } %>
		</span></span><br /><br />
		<br />
		<br>
		<br>
	<div align="center" id="InnerBorder" style="border: 5px solid #4f758b; border-radius: 25px;">
	<br><br><br><br><br><br><br><br>
		<table width="100%" valign="top" border="0" cellpadding="0">
		    <tr>
		         <td class="subTitle">User Login</td> 
		    </tr>
			<tr>
				<td>Username: <input type="text" name="userName" id="userName" /></td>
			</tr>
			<tr>
				<td>Password:&nbsp; <input type="password" name="passWord"
					id="passWord" /></td>
			</tr>
			<tr>
				<td><input name="login" type="submit" value="Login" style="width:100px;height:25px;"
					onclick="Login()" /></td>          
			</tr>
		</table>
		</div>
		<br>
		<br>
		<br>
		<br>
		<br>
	</div>
</form>
</body>
</html>
