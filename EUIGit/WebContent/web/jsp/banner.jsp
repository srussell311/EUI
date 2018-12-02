<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">     

<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> -->



<head>
<title>Network Services Company Ecommerce User Interface (EUI)</title>
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Content-Language" content="en-us" />

<link href="./web/css/nsc_eui.css" rel="stylesheet" type="text/css" media="screen" />
<link href="./web/css/menu.css" rel="stylesheet" type="text/css" />




</head>
<%@ page import="com.nsc.eui.*"%>
<% EUIUser dbUser = (EUIUser) session.getAttribute("EUIUser");
	System.out.println("dbUser=" +dbUser);
	%>

<body>
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
	