 CLASS zcl_test_jpl_timer DEFINITION FINAL FOR TESTING
                                 DURATION LONG
                                 RISK LEVEL HARMLESS.

   PRIVATE SECTION.
     METHODS:
       test_5_sec_sleep FOR TESTING RAISING cx_static_check.
 ENDCLASS.


 CLASS zcl_test_jpl_timer IMPLEMENTATION.

   METHOD test_5_sec_sleep.
" given
     DATA(lo_jpl_timer) = zcl_jpl_factory=>create_root_timer( iv_name = 'test:test'  ).
" when
     DO 5 TIMES.
       lo_jpl_timer->start(  ).
       WAIT UP TO 1 SECONDS.
       lo_jpl_timer->accumulate(  ).
     ENDDO.


"then
    data(ls_timer_data) = lo_jpl_timer->get_timer_data(  ).
   cl_abap_unit_assert=>assert_equals( exp = 5 act = ls_timer_data-total_loops msg = 'Number of loops do not line up').
   cl_abap_unit_assert=>assert_number_between( lower = 5000 upper = 5500 number = ls_timer_data-total_runtime_ms msg = 'runtime does not line up' ).

   ENDMETHOD.



 ENDCLASS.
