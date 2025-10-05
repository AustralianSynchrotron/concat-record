# <span style='color:#f00000'>Concatination Record (concat)</span>

## <span style='color:#f00000'>Introduction</span>

The concat record is used to perform the concatination of one or more
scalar and/or array valued Process Variables (PVs) together with scalar
constants and json link constant array values (the later is new since
version 2.1).

Array valued PVs may be provided by the following record types: aai, compress,
subArray, waveform and also by other concat records.

The result of this concatination can then be accessed by any CA client
and/or other records.

The fields of this record fall into these categories (described below):

-   [scan parameters](#scan)
-   [read parameters](#read)
-   [operator display parameters](#display)
-   [alarm parameters](#alarm)
-   [monitor parameters](#monitor)
-   [run-time parameters](#run-time)

See also:

-   [record support routines](#support)
-   [record processing](#processing)


## <span style='color:#f00000'>License</span>

The concat record is released under the GNU Lesser General Public License.

## <span style='color:#f00000'>Key Features</span>

* the concat record support up to 100 inputs.
* the maximum number of elements and element type can be specified using the NELM
and FTVL fields, just like the waveform record.
* a missing input can be configured to:
   - fail record processing,
   - be skipped or ignored, or
   - be padded with a specified default value.
* supports the usual EGU, PREC, LOPR and HOPR fields.
* it also has ADEL and MDEL fields - a monitor is posted if the delta value of
any one element of the record exceeds the specified dead-band.
* has device driver support together with build in soft channel support
  (available since version 3.1.1).

## <span style='color:#f00000'>Example Usage</span>

These are real-world examples of usage of the concat record at the
Australian Synchrotron:

 - Creating a single 100 element PV (for a scanH record) from the 100 scaler PV
   provided by a 100 element detector.
 - Aggregating 98 Storage Ring BPM X and Y positions into two orbit PVs.
 - Creating an array PV of insertion device temperatue values for use with the
   compress record to find the mean and maximum values.


## <a name="scan"></a><span style='color:#f00000'>Scan Parameters</span>

The concat record has the standard fields for specifying under what
circumstances the record will be processed. These fields are listed in
[*Scan
Fields*](https://epics.anl.gov/base/R7-0/4-docs/dbCommonRecord.html#Scan-Fields).
In addition, [*Scanning
Specification*](https://docs.epics-controls.org/en/latest/guides/EPICS_Process_Database_Concepts.html#scanning-specification),
explains how these fields are used.

## <a name="read"></a><span style='color:#f00000'>Read Parameters</span>

The read parameters for the concat record are obtained from upto 100
input links: IN00, IN01, IN02, . . . IN99. These input fields can be
database links, channel access links, scalar constants or json array
constants. If they are links, they must specify another record\'s field
or be a channel access link. If they are constants, they will be
initialized with the value they are configured with. They cannot be
hardware addresses.

See [*Address
Specification*](https://docs.epics-controls.org/en/latest/guides/EPICS_Process_Database_Concepts.html#address-specification),
for information on how to specify database links.

When an input link refers to an array, or multi-valued, record the
expected size of the input is specified in the maximum elements fields
ME00, ME01, ME02, . . . ME99.

[The default value when an input is specified is effectively 1]{#note1},
so need not be specified for scalar inputs.

The values retrieved from the input links are concatinated and placed
into an array referenced by VAL. NELM specifies the number of elements
that the array will hold, while FTVL specifies the data type of the
elements.<br>

| Field | Summary         | Type     | DCT | Default | Read | Write | Mon | PP |
| ---   | -----           | ---      | --- | ------- | ---  | ---   | --- | -- |
| NELM  | Number of Elements in array  | ULONG  | Yes | 1 | Yes | No |  | No |
| FTVL  | Field Type of Value | MENU (<a href='https://epics.anl.gov/base/R7-0/4-docs/menuFtype.html'>menuFtype</a>)| Yes | STRING   | Yes |No |  | No |
| IN00  | Input Link 0    |  INLINK  | Yes |    | Yes | No |  | No |
| IN01  | Input Link 1    |  INLINK  | Yes |    | Yes | No |  | No |
| INxx  | Input Link xx   |  INLINK  | Yes |    | Yes | No |  | No |
| IN99  | Input Link 99   |  INLINK  | Yes |    | Yes | No |  | No |
| ME00  | Max Elements 0  |  ULONG   | Yes |    | Yes | No |  | No |
| ME01  | Max Elements 1  |  ULONG   | Yes |    | Yes | No |  | No |
| MExx  | Max Elements xx |  ULONG   | Yes |    | Yes | No |  | No |
| ME99  | Max Elements 99 |  ULONG   | Yes |    | Yes | No |  | No |


Notes:<br>
The **Field** column contains the name of the particular field
as it appears in the database, xx represents 02..98.<br>
The **Summary** column contains the full name of the field.<br>
The **Type** column gives the EPICS type of the field. These types are
defined in the `<dbFldTypes.h>`.<br>
The **DCT** column indicates whether the field is configurable prior to
run-time.<br>
The **Default** (Initial) column contains the default initialization
value of the field.<br>
The **Read** (Access) column indicates whether the field can be accessed
by the database routines for reading purposes.<br>
The **Write** (Modify) column indicates whether the field can be changed
at run-time, for example, by the operator.<br>
The **Mon** (Rec Proc Monitor) column indicates whether or not the field
is monitored at run-time for changes.<br>
The **PP** or process passive column indicates whether writing to this
field will cause the record to process.<br>

## <a name="output"></a><span style='color:#f00000'>Output Parameters</span>

These parameters specify and control the output capabilities of the
Calcout record. They determine when to write the output, where to write
it, and what the output will be. The OUT link specifies the Process
Variable to which the result will be written.<br>

| Field | Summary | Type | DCT | Default | Read | Write | Mon | PP |
| ---   | -----  | ---  | --- | ------- | ---  | ---   | --- | -- |
| DTYP  | Device Type  | DEVICE  | Yes |  Soft Channel | Yes | No |  | No |
| OUT   | Output Specification  | OUTLINK  | Yes |   | Yes | No |  | No |
| OOPT  | Output Execute Opt    | MENU (<a href="#concatOOPT">concatMODE</a>)  | Yes | Every Time | Yes | No |  | No |
| OEVT  | Event To Issue        | STRING [40]  | Yes |  | Yes | No |  | No |


### <a name="concatOOPT"></a><span style='color:#e00000'>Menu concatOOPT</span>

The OOPT field determines the condition that causes the output link to
be written to. It\'s a menu field that has two choices:<br>

| Index | Identifier            | Choice String |
| ---   | -----                 | ---           |
|  0    | concatOOPT_Every_Time |  Every Time   |
|  1    | concatOOPT_On_Change  |  On Change    |
|  2    | concatOOPT_Never      |  Never        |



 - `Every Time` -- write output every time record is processed.
 - `On Change` -- write output every time VAL changes, technically
    when any element change exceeds the MDEL value.
 - `Never` -- never write output when record is processed.

## <a name="display"></a><span style='color:#f00000'>Operator Display Parameters</span>

These parameters are used to present meaningful data to the operator.
These fields are used to display VAL and the other parameters of the
concat record either textually or graphically.

The EGU field contains a string of up to 16 characters which is supplied
by the user and which describes the values being operated upon. The
string is retrieved whenever the routine `get_units` is called. The EGU
string is solely for an operator\'s sake and does not have to be used.

The HOPR and LOPR fields only refer to the limits of the VAL fiels. PREC
controls the precision of the VAL field. These fields are only
appliciable when FTVL specifed a numeric type.

See [*Fields Common to All Record
Types*](https://epics.anl.gov/base/R7-0/4-docs/dbCommonRecord.html), for
more on the record name (NAME) and description (DESC) fields.<br>

| Field | Summary | Type | DCT | Default | Read | Write | Mon | PP |
| ---   | -----   | ---  | --- | ------- | ---  | ---   | --- | -- |
|  EGU   |  Engineering Units     | STRING [16] | Yes |         | Yes  | Yes   | No  | No  |
|  PREC  |  Display Precision     | SHORT       | Yes | 0       | Yes  | Yes   | No  | No  |
|  HOPR  |  High Operating Range  | DOUBLE      | Yes | 0.0     | Yes  | Yes   | No  | No  |
|  LOPR  |  Low Operating Range   | DOUBLE      | Yes | 0.0     | Yes  | Yes   | No  | No  |
|  NAME  |  Record Name           | STRING [61] | Yes |         | Yes  | No    | No  | No  |
|  DESC  |  Description           | STRING [41] | Yes |         | Yes  | Yes   | No  | No  |


## <a name="alarm"></a><span style='color:#f00000'>Alarm Parameters</span>

The concat record has the alarm parameters common to all record types.
[*Alarm Fields, Chapter 2, 3*](Recordref-6.html#MARKER-9-3), lists other
fields related to a alarms that are common to all record types.

## <a name="monitor"></a><span style='color:#f00000'>Monitor Parameters</span>

These parameters are used to determine when to send monitors for the
value fields. The monitors are sent when the any element of the value
field exceeds the last monitored field by the appropriate deadband, the
ADEL for archiver monitors and the MDEL field for all other types of
monitors. If these fields have a value of zero, everytime the value
changes, monitors are triggered; if they have a value of -1, everytime
the record is scanned, monitors are triggered. See [*Monitor
Specification*](https://docs.epics-controls.org/en/latest/process-database/EPICS_Process_Database_Concepts.html#monitor-specification),
for a complete explanation of monitors.<br>

| Field | Summary | Type | DCT | Default | Read | Write | Mon | PP |
| ---   | -----   | ---  | --- | ------- | ---  | ---   | --- | -- |
|  ADEL  |  Archive Deadband  |  DOUBLE  | Yes | 0.0     | Yes  | Yes   | No  | No |
|  MDEL  |  Monitor Deadband  |  DOUBLE  | Yes | 0.0     | Yes  | Yes   | No  | No |


## <a name="run-time"></a><span style='color:#f00000'>Run-time Parameters</span>

VAL references the array where the cancat record stores its data.

The NORD field holds a counter of the number of elements that have been
read into the array.

The NIEM and RIEM fields control how the concat record deals with
missing inputs and/or when inputs have less than the expected number of
elements. When padding is used to fill \"missing\" elements, the DFNV or
DFSV field provide the default value.

The concatination process uses the values retrieved from the INxx links.
These values retrieved from the input links are stored in the V01, V02,
\... V60 fields. For instance, the value obtained from the IN01 link is
stored in the field V01, and the value obtained from IN02 is stored in
field V02 etc. The actual number of elements retrieved from IN01 in
stored in the field NE01, and so on.<br>

| Field | Summary | Type | DCT | Default | Read | Write | Mon | PP |
| ---   | -----   | ---  | --- | ------- | ---  | ---   | --- | -- |
| VAL   |  Value Field               |  See FTVL    | No  | 0 | Yes | Yes | Yes | Yes |
| NORD  |  Number of Elements Read   |  ULONG       | No  | 0 | Yes | No  | No  | No  |
| NIEM  |  No input error mode       |  MENU (<a href="#concatMODE">concatMODE</a>)  | Yes | Fail | Yes | No | No | No |
| RIEM  |  Reduced input error mode  |  MENU (<a href="#concatMODE">concatMODE</a>)  | Yes | Skip | Yes | No | No | No |
| DFNV  |  Default pad numeric value |  DOUBLE      | Yes | 0.0 | Yes | No | No | No |
| DFSV  |  Dufault pad string value  |  STRING[40]  | Yes |     | Yes | No | No | No |
| V00   |  Input Value 0             |  See FTVL    | No  |   | Yes | Yes/No | Yes | Yes |
| V01   |  Input Value 1             |  See FTVL    | No  |   | Yes | Yes/No | Yes | Yes |
| Vxx   |  Input Value xx            |  See FTVL    | No  |   | Yes | Yes/No | Yes | Yes |
| V99   |  Input Value 99            |  See FTVL    | No  |   | Yes | Yes/No | Yes | Yes |
| NE00  |  Number Elements 0         |  ULONG       | No  | 0 | Yes | Yes/No | Yes | Yes |
| NE01  |  Number Elements 1         |  ULONG       | No  | 0 | Yes | Yes/No | Yes | Yes |
| NExx  |  Number Elements xx        |  ULONG       | No  | 0 | Yes | Yes/No | Yes | Yes |
| NE99  |  Number Elements 99        |  ULONG       | No  | 0 | Yes | Yes/No | Yes | Yes |


### <a name="concatMODE"></a><span style='color:#e00000'>Menu concatMODE</span>

The NIEM and RIEM fields control how the cocat record handles missing
input and reduced input. They are menus field that have three choices:<br>

| Index | Identifier      | Choice String |
| ---   | ----------      | ---           |
|  0    | concatMODE_Fail |  Fail         |
|  1    | concatMODE_Skip |  Skip         |
|  2    | concatMODE_Pad  |  Pad          |

 - `Fail` -- Record processing fails if input data missing or less than expected.
 - `Skip` -- Record processing continues, however this input is ignored.
 - `Pad ` -- Record processing continues, however missing data is padded with
              content of DFNV / DFSV.

## <a name="support"></a><span style='color:#f00000'>Record Support Routines</span>

#### <span style='color:#a00000'>init_record</span>

For each constant input link, the corresponding value field is
initialized with the constant value if the input link is CONSTANT or a
channel access link is created if the input link is PV_LINK.

#### <span style='color:#a00000'>process</span>

See next section.

#### <span style='color:#a00000'>special</span>

TBD

#### <span style='color:#a00000'>get_value</span>

Fills in the values of struct valueDes so that they refer to VAL.

#### <span style='color:#a00000'>get_units</span>

Retrieves EGU.

#### <span style='color:#a00000'>get_precision</span>

Retrieves PREC.

#### <span style='color:#a00000'>get_graphic_double</span>

Sets the upper display and lower display limits for a field. If the
field is VAL, V01 .. V060, the limits are set to HOPR and LOPR, else if
the field has upper and lower limits defined they will be used, else the
upper and lower maximum values for the field type will be used.

#### <span style='color:#a00000'>get_control_double</span>

Sets the upper control and the lower control limits for a field. If the
field is VAL, V01 .. V60, the limits are set to HOPR and LOPR, else if
the field has upper and lower limits defined they will be used, else the
upper and lower maximum values for the field type will be used.

## <a name="processing"></a><span style='color:#f00000'>Record Processing</span>

Routine process implements the following algorithm:

1. Fetch all arguments. Pad inputs with default values if required
as per the NIEM and RIEM fields

2. Call routine do_concat routine which concatinates all inputs
    into the VAL field.

3. Check to see if monitors should be invoked.
    -   Alarm monitors are invoked if the alarm status or severity has
        changed.
    -   Archive and value change monitors are invoked if ADEL and MDEL
        conditions are met.
    -   Monitors for V00 \... V99 and NE00 \... NE99 are checked
        whenever other monitors are invoked.

4. Scan forward link if necessary, set PACT FALSE, and return.

<font size="-1">Last updated: Sun Oct  5 13:03:36 2025</font>
<br>

