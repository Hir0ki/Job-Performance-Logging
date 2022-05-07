CLASS zcl_jpl_factory
 DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    TYPES ty_jpl_timer_table TYPE STANDARD TABLE OF REF TO zif_jpl_timer WITH EMPTY KEY.
    CLASS-DATA mt_jpl_timer_table TYPE ty_jpl_timer_table.
    CLASS-METHODS create_root_timer
      IMPORTING iv_name         TYPE string
      RETURNING VALUE(ro_timer) TYPE REF TO zif_jpl_timer.
    CLASS-METHODS create_timer
      IMPORTING iv_name         TYPE string
                io_parent_tiemr TYPE REF TO zif_jpl_timer
      RETURNING VALUE(ro_timer) TYPE REF TO zif_jpl_timer
      RAISING
        cx_abap_invalid_param_value.
    CLASS-METHODS: get_mt_jpl_timer_table RETURNING VALUE(r_result) TYPE ty_jpl_timer_table.


  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_jpl_factory IMPLEMENTATION.
  METHOD create_root_timer.
    ro_timer = NEW zcl_jpl_timer( iv_name = iv_name ).
    APPEND ro_timer TO mt_jpl_timer_table.
  ENDMETHOD.

  METHOD create_timer.
    IF io_parent_tiemr IS BOUND.
      ro_timer = NEW zcl_jpl_timer( iv_name = iv_name io_ref_parent = io_parent_tiemr ).
      APPEND ro_timer TO mt_jpl_timer_table.
    ELSE.
      RAISE EXCEPTION TYPE cx_abap_invalid_param_value EXPORTING value = 'io_ref_partent is not bound' .
    ENDIF.
  ENDMETHOD.



  METHOD get_mt_jpl_timer_table.
    r_result = mt_jpl_timer_table.
  ENDMETHOD.



ENDCLASS.
