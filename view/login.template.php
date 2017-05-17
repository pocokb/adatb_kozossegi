<html>
<head>
	<title>Login</title>
      <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/css/materialize.min.css">

      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body>
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
    <h1>Bejelentkezés</h1>
	<div class="row">
		 <form class="col s12" method="POST">
		 	<div class="row">
		 		<div class="input-field col s6">
					<input id="email" type="email" class="validate" name="email">
					<label for="email" data-error="wrong" data-success="right">Email</label>
				</div>
		 	</div>
		 	<div class="row">
				<div class="input-field col s6">
					<input id="jelszo" type="password" class="validate" name="jelszo">
					<label for="jelszo">Jelszó</label>
				</div>
			</div>
			<button class="btn waves-effect waves-light" type="submit" name="login">
				<i class="material-icons right">Bejelentkezés</i>
			</button>
        
		 </form>
	</div>
</body>
</html>