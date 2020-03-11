000100200311       DCL-F SHIFTWEEK USAGE(*INPUT) KEYED RENAME(SHIFTWEEK:SHIFTWEEKR);
000101200302       DCL-F CONFIRMPAY WORKSTN;
000102200305       DCL-F SHIFTRATES DISK USAGE(*INPUT);
000103200302       DCL-F PAYRPT    PRINTER OFLIND(*IN01);
000104200302       DCL-S HOURSOVER PACKED(3);
000105200302
000107200305                       READ ShiftRates;
000108200302                       Write Title;
000109200302                       Write ColHdg;
000110200302                       READ SHIFTWEEK;
000111200302                       DOW NOT %EOF ;
000113200302                       EXSR PAYSR;
000114200302                       IF *IN01;
000115200302                         Write Title;
000116200302                         Write ColHdg;
000117200302                         *IN01 = *OFF;
000118200302                       ENDIF;
000119200302                       Write EmpDetail;
000120200302                       READ SHIFTWEEK;
000121200302                       ENDDO;
000122200305                       TOTWKPAY = TOTREGPAY + TOTOVPAY;
000123200302                       WRITE TOTALS;
000124200302                       EXFMT RECORD1;
000125200302                       *INLR = *ON;
000126200302                       RETURN;
000127200302
000128200302                       BEGSR PaySr;
000129200302                        //Set hourlyrate based on workshift value
000130200302                         SELECT;
000131200302                           When WORKSHIFT = '1';
000132200302                             HOURLYRATE = DAYRATE;
000133200305                           When WORKSHIFT = '2';
000134200305                             HOURLYRATE = AFTNRATE;
000135200305                           When WORKSHIFT = '3';
000136200305                             HOURLYRATE = NIGHTRATE;
000137200302                         ENDSL;
000138200302                         //Set HOURLYRATE based on PAYGRADE value
000139200302                         //eg when PAYGRADE has the value of A
000140200302                         // EVAL(H) HOURLYRATE = HOURLYRATE * 1.096
000141200302                         SELECT;
000142200302                           When PAYGRADE = 'A';
000143200302                             EVAL(H) HOURLYRATE *= 1.096;
000146200302                           When PAYGRADE = 'B';
000147200302                             EVAL(H) HOURLYRATE *= 1.072;
000148200302                           When PAYGRADE = 'C';
000149200302                             EVAL(H) HOURLYRATE *= 0.956;
000150200302                           When PAYGRADE = 'D';
000151200302                             HOURLYRATE = HOURLYRATE;
000152200302                         ENDSL;
000153200302
000154200302
000155200302                         //Based on HRSWORKED, calc HOURSOVER, OVERPAY, REGULARPAY, and WEEKLYPAY
000156200302                         //(Weekly total pay), eg.
000157200302                         //HOURSOVER = HRSWORKED - 40
000158200302                         //EVAL(H) OVERPAY =HOURSOVER * (1.5 * HOURLYRATE);
000159200302                         //EVAL REGULARPAY = 40 * HOURLYRATE;
000160200302                         HOURSOVER = HRSWORKED - 40;
000161200302                         IF (HOURSOVER < 0);
000162200302                           HOURSOVER = 0;
000163200302                         ENDIF;
000164200302
000165200305
000166200302                         EVAL(H) OVERPAY = HOURSOVER * (1.5 * HOURLYRATE);
000167200309
000168200305                         EVAL REGULARPAY = HRSWORKED * HOURLYRATE;
000169200302                         WEEKLYPAY = OVERPAY + REGULARPAY;
000170200302
000171200302                         //Accumulate totals; TOTREGPAY, TOTOVTPAY
000172200302                         TOTREGPAY += REGULARPAY;
000173200302                         TOTOVPAY += OVERPAY;
000174200305
000175200302
000176200302                       ENDSR;
