#!/usr/bin/env php
<?php

require dirname(__FILE__).'/GameTimer.php';

ini_set('display_errors',1);
error_reporting(E_ALL);

$game_list = array(
    'CC',
    'AV',
    'DC',
    'SC',
);

$str_list = array();
foreach ($game_list as $game_name) {
    $str_list[] = get_str($game_name);
}

echo join(' : ',$str_list);
exit;

function get_str($game_name)
{
    $GT = new GameTimer();
    $GT->init($game_name);

    $game_name = $GT->getGameName();
    $time_left = $GT->getTimeLeft();
    $current_ap = $GT->getCurrentAp();
    $max_ap = $GT->getMaxAp();

    if (strpos($time_left,'+') === 0) {
        $time_left = "<fc=#FF4040>${time_left}</fc>";
    } else {
        $time_left = "<fc=#99CCCC>{$time_left}</fc>";
    }

    if ($current_ap >= $max_ap) {
        $current_ap = "<fc=#FF4040>${current_ap}</fc>";
    } else {
        $current_ap = "<fc=#99CCCC>{$current_ap}</fc>";
    }

    return "{$game_name} {$time_left} ({$current_ap}/{$max_ap})";
}
?>
