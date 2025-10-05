/* File: concatRecordSup/devConcatSoft.c
 * DateTime: Fri Oct  3 13:41:37 2025
 * Last checked in by: andrew
 *
 * Copyright (c) 2025  Australian Synchrotron
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Contact details:
 * andrews@ansto.gov.au
 * 800 Blackburn Road, Clayton, Victoria 3168, Australia.
 *
 * Description:
 * Soft device support routines for the concat record.
 *
 * Credit:
 * This module is a direct crib of devCalcoutSoft.c and devCalcoutSoftCallback.c
 * both authored by: Marty Kraimer, date: 05DEC2003.
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "alarm.h"
#include "dbDefs.h"
#include "dbAccess.h"
#include "recGbl.h"
#include "devSup.h"
#include "cantProceed.h"
#include "menuYesNo.h"
#include "concatRecord.h"
#include "epicsExport.h"

/* Create the dset for devConcatSoft and devConcatSoftCallback
 */
static long init_record (dbCommon *pcommon);
static long write_concat (concatRecord *prec);
static long write_concat_callback (concatRecord *prec);

concatdset devConcatSoft = {
   {5,
    NULL,
    NULL,
    init_record,
    NULL
   },
   write_concat
};
epicsExportAddress (dset, devConcatSoft);

concatdset devConcatSoftCallback = {
   {5,
    NULL,
    NULL,
    init_record,
    NULL
   },
   write_concat_callback
};
epicsExportAddress (dset, devConcatSoftCallback);


/* -----------------------------------------------------------------------------
 */
static long init_record (dbCommon *pcommon)
{
   concatRecord *prec = (concatRecord *)pcommon;
   struct link *plink = &prec->out;

   if (dbLinkIsConstant (plink)) {
      prec->nord = 0;
   }
   return 0;
}

/* -----------------------------------------------------------------------------
 */
static long write_concat (concatRecord *prec)
{
   struct link *plink = &prec->out;
   long nRequest = prec->nord;

   /* prec->simm == menuYesNoYES ? &prec->siol : &prec->out */
   dbPutLink (plink, prec->ftvl, prec->val, nRequest);

   return 0;
}

/* -----------------------------------------------------------------------------
 */
static long write_concat_callback (concatRecord *prec)
{
   struct link *plink = &prec->out;
   long nRequest = prec->nord;
   long status;

   if (prec->pact)
      return 0;

   status = dbPutLinkAsync (plink, prec->ftvl, prec->val, nRequest);
   if (!status)
      prec->pact = TRUE;
   else if (status == S_db_noLSET)
      dbPutLink (plink, prec->ftvl, prec->val, nRequest);

   return 0;
}

/*  end */
