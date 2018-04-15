<?php
$HOST = '127.0.0.1';
$USER = 'user280';
$PASS = 'p4ssw0rd';
$DB = 'dating_service';
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

//assume I have access to the logged in user's ssn (will likely need to store in browser)
$user_id = 124;

$pdo = new PDO("mysql:host=$HOST;port=3306;dbname=$DB", $USER, $PASS);

$show_error=isset($_COOKIE['ShowError']);
$show_success=isset($_COOKIE['ShowSuccess']);
setcookie("ShowError", "", time()-3600);
setcookie("ShowSuccess", "", time()-3600);
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Find Love Now!</title>
    <link rel="stylesheet" href="resources/style.css" />
  </head>
  <body>
    <h1 class="title">
      User View
    </h1>
   <section>
<?php
		$q = "SELECT firstname, lastname FROM Persons";
		$result = $pdo->query($q);

		while ($row = $result->fetch()) {
		    printf('<p>%s %s</p>', htmlspecialchars($row[0]), htmlspecialchars($row[1]));
		}
?>
</section>

    <section id="TheLine">
	    <h2>The line:</h2>
	    <ol>
<?php
			$q = "SELECT sub_interest FROM sub_Interests
            WHERE ssn = $user_id";
			$result = $pdo->query($q);

      print_r($result->fetchAll());

			while ($row = $result->fetch()) {
			    printf('<li>%s</li>', htmlspecialchars($row['sub_interest']));
			}
?>
	   	</ol>
   </section>
  </body>
</html>