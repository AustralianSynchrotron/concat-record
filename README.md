# concat-record
The concat record is an EPICS record is used to perform concatination of scalar 
constants, scalar values retrieved from other records and array values retrieved 
from other records (such as from the compress, subArray and waveform records and 
also from other concat records) into array an record.

## key features

* the concat record support up to 100 inputs 
* the maximum number of elements and element type can be specified using the NELM and FTVL fields, just like the waveform record.
* a missing input can be configure to failure record processing, be skipped, or padded with a default value.
* supports the usual EGU, PREC, LOPR and HOPR fields.
* also has ADEL and MDEL fields - a monitor is posted if the delta value of any one element of the record exceeds the specified deadband.

