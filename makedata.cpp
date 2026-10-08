#include <windows.h>
#include <stdio.h>

    unsigned int lba = 1;
    unsigned short secbuf[256];
    unsigned int datacnt = 0;

void main ()
{
    FILE *f = fopen("default.img", "rb");
    fseek(f, 512, SEEK_SET);
    FILE *g = fopen("wdinit_data.bin", "wb");
    FILE *h = fopen("wdinit_data.mac", "w");    
    while ((!feof(f)) & (lba <= 65535))
    {
        // read and invert data
        int l = fread(secbuf, 2, 256, f);
        if (l < 256) break;
        bool havedata = false;
        for (int i=0; i<256; i++) {
            unsigned short w = secbuf[i] ^ 0xFFFF;
            secbuf[i] = w;
            if (w != 0x0000) havedata = true;
        }
        // write data if not empty
        if (havedata)
        {
            fwrite(secbuf, 2, 256, g);
            fprintf(h, "\t.word\t%u., %u.\n", lba&0xFFFF, (lba>>16)&0xFFFF);
            datacnt++;
        }
        // next sector
        lba++;
        if (lba % 100) { 
            printf("Lba: %u\r", lba);
        }
    }
    printf("\nSectors with data: %u\n", datacnt);
    // align with 79 cylinders (one cylinder is for code)
    memset(secbuf, 0, 512);
    while (datacnt < 79*20) { fwrite(secbuf, 2, 256, g); datacnt++; }
    // close files
    fclose(f);
    fclose(g);
    fclose(h);
}