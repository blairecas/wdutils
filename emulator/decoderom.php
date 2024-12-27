<?php

    $f = fopen("ide_wdromv0110.bin", "r");
    $g = fopen("test.bin", "w");

    $sin1 = fread($f, 032);
    $sin2 = fread($f, 070*2);
    
    fwrite($g, $sin1, 032);
    for ($i=0; $i<070; $i++) {
        fwrite($g, $sin2[$i*2], 1);
    }
    
    fclose($f);
    fclose($g);