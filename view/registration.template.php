<html>
<head>
	<title>Registration</title>
      <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/css/materialize.min.css">

      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body>
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
    <h1>Regisztráció</h1>
	<h2>
	<?php
		if(isset($_GET["error"])){
			echo $_GET["error"];
		}
	?>
	</h2>
	<div class="row">
		 <form class="col s12" method="POST">
		 	<div class="row">
		 		<div class="input-field col s6">
					<input id="keresztnev" type="text" class="validate" name="keresztnev">
					<label for="keresztnev">Keresztnév</label>
		    	</div>
		 	</div>
		 	<div class="row">
		 		<div class="input-field col s6">
					<input id="vezeteknev" type="text" class="validate" name="vezeteknev">
					<label for="vezeteknev">Vezetéknév</label>
				</div>
		 	</div>
		 	<div class="row">
		 		<div class="input-field col s6">
		 			<label for="szul_dat">Születési dátum</label>
		 			<input type="date" id="szul_dat" class="datepicker" name="szul_dat">
				</div>
		 	</div>
		 	<div class="row">
		 		<p>
			    	<input name="nem" type="radio" id="ferfi" value="f"/>
			    	<label for="ferfi">Férfi</label>
				</p>
				<p>
					<input name="nem" type="radio" id="no" value="n" />
					<label for="no">Nő</label>
				</p>
		 	</div>
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
			<div class="row">
				<div class="input-field col s6">
					<input id="jelszo2" type="password" class="validate" name="jelszo2">
					<label for="jelszo2">Jelszó újra</label>
				</div>
			</div>
		 	<div class="row">
				<div class="input-field col s6">
						<input id="munkahely" type="text" class="validate" name="munkahely">
						<label for="munkahely">Munkahely</label>
				</div>
			</div>
		 	<div class="row">
				<div class="input-field col s6">
						<input id="iskola" type="text" class="validate" name="iskola">
						<label for="iskola">Iskola</label>
				</div>
			</div>
			<button class="btn waves-effect waves-light" type="submit" name="register">
				<i class="material-icons right">Regisztráció</i>
			</button>
        
		 </form>
	</div>
</body>
<script type="text/javascript">
	$('.datepicker').pickadate();
</script>
</html>