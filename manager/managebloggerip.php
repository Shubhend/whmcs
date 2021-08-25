<?php session_start();
include('function.php');

 if(! $_SESSION["admin"]){
      
       header("Location: index.php");  exit; 
  }

?>




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


<link href="https://cdn.jsdelivr.net/npm/boxicons@2.0.0/css/boxicons.min.css" rel="stylesheet">

<link href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.dataTables.min.css" rel="stylesheet">

<link href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js">
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js">
</script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.min.js">
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.19/js/jquery.dataTables.min.js">
</script>

<script src="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js">
</script>

<script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js">
</script>


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
    
 <?php include('header.php'); ?>
    
    
<div class="container text-center" style="max-width:97% !important;">

  <form action="" method="post" style="border:2px solid black;padding:20px;margin:10px">
      
         <div class="form-group">
      <label >Select Filter</label>
      <select id="" name="filter" class="form-control">
            <option value="3"> All </option>
        <option value="0"> Pending </option>
        <option value="1"> Completed </option>
      </select>
    </div>
      
        <button type="submit" class="btn btn-primary" name="filtersearch" > Search
               </button>
      
      
  </form>
  
  
</div>
    
    <?php
    
    if(isset($_GET['logout'])){
        
        session_destroy();
         header("Location: index.php");  exit; 
        
    }
    
    
    ?>
    
    

    
    <div class="container" style="max-width:97% !important;">
        
           <?php
       if(isset($_POST['changestatus'])){
        
             $date=new DateTime();
             $date=$date->format('Y-m-d H:i:s');
        
        $status=$_POST['status'];
        $id=$_POST['id'];
          $newstatus=0;
        
        if($status==0){
            $newstatus=1;
        }
           
          
           $update="UPDATE  bloggerip  SET  status='$newstatus'  WHERE id='$id' LIMIT 1  ";
           
          
           
           
          	$result= mysqli_query($GLOBALS['con'], $update);
        
        
           header("Location: managebloggerip.php?msg=1");
        
       exit;
        
        
        
       }
    ?>
     
      <?php 
        
        if(isset($_GET['msg'])){
             echo '<div class="alert alert-primary" role="alert">
Status Updated
</div>';
            
        }
        
        ?>   
        
        
  <div class="row py-5">
    <div class="col-12">
        
        
        
        
        
        
        
        
        
      <table id="example" class="table table-hover responsive nowrap" style="width:100%">
        <thead>
          <tr>
            <th>Domain Name</th>
            <th>Details</th>
            <th>Created Date</th>
          
            <th>Current Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
            
            
            <?php
            
            
               
        $selectquesry="SELECT * FROM bloggerip ";
        
         if(isset($_POST['filtersearch']) ){
               $postst=$_POST['filter'];
               
               if($postst !=3)
               $selectquesry="SELECT * FROM bloggerip WHERE status='$postst' ";
       
               
           }
        
        
        
        
        
    	$result= mysqli_query($GLOBALS['con'], $selectquesry);
        $row = mysqli_fetch_all($result);
  
        foreach($row as $row){
            
               $domainid=$row[1];
      
        $selectquesry="SELECT * FROM domain WHERE id='$domainid' LIMIT 1 ";
    	$result= mysqli_query($GLOBALS['con'], $selectquesry);
        $rowd = mysqli_fetch_row($result);
  
  
         $domain=$rowd[1];
         
         $nameid=$row[0];
         
         $data=unserialize($row[2]);
         
       
         $createdate=$row[4];
     
         $status=$row[3];
            
            
            
            
            $tablerows="<tr> <td> ".$data['name']."  </td><td> ".$data['destination']." </td>  </tr>";


 
    
            
            ?>
            
            
          <tr>
            <td>
            
                <div class="d-flex align-items-center">
                  <div class="avatar avatar-blue mr-3"><?= $domain ?></div>

                </div>
              
            </td>
            <td>
            
            
                <table class="table" >
                    <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Destination</th>
                      
                      

                    </tr>
                    </thead>
                    <tbody>
<?= $tablerows ?>  
                    
                    </tbody>
                </table>


            </td>
            <td><?= $createdate ?></td>
        
            <td>
            
            <?php 
            
            if($status==0){
                
                echo '<div class="badge badge-danger badge-error-alt">Pending</div>';
                
            }else{
                
               echo '<div class="badge badge-success badge-success-alt">Completed</div>'; 
            }
            
            ?>    
                
            
            </td>
            <td>
          
          <form method="post" action="">
               <button type="submit" class="btn btn-primary" name="changestatus" > Change to
               
                  <?php 
            
            if($status==0){
                
                echo 'Complete';
                
            }else{
                
               echo 'Pending'; 
            }
            
            ?>    
               
               </button>
              <input type="hidden" name="id" value="<?= $nameid ?>">
                <input type="hidden" name="status" value="<?= $status ?>">
             
             
              
              
          </form>
          
            </td>
          </tr>

<?php 
}


?>



        </tbody>
      </table>
    </div>
  </div>
</div>

    
    
    
    
    <script>
        
        $(document).ready(function() {
  $("#example").DataTable();

  $(".dataTables_filter input")
    .attr("placeholder", "Search here...")
    .css({
      width: "300px",
      display: "inline-block"
    });

  $('[data-toggle="tooltip"]').tooltip();
});

    </script>
    
    </body>
    
    
    </html>