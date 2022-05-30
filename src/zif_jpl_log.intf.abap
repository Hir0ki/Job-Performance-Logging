INTERFACE zif_jpl_log
  PUBLIC .


  METHODS write
    IMPORTING
      !iv_string TYPE string .

  METHODS write_with_timestamp
    IMPORTING
      !iv_sting     TYPE string
      !iv_timestamp TYPE timestampl OPTIONAL.
ENDINTERFACE.
