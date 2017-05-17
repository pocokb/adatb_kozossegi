<?php
    function register($user_info){
        require 'sqlconnect.php';

        $query = "INSERT INTO Felhasznalo (email, jelszo, vezeteknev, keresztnev, szul_datom, nem, munkahely, iskola) 
        VALUES (:email, HEXTORAW(:jelszo), :vezeteknev, :keresztnev,TO_DATE(:szul_dat, 'YYYY-MM-DD'), :nem, ':munkahely', ':iskola')";

        $stmt = oci_parse($conn, $query);
        oci_bind_by_name($stmt, ':vezeteknev',$user_info['vezeteknev']);
        oci_bind_by_name($stmt, ':keresztnev', $user_info['keresztnev']);
        echo $user_info['szul_dat'];
        oci_bind_by_name($stmt, ':szul_dat', $user_info['szul_dat']);
        oci_bind_by_name($stmt, ':nem', $user_info['nem']);
        oci_bind_by_name($stmt, ':email', $user_info['email']);
        oci_bind_by_name($stmt, ':jelszo', $user_info['jelszo']);
        oci_bind_by_name($stmt, ':munkahely', $user_info['munkahely']);
        oci_bind_by_name($stmt, ':iskola', $user_info['iskola']);

        oci_execute($stmt) or die();

        oci_free_statement($stmt);
        oci_close($conn);

        return $user_info;
    }

    function authenticate($email, $jelszo) {
        require 'sqlconnect.php';
        $query = "SELECT * FROM Felhasznalo WHERE email = :email AND jelszo = UPPER(:jelszo)";
        $stmt = oci_parse($conn, $query);
        oci_bind_by_name($stmt, ':email', $email);
        oci_bind_by_name($stmt, ':jelszo', $jelszo);

        oci_execute($stmt) or die();
        $user = oci_fetch_array($stmt, OCI_ASSOC);

        oci_free_statement($stmt);
        oci_close($conn);
        return $user;
    }

    function getUser($email) {
        require 'sqlconnect.php';
        $query = "SELECT EMAIL, VEZETEKNEV, KERESZTNEV, SZUL_DATOM, NEM, MUNKAHELY, ISKOLA, LETREHOZVA  FROM Felhasznalo WHERE email = :email";
        $stmt = oci_parse($conn, $query);
        oci_bind_by_name($stmt, ':email', $email);

        oci_execute($stmt) or die();
        $user = oci_fetch_array($stmt, OCI_ASSOC);

        oci_free_statement($stmt);
        oci_close($conn);
        return $user;
    }
?>