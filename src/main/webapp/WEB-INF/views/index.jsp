<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
	<title> constory - 너를 위한 공모전</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

	<script src="/js/jquery-3.6.1.min.js" type="text/javascript"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		(function() {
			var w = window;
			if (w.ChannelIO) {
				return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
			}
			var ch = function() {
				ch.c(arguments);
			};
			ch.q = [];
			ch.c = function(args) {
				ch.q.push(args);
			};
			w.ChannelIO = ch;
			function l() {
				if (w.ChannelIOInitialized) {
					return;
				}
				w.ChannelIOInitialized = true;
				var s = document.createElement('script');
				s.type = 'text/javascript';
				s.async = true;
				s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
				s.charset = 'UTF-8';
				var x = document.getElementsByTagName('script')[0];
				x.parentNode.insertBefore(s, x);
			}
			if (document.readyState === 'complete') {
				l();
			} else if (window.attachEvent) {
				window.attachEvent('onload', l);
			} else {
				window.addEventListener('DOMContentLoaded', l, false);
				window.addEventListener('load', l, false);
			}
		})();
		ChannelIO('boot', {
			"pluginKey": "235cd768-4afe-4ebc-bcd1-e7448b26e366"
		});
	</script>
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col-md-4">
			<a href="/main/main"><img src="/img/asd.gif" style="float: left; height: 70%"></a>
		</div>
		<div class="col-md-4">
			<a href="/main/main"style="text-decoration: none"> <h1 style="text-align: center">"constory" <span class="badge bg-secondary">"너를 위한 공모전"</span></h1></a>
		</div>
		<div class="col-md-4">
		</div>
	</div>


	<div class="col-md-4">
	</div>
</div>

 <div class="container">
	 <div class="row">

	 </div>
	 <div class="col-md-4">
	 </div>
	 <button class="btn-primary btn" style="width: 100%;height: 100px; align-content: center" type="button" onclick="location.href='/main/main'">시작하기</button>

 </div>
</body>
</html>
