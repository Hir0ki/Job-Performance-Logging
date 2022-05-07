CLASS zcl_jpl_timer DEFINITION
  PUBLIC
  FINAL
  CREATE PROTECTED
  GLOBAL FRIENDS zcl_jpl_factory.

  PUBLIC SECTION.

    INTERFACES zif_jpl_timer .
    METHODS constructor
      IMPORTING iv_name       TYPE string
                io_ref_parent TYPE REF TO zif_jpl_timer OPTIONAL.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA: ms_timer_data      TYPE zif_jpl_timer=>tty_jpl_timer_data,
          mv_start_timestamp TYPE timestamp,
          mo_timer           TYPE REF TO if_abap_runtime,
          mo_runtime         TYPE REF TO if_abap_runtime.
ENDCLASS.



CLASS zcl_jpl_timer IMPLEMENTATION.


  METHOD zif_jpl_timer~start.
    " get timestamp for loop if run that is longer then 10 min.
    GET TIME STAMP FIELD mv_start_timestamp.
    " get runtime for loop if run shorter then 10 min.
    mo_runtime = cl_abap_runtime=>create_hr_timer(  ).
    me->mo_runtime->get_runtime( ).
  ENDMETHOD.


  METHOD zif_jpl_timer~accumulate.
    GET TIME STAMP FIELD DATA(lv_current_timestamp).
    DATA(lv_current_runtime) = me->mo_runtime->get_runtime( ).
    FREE me->mo_runtime.
    DATA(lv_timestamp_diff) =  cl_abap_tstmp=>subtract( tstmp1 =  lv_current_timestamp tstmp2 = mv_start_timestamp  ).

    " uses to seconds timestamp after 2000s because after 2147.483647 seconds the runtime value overflows.
    IF lv_timestamp_diff > 2000.
      ms_timer_data-total_runtime_ms = ms_timer_data-total_runtime_ms + lv_current_timestamp * 1000.
    ELSE.
      " convert lv_current_runtime form microseconds to milliseconds so it can be added to total_runtime_ms
      ms_timer_data-total_runtime_ms = ms_timer_data-total_runtime_ms + lv_current_runtime / 1000.
    ENDIF.
    ms_timer_data-total_loops = ms_timer_data-total_loops + 1.


    CLEAR mv_start_timestamp.


  ENDMETHOD.

  METHOD zif_jpl_timer~get_timer_data.
    rs_timer_data = me->ms_timer_data.
  ENDMETHOD.


  METHOD constructor.
    ms_timer_data-name = iv_name.
    ms_timer_data-parent_ref = io_ref_parent.
  ENDMETHOD.

ENDCLASS.
