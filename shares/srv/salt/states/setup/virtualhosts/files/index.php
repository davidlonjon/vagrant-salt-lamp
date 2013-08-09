<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>It works!</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.no-icons.min.css" rel="stylesheet" />
  <link href="//netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet">
  <style type="text/css">
  html, body {
    height: 100%;
  }
  #wrap {
    min-height: 100%;
    height: auto !important;
    height: 100%;
    margin: 0 auto -60px;
  }
  #push, #footer {
    height: 60px;
  }
  #footer {
    background-color: #f5f5f5;
  }
  @media (max-width: 767px) {
    #footer {
      margin-left: -20px;
      margin-right: -20px;
      padding-left: 20px;
      padding-right: 20px;
    }
  }
  .container {
    width: auto;
    max-width: 680px;
  }
  .container .credit {
    margin: 20px 0;
  }
  .page-header i {
    float: left;
    margin-top: -5px;
    margin-right: 12px;
  }
  table td:first-child {
    width: 300px;
  }
    </style>
</head>
<body>
  <div id="wrap">
    <div class="container">
      <div class="page-header">
        <i class="icon-lightbulb icon-4x"></i>
        <h1>It works!</h1>
      </div>
      <p class="lead">The Virtual Machine is up and running, yay! You might want to see some additional server information <a href="http://<?php echo $_SERVER['SERVER_ADDR'] ?>/index.php">here</a></p>

      <em>Note: External access is enabled! </em>

    <div id="push"></div>
  </div>

  <div id="footer">
    <div class="container">
      <p class="muted credit">This file is heavily inspired from <a href="https://github.com/MiniCodeMonkey" traget="_blank">Code Monkey</a>.</p>
    </div>
  </div>
</body>
</html>
