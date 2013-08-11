<?php
// MySQL
$mysqli = new mysqli('{{ mysql_host }}', '{{ mysql_username }}', '{{ mysql_password }}');

$mysql_running = true;
if (mysqli_connect_errno()) {
    $mysql_running = false;
} else {
  $mysql_version = $mysqli->server_version;
}

$mysqli->close();

// Memcached
$m = new Memcached();
$memcached_running = false;
if ($m->addServer('{{ memcached_host }}', {{ memcached_port }})) {
  $memcached_running = true;
  $memcached_version = $m->getVersion();
  $memcached_version = current($memcached_version);
}

define('APC_EXTENSION_LOADED', extension_loaded('apc') && ini_get('apc.enabled'));

function command_exist($cmd) {
    $returnVal = shell_exec("which $cmd");
    return (empty($returnVal) ? false : true);
}

function extended_command_exist($cmd) {
    exec(sprintf("%s 2>&1", $cmd),$pidArr, $status);
    return (($status > 0) ? false : true);
}

?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Vagrant LAMP stack</title>
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
        <i class="icon-wrench icon-4x"></i>
        <h1>Virtual Machine Settings</h1>
      </div>
      <p class="lead">The Virtual Machine is up and running, hooray! Here's some additional information you might need.</p>

      <h3>Core software</h3>
      <table class="table table-striped">
        <tr>
          <td>PHP Version</td>
          <td><?php echo phpversion(); ?></td>
        </tr>

        <tr>
          <td>MySQL running</td>
          <td><i class="icon-<?php echo ($mysql_running ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td>MySQL version</td>
          <td><?php echo ($mysql_running ? $mysql_version : 'N/A'); ?></td>
        </tr>

        <tr>
          <td>Memcached running</td>
          <td><i class="icon-<?php echo ($memcached_running ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td>Memcached version</td>
          <td><?php echo ($memcached_version ? $memcached_version : 'N/A'); ?></td>
        </tr>

         <tr>
          <td>APC Installed & Running</td>
          <td><i class="icon-<?php echo (APC_EXTENSION_LOADED ? 'ok' : 'remove'); ?>"></i></td>
        </tr>
      </table>

      <h3>Core PHP Modules</h3>
      <table class="table table-striped">
        <tr>
          <td>MySQL</td>
          <td><i class="icon-<?php echo (class_exists('mysqli') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td>CURL</td>
          <td><i class="icon-<?php echo (function_exists('curl_init') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td>mcrypt</td>
          <td><i class="icon-<?php echo (function_exists('mcrypt_encrypt') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td>memcached</td>
          <td><i class="icon-<?php echo (class_exists('Memcached') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td>gd</td>
          <td><i class="icon-<?php echo (function_exists('imagecreate') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td colspan="2">You can view more detailed PHP settings <a href="phpinfo.php">here</a></td>
        </tr>
      </table>

      <h3>MySQL credentials</h3>
      <table class="table table-striped">
        <tr>
          <td>Hostname</td>
          <td>{{ mysql_host }}</td>
        </tr>

        <tr>
          <td>Username</td>
          <td>{{ mysql_username }}</td>
        </tr>

        <tr>
          <td>Password</td>
          <td>{{ mysql_password }}</td>
        </tr>
      </table>

    <h3>Additional web development tools</h3>
      <table class="table table-striped">
        <tr>
          <td><a href="http://getcomposer.org/" target="_blank">PHP Composer</a></td>
          <td><i class="icon-<?php echo (command_exist('composer') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td><a href="http://sass-lang.com/" target="_blank">Sass</a></td>
          <td><i class="icon-<?php echo (extended_command_exist('sass --version') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td><a href="http://compass-style.org/" target="_blank">Compass</a></td>
          <td><i class="icon-<?php echo (extended_command_exist('compass') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td><a href="http://lesscss.org/" target="_blank">Less</a></td>
          <td><i class="icon-<?php echo (command_exist('less') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td><a href="http://csslint.net/" target="_blank">CSSLint</a></td>
          <td><i class="icon-<?php echo (command_exist('csslint') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td><a href="http://www.jshint.com/" target="_blank">JSHint</a></td>
          <td><i class="icon-<?php echo (command_exist('jshint') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td><a href="https://github.com/lepture/python-livereload" target="_blank">Python Livereload</a></td>
          <td><i class="icon-<?php echo (command_exist('livereload') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td><a href="http://yeoman.io/" target="_blank">Yeoman + Grunt + Bower</a></td>
          <td><i class="icon-<?php echo (command_exist('yo') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>

        <tr>
          <td><a href="http://phpqatools.org/" target="_blank">PHP QA Tools</a></td>
          <td><i class="icon-<?php echo (command_exist('phpunit') ? 'ok' : 'remove'); ?>"></i></td>
        </tr>
      </table>

      <h3>Additional Programming Languages & tools <br />(used to install some of the tools above)</h3>
      <table class="table table-striped">
        <tr>
          <td>Python</td>
          <td><i class="icon-<?php echo (command_exist('python') ? 'ok' : 'remove'); ?> "></i></td>
        </tr>

        <tr>
          <td>Ruby</td>
          <td><i class="icon-<?php echo (command_exist('ruby') ? 'ok' : 'remove'); ?> "></i></td>
        </tr>

        <tr>
          <td>RVM</td>
          <td><i class="icon-<?php echo (command_exist('rvm') ? 'ok' : 'remove'); ?> "></i></td>
        </tr>

        <tr>
          <td>Gem</td>
          <td><i class="icon-<?php echo (command_exist('gem -v') ? 'ok' : 'remove'); ?> "></i></td>
        </tr>

        <tr>
          <td>Nodejs</td>
          <td><i class="icon-<?php echo (command_exist('node') ? 'ok' : 'remove'); ?> "></i></td>
        </tr>
      </table>
    </div>
    <div id="push"></div>
  </div>

  <div id="footer">
    <div class="container">
      <p class="muted credit">This file is heavily inspired from <a href="https://github.com/MiniCodeMonkey" traget="_blank">Code Monkey</a>.</p>
    </div>
  </div>
</body>
</html>
