# concat record

The concat record can be used to perform the concatination of one or more scalar and/or
array valued Process Variables (PVs) together with scalar constants and json link
constant array values (the later is new since version 2.1).
Array valued PVs may be provided by records such as an aai, a compress, a subArray,
and/or a waveform record and also by other concat records.

## key features

* the concat record support up to 100 inputs
* the maximum number of elements and element type can be specified using the NELM
and FTVL fields, just like the waveform record.
* a missing input can be configured to:
   - fail record processing,
   - be skipped or ignored, or
   - be padded with a specified default value.
* supports the usual EGU, PREC, LOPR and HOPR fields.
* it also has ADEL and MDEL fields - a monitor is posted if the delta value of
any one element of the record exceeds the specified dead-band.

## documentation

This is available 
[here](https://github.com/AustralianSynchrotron/concat-record/blob/master/documentation/concat_record.html).

<font size="-1">Last updated: Sat Sep 16 12:42:54 AEST 2023</font>
<br>
