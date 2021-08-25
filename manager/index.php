<?php session_start();
include('function.php'); ?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Client Area - MyCompany</title>

    <!-- Styling -->
<link href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600|Raleway:400,700" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.2/css/bootstrap.min.css" rel="stylesheet">



<style>
    
    html,body { 
	height: 100%; 
}

.global-container{
	height:100%;
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: #f5f5f5;
}

form{
	padding-top: 10px;
	font-size: 14px;
	margin-top: 30px;
}

.card-title{ font-weight:300; }

.btn{
	font-size: 14px;
	margin-top:20px;
}


.login-form{ 
	width:330px;
	margin:20px;
}

.sign-up{
	text-align:center;
	padding:20px 0 0;
}

.alert{
	margin-bottom:-30px;
	font-size: 13px;
	margin-top:20px;
}
    
</style>
</head>
<body data-phone-cc-input="1">
    
    
    
  
    
    
    <div class="global-container">
	<div class="card login-form">
	<div class="card-body">
		<h3 class="card-title text-center">Admin Login</h3>
		<div class="card-text">
		    
		    
  <?php
  
  
  if($_SESSION["admin"]){
      
       header("Location: admin.php");  exit; 
  }
  
    
    if(isset($_POST['sub'])){
        
        $email=$_POST['email'];
        $pass=$_POST['pass'];
        
        
        
        
        
        $selectquesry="SELECT * FROM admin WHERE email='$email' && password='$pass' LIMIT 1 ";
    	$result= mysqli_query($GLOBALS['con'], $selectquesry);
        $row = mysqli_fetch_row($result);
  
    	
      if($row){
          
        $_SESSION["admin"] = $email;
         header("Location: admin.php");  exit;
      }else{
          
            echo "<p style='color:red;'> Wrong Credentials Try Again </p> ";

      }
      
    
        
    }
    
    
    
    ?>		    
		    
		    
			<!--
			<div class="alert alert-danger alert-dismissible fade show" role="alert">Incorrect username or password.</div> -->
			<form method="post">
				<!-- to error: add class "has-danger" -->
				<div class="form-group">
					<label for="exampleInputEmail1">Email address</label>
					<input type="email" name="email" class="form-control form-control-sm" id="exampleInputEmail1" aria-describedby="emailHelp">
				</div>
				<div class="form-group">
					<label for="exampleInputPassword1">Password</label>

					<input type="password" name="pass" class="form-control form-control-sm" id="exampleInputPassword1">
				</div>
				<button type="submit" name="sub" class="btn btn-primary btn-block">Sign in</button>

			</form>
		</div>
	</div>
</div>
</div>

    
    
    
    </body>
    
    
    </html>