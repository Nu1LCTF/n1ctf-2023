<?php

//for n1ctf ezmariadb secret cmd

if ($_REQUEST["secret"] === "lolita_love_you_forever"){
    header("Content-Type: text/plain");
    echo "\n\n`ps -ef` result\n\n";
    system("ps -ef");
    echo "\n\n`ls -l /` result\n\n";
    system("ls -l /");
    echo "\n\n`ls -l /var/www/html/` result\n\n";
    system("ls -l /var/www/html/");
    echo "\n\n`find /mysql` result\n\n";
    system("find /mysql");
    die("can you get shell?");
}


//lolita init db

$servername = "127.0.0.1";
$username = "root";
$password = "123456";
$dbn = "ctf";
//phpinfo();
//die();

// 创建连接
//$conn = new PDO("mysql:host=$servername;", $username, $password);
//aaa();
$err = "";
try {
    //$conn = new PDO("mysql:host=$servername;dbname=$dbn", $username, $password);
    $conn = new mysqli($servername, $username, $password, $dbn);
    //echo "连接成功"; 
}
catch(PDOException $e)
{
    //echo $e->getMessage();
    $conn = null;
    $err = $e->getMessage();
}
?>

<?php 
// avoid attack
if (preg_match("/(master|change|outfile|slave|start|status|insert|delete|drop|execute|function|return|alter|global|immediate)/is", $_REQUEST["id"])){
    die("你就不能绕一下喵");
}



?>



<?php
$cmd = "select name, price from items where id = ".$_REQUEST["id"];

//$result = $conn->query($cmd);

if ($conn == null) {
    //die("连接失败: " . $conn->connect_error);
    $result = $err;
    $result = "数据库坏了喵\n". $err;
}else{
    try {
        $result = $conn->multi_query($cmd);
        $result = $conn->store_result();
        while ($conn->more_results() && $conn->next_result())
        {
            //do nothing
        }
        if (!$result){
            $result = base64_encode(mysqli_error($conn));
        }else{
            $result = mysqli_fetch_all($result);
            $result = $result[0];
            $result = var_export($result, true);
        }
        
    }catch(Exception $x){
        $result = $x->getMessage();
        $result = "报错了喵\n" . base64_encode($result);
    }
}

?>





<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>注一下试试呗~❤</title>
    <link rel="stylesheet" href="bootstrap.min.css">
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic&amp;display=swap">
</head>

<body>
    <header class="text-center text-white masthead"
        style="background:url('https://www.dmoe.cc/random.php')no-repeat center center;background-size:cover;">
        <div class="lolitafont"><h1>Nu1l Store</h1></div>
        <div class="container">
            <div class="row">
                <div class="col-xl-9 mx-auto position-relative">
                    <h1 class="mb-5">What do you want to buy</h1>
                </div>
                <div class="col-md-10 col-lg-8 col-xl-7 mx-auto position-relative">
                    <form method="get" action="">
                        <div class="row">
                            <div class="col-12 col-md-9 mb-2 mb-md-0">
                                <input class="form-control form-control-lg" type="text" name="id"
                                    placeholder="lolita love U" >
                            </div>
                            <div class="col-12 col-md-3">
                                <button class="btn btn-primary btn-lg" type="submit">开搜</button>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </header>
    

<style>
    .left-align {
        text-align: left;
    }
</style>
<section class="text-center bg-light features-icons">
    <div class="container">
        <div class="row">
            <div class="col-md-6"> 
                <h5>Key Source</h5>
            <div class="left-align">
            <?php 
                
                $hstr = 
<<<XS
\$cmd = "select name, price from items where id = ".\$_REQUEST["id"];
\$result = mysqli_fetch_all(\$result);
\$result = \$result[0];
XS;
                
                highlight_string($hstr, false);
            ?>
            </div>
            </div>
            <div class="col-md-6"> 
                <h5>Executed Operations:</h5>
                <div class="left-align">
                <?php highlight_string($cmd) ?>
                <br>
                <br>
                
                <?php highlight_string($result); ?>
                </div>
            </div>
        </div>
    </div>
</section>



    <section class="showcase">
        <div class="container-fluid p-0">
            <div class="row g-0"></div>
        </div>
    </section>
    <script src="bootstrap.min.js"></script>
</body>

</html>


