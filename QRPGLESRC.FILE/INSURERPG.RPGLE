000001200129       dcl-f INCOMETDSP WORKSTN;
000002200129
000003200129       DOW NOT(*IN03);
000006200129       //SECONDLINE?  ******
000007200129
000008200129       IF IncomeAmt = 0;
000009200129         *IN98 = *ON; //Zero Income Amount
000010200129         EXFMT GetIncome;
000011200129         *IN98 = *OFF;
000012200129         ITER; // Go to the ENDO for next loop
000013200129
000014200129       ELSEIF MARRIED = ' ';
000015200129         *IN97 = *ON;
000016200129       ELSE;
000017200129         //ONE   *****
000018200129         //TWO    *****
000020200129         //THREE?  *****
000021200129
000022200129       ENDIF;
000023200129
000024200129       //DAYSTOPAY = ???
000025200129       //TAXAMT = ???
000026200129
000027200129       //PROTECT FIRST SCREEN RECORD FIELDS
000028200129       //REDISPLAY FIRST SCREEN RECORD AND THEN OVERLAY SECOND RECORD
000029200129
000030200129       //FIRST  *****
000031200129       //SECOND  *****
000032200129       //THIRD   *****
000033200129       //FOURTH  *****
000034200129
000035200129        IF *IN03=*OFF;
000036200129          EXSR CLEAR;
000037200129          EXFMT GetIncome;
000038200129        ENDIF;
000039200129       ENDDO;
000040200129       *INLR = *ON;
000041200129       RETURN;
000042200129
000043200129
000044200129
