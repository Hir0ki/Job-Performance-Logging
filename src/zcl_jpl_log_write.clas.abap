CLASS zcl_jpl_log_write DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_jpl_log .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_jpl_log_write IMPLEMENTATION.
  METHOD zif_jpl_log~write.
    WRITE: iv_string. NEW-LINE.
  ENDMETHOD.

  METHOD zif_jpl_log~write_with_timestamp.
    DATA lv_current_timestamp TYPE timestamp.

    GET TIME STAMP FIELD lv_current_timestamp.

    WRITE: |{ lv_current_timestamp TIMESTAMP = ISO } { iv_sting }|.
  ENDMETHOD.

ENDCLASS.
