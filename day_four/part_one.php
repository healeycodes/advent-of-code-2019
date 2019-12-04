<?php
$filename = $argv[1];
$input = explode('-', file_get_contents($filename));
$from = intval($input[0]);
$to = intval($input[1]);
$passwords = 0;

for ($i = $from; $i < $to - 1; $i++) {
    $guess = strval($i);
    $len = strlen($guess);

    if ($len != 6) {
        continue;
    }

    if (!checkAdjacent($guess)) {
        continue;
    }

    if (!digitsDontDecrease($guess)) {
        continue;
    }
    $passwords++;
}

function checkAdjacent(string $str): bool
{
    for ($i = 1; $i < strlen($str); $i++) {
        if ($str[$i] == $str[$i - 1]) {
            return true;
        }
    }
    return false;
}

function digitsDontDecrease(string $str): bool
{
    for ($i = 1; $i < strlen($str); $i++) {
        if (intval($str[$i]) < intval($str[$i - 1])) {
            return false;
        }
    }
    return true;
}

echo $passwords;
