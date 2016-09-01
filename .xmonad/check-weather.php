#!/usr/bin/env php
<?php
ini_set('display_errors',1);
error_reporting(E_ALL);

$W = new Weather();

$weather = $W->get_weather();
$temp    = $W->get_temperature();
$rain    = $W->get_rainfallchance();

$rain = '<fc=#99CCCC>'.join('</fc>:<fc=#99CCCC>',$rain).'</fc>';


echo "Osaka: <fc=#99CCCC>{$temp}</fc>℃ {$rain}";


class Weather {
    public $timezone   = 'Asia/Tokyo';
    public $url = "http://www.drk7.jp/weather/xml/27.xml";
    private $xml;

    function __construct() {
        date_default_timezone_set($this->timezone);
        $result    = $this->curl_get_contents($this->url,120);
        $this->xml = simplexml_load_string($result);
    }

    function get_weather(){
        $xml = $this->xml;
        return (string) $xml->pref->area->info->weather;
    }
    function get_temperature(){
        $xml = $this->xml;
        $range = (array) $xml->pref->area->info->temperature->range;

        return $range[1] . '-' . $range[0];
    }

    function get_rainfallchance(){
        $xml = $this->xml;
        $rainfallchance = $xml->pref->area->info->rainfallchance;
        $unit = $rainfallchance->attributes();
        foreach($rainfallchance->period as $period){
            $arr[] = $period.$unit;
        }
        return $arr;
    }


    function curl_get_contents($url,$timeout = 60 ){
        $ch = curl_init();
        curl_setopt( $ch, CURLOPT_URL, $url );
        curl_setopt( $ch, CURLOPT_HEADER, false );
        curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
        curl_setopt( $ch, CURLOPT_TIMEOUT, $timeout );
        $result = curl_exec( $ch );
        curl_close( $ch );

        return $result;
    }

    function xml2array ($xmlObject,$out = array()){
        foreach ((array) $xmlObject as $index => $node ){
            $out[$index] = (is_object($node))? xml2array($node) : $node;
        }
        return $out;
    }
}

?>
