<?php

include('config.php');



  
 


    
    
try{
   
  
   
$GLOBALS['con']=new mysqli($GLOBALS['dbhost'],$GLOBALS['dbuser'],$GLOBALS['dbpass'],$GLOBALS['dbname']);


}catch(\Exception $e){

    var_dump('Connection failed');exit;
    
}



if (mysqli_connect_errno()) {
  echo "Failed to connect to MySQL: " . mysqli_connect_error(); exit;

}

if (!function_exists('mysqli_fetch_all')) {
    function mysqli_fetch_all(mysqli_result $result) {
        $data = [];
      
        while ($d = $result->fetch_assoc()) {
            $t=[];
            $t[0]=$d['id'];
            $t[1]=$d['domain'];
            $t[2]=$d['detail'];
            $t[3]=$d['status'];
            $t[4]=$d['date'];
            
            if($d['createdAt']){
                $t[4]=$d['createdAt'];
                $t[5]=$d['updatedAt'];
                
            }
            
            
          
            array_push($data,$t);
           
        }
        return $data;
    }
}

function domain($domain){

$date=new DateTime();
$date=$date->format('Y-m-d H:i:s');

    $domain=trim($domain);
  
    
        $selectquesry="SELECT * FROM domain WHERE domain='$domain' LIMIT 1 ";
    	$result= mysqli_query($GLOBALS['con'], $selectquesry);
     $row = mysqli_fetch_row($result);
  
    	
      if($row){
          
           return $row[0];
             
          
          
      }else{
       
     
           $insert="INSERT INTO domain  VALUES (NULL,'$domain', '$date') ";
          	$result= mysqli_query($GLOBALS['con'], $insert);
        
         return mysqli_insert_id($GLOBALS['con']);
          
      }
    

return false;
    
    
    
}




function blogger($domain,$data){
    
    
    $date=new DateTime();
$date=$date->format('Y-m-d H:i:s');
    
      $id=domain($domain);
    
      $domain=trim($domain);
  
       $data=serialize($data);
    
        $selectquesry="SELECT * FROM bloggerip WHERE domain='$id' LIMIT 1 ";
    	$result= mysqli_query($GLOBALS['con'], $selectquesry);
        $row = mysqli_fetch_row($result);
  
    	
      if($row){
          
          
           $update="UPDATE  bloggerip  SET  detail='$data' WHERE domain='$id' LIMIT 1  ";
          	$result= mysqli_query($GLOBALS['con'], $update);
             
          
      }else{
       
    
           $insert="INSERT INTO bloggerip  VALUES (NULL,'$id', '$data' ,0,  '$date'); ";
          	$result= mysqli_query($GLOBALS['con'], $insert);
        
        // return mysqli_insert_id($GLOBALS['con']);
          
      }
    
    
    return true;
    
}


function dnsdata($domain,$data){
    
     $date=new DateTime();
$date=$date->format('Y-m-d H:i:s');
    
      $id=domain($domain);
    
      $domain=trim($domain);
  
       $data=serialize($data);
    
        $selectquesry="SELECT * FROM dnsrecord WHERE domain='$id' LIMIT 1 ";
    	$result= mysqli_query($GLOBALS['con'], $selectquesry);
        $row = mysqli_fetch_row($result);
  
    	
      if($row){
          
          
           $update="UPDATE  dnsrecord  SET  detail='$data' WHERE domain='$id' LIMIT 1  ";
          	$result= mysqli_query($GLOBALS['con'], $update);
             
          
      }else{
       
    
           $insert="INSERT INTO dnsrecord  VALUES (NULL,'$id', '$data',0,   '$date'); ";
          	$result= mysqli_query($GLOBALS['con'], $insert);
        
        // return mysqli_insert_id($GLOBALS['con']);
          
      }
    
    
    return true;
    
    
}



function nameserver($domain,$data){
    
     $date=new DateTime();
$date=$date->format('Y-m-d H:i:s');
    
      $id=domain($domain);
    
      $domain=trim($domain);
  $status=$data['status'];
  
       $data=serialize($data);
    
        $selectquesry="SELECT * FROM nameserver WHERE domain='$id' LIMIT 1 ";
    	$result= mysqli_query($GLOBALS['con'], $selectquesry);
        $row = mysqli_fetch_row($result);
  
    	
      if($row){
          
          
           $update="UPDATE  nameserver  SET status=0, detail='$data',updatedAt='$date'  WHERE domain='$id' LIMIT 1  ";
          	$result= mysqli_query($GLOBALS['con'], $update);
             
          
      }else{
       
    
           $insert="INSERT INTO nameserver  VALUES (NULL,'$id', '$data', '$status' ,'$date','$date'); ";
          	$result= mysqli_query($GLOBALS['con'], $insert);
        
        // return mysqli_insert_id($GLOBALS['con']);
          
      }
    
    
    return true;
    
    
}


function getstatus($domain,$name){
    $status=1;
    
      $domain=trim($domain);
           $id=domain($domain);
    
        $selectquesry="SELECT * FROM $name WHERE domain='$id' LIMIT 1 ";
    	$result= mysqli_query($GLOBALS['con'], $selectquesry);
        $row = mysqli_fetch_row($result);
  
    	
      if($row){
          
        
          $status=$row[3];
          
      }
    
    return $status;
}

function getdata($domain,$name){
    
    
  
      $domain=trim($domain);
           $id=domain($domain);
      
       $selectquesry="SELECT * FROM $name WHERE domain='$id' LIMIT 1 ";
    	$result= mysqli_query($GLOBALS['con'], $selectquesry);
        $row = mysqli_fetch_row($result);
        
       
        $data=[];
          if($row){
            $data=unserialize($row[2]);

         
            }
  
  
    return $data;

}


?>