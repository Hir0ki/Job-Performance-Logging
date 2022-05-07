*"* use this source file for your ABAP unit test classes
CLASS ltcl_jpl_factory_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FRIENDS zcl_jpl_factory.

  PRIVATE SECTION.

    METHODS:
      teardown.

    METHODS:
      create_root FOR TESTING RAISING cx_static_check.
    METHODS:
      create_6_timers FOR TESTING RAISING cx_static_check.
    METHODS:
      create_with_unbound_reference FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_jpl_factory_test IMPLEMENTATION.

  METHOD create_root.
    "given
    "when
    DATA(lo_timer) = zcl_jpl_factory=>create_root_timer( iv_name = 'main' ).

    "then
    cl_abap_unit_assert=>assert_bound( act = lo_timer msg = 'did not return timer class').
    cl_abap_unit_assert=>assert_equals( act = lines( zcl_jpl_factory=>get_mt_jpl_timer_table(  ) ) exp = 1 msg = 'not enougth entries in timer table' ).
  ENDMETHOD.

  METHOD create_6_timers.
    "given
    DATA: lt_timers TYPE STANDARD TABLE OF REF TO zif_jpl_timer.
    DATA lv_count TYPE i VALUE 0.
    "when
    DATA(lo_root_timer) = zcl_jpl_factory=>create_root_timer( iv_name = 'main' ).
    APPEND lo_root_timer TO lt_timers.
    DO 5 TIMES.
      lv_count = lv_count + 1.
      APPEND zcl_jpl_factory=>create_timer( iv_name = |timer{ lv_count }| io_parent_tiemr = lo_root_timer ) TO lt_timers.
    ENDDO.
    "then
    cl_abap_unit_assert=>assert_equals( act = lines( zcl_jpl_factory=>get_mt_jpl_timer_table(  ) ) exp = 6 msg = 'not enougth entries in timer table' ).
    LOOP AT zcl_jpl_factory=>get_mt_jpl_timer_table(  ) ASSIGNING FIELD-SYMBOL(<fs_timer>).
      DATA(ls_timer_data) = <fs_timer>->get_timer_data(  ).
      cl_abap_unit_assert=>assert_bound( <fs_timer> ).
    ENDLOOP.
  ENDMETHOD.

  METHOD teardown.
    CLEAR zcl_jpl_factory=>mt_jpl_timer_table.
  ENDMETHOD.

  METHOD create_with_unbound_reference.
    "given
    DATA lo_unbound_timer TYPE REF TO zif_jpl_timer.
    "when
    TRY.
        DATA(lo_timer) = zcl_jpl_factory=>create_timer( iv_name = 'test' io_parent_tiemr = lo_unbound_timer ).
      CATCH cx_abap_invalid_param_value INTO DATA(lo_exeption).
    ENDTRY.
    "then
    cl_abap_unit_assert=>assert_bound( lo_exeption ).
  ENDMETHOD.

ENDCLASS.
