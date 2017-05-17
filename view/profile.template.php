<html>
<head>
	<title>Registration</title>
      <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/css/materialize.min.css">

      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body>
    <div class="center-align">
        <div class="col s12 m6 center-align">
            <div class="card blue-grey darken-1">
                <div class="card-content white-text">
                    <span class="card-title">
                    <?php
                        echo $user['VEZETEKNEV']." ".$user['KERESZTNEV'];
                    ?>
                    </span>
                     <div class="collection">
                        <a href="#!" class="collection-item"><?="Email: ".$user["EMAIL"]?></a>
                        <a href="#!" class="collection-item"><?="Született: ".$user["SZUL_DATOM"]?></a>
                        <a href="#!" class="collection-item">
                        <?php
                            $nem = getUserGender($user);
                            echo "Neme: $nem";
                        ?>
                        </a>
                        <a href="#!" class="collection-item"><?="Regisztrált ekkor: ".$user["LETREHOZVA"]?></a>
                                                
                    </div>
                </div>
                <div class="card-action">
                    <a href="#">Message</a>
                    <a href="#">Post to timeline</a>
                </div>
            </div>
        </div>
    </div>
</body>
<html>