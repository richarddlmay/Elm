<meta name="generator" content="Bluefish 1.0.7">
<meta name="author" content="Cornelius Kölbel">
<meta name="date" content="2010-08-31T12:40:08+0200">
<meta name="copyright" content="LSE Leading Security Experts GmbH">
<meta name="ROBOTS" content="NOINDEX, NOFOLLOW">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8">
<meta http-equiv="content-style-type" content="text/css">
<meta http-equiv="expires" content="0">


<link type="text/css" rel="stylesheet" href="/selfservice/style.css" />
<link type="text/css" rel="stylesheet" href="/selfservice/custom-style.css" />

<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>

<!-- jQuery UI -->
<link type="text/css" href="/css/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<script type="text/javascript" src="/js/jquery-ui.min.js"></script>

<!-- form validation -->
<script type="text/javascript" src="/js/jquery.validate.min.js"></script>

<!-- Our own functions -->
<script type="text/javascript" src="/js/auth.js"></script>


</head>
<body>

<div id="header">
	<div id="logo"></div>
	<div class="float_right">
	Open Source Edition<br>
	<span class=portalname>${_("Authentication")}</span>
	</div>
</div>

<div class="javascript_error" id="javascript_error">
	${_("You need to enable Javascript to use the authentication forms.")}
</div>

${self.body()}


<div id="footer">
${c.licenseinfo}
</div>
</body>
</html>
