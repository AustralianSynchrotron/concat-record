# concat record

The concat record is an EPICS record is used to perform concatenation of scalar
constants, scalar values retrieved from other records and array values retrieved
from other records (such as from the compress, subArray and waveform records and
also from other concat records) into array an record.

## key features

* the concat record support up to 100 inputs
* the maximum number of elements and element type can be specified using the NELM
and FTVL fields, just like the waveform record.
* a missing input can be configured to:
   - fail record processing,
   - be skipped or ignored, or
   - be padded with a default value.
* supports the usual EGU, PREC, LOPR and HOPR fields.
* it also has ADEL and MDEL fields - a monitor is posted if the delta value of
any one element of the record exceeds the specified deadband.
