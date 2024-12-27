<?php
    $f = fopen("test2.bin", "w");
    fwrite($f, chr(0240));
    fwrite($f, chr(0));
    fwrite($f, chr(0));
    fwrite($f, chr(0));    
    for ($i=0; $i<(1024-2); $i++)
    {
	fwrite($f, chr($i&0xFF));
	fwrite($f, chr($i>>8));
    }    
    
    for ($i=0; $i<22*1024; $i++) fwrite($f, chr(0));
    
    fclose($f);
    