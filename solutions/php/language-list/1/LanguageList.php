<?php

function language_list($string = "", $string2 = "",   $string3 = "")
{
    if ($string == "" && $string2 == "") {
        return [];
    } 
    $res = [];
    if ($string != "" ){
        $res[] = $string;
    }
    if ($string2 != "" ){
        $res[] = $string2;
    }
    if ($string3 != "" ){
        $res[] = $string3;
    }    
    return $res;
   
}

function add_to_language_list($list, $new) {
    $list[] = $new;
    return $list;
}

function prune_language_list($list) {
    $first = array_shift($list);
    return $list;
}

function current_language($list) {
     
    return $list[0];
}

function language_list_length($list) {
    return count($list);
}