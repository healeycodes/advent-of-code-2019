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

    if (!checkLoneAdjacent($guess)) {
        continue;
    }

    if (!digitsDontDecrease($guess)) {
        continue;
    }
    $passwords++;
}

// Check we have at least one instance of two adjacent digits
// Digits that are three-in-a-row or more don't count
function checkLoneAdjacent(string $str): bool
{
    for ($i = 1; $i < strlen($str); $i++) {
        if ($str[$i] == $str[$i - 1]) {
            if ($i - 2 > -1) {
                if ($str[$i] == $str[$i - 2]) {
                    continue;
                }
            }
            if ($i + 1 < strlen($str)) {
                if ($str[$i] == $str[$i + 1]) {
                    continue;
                }
            }
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
