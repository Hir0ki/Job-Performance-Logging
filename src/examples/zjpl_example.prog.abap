*&---------------------------------------------------------------------*
*& Report zjpl_example
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zjpl_example.

INITIALIZATION.
  " Creating the timers for this report
  DATA(go_timer_full_report) = zcl_jpl_factory=>create_main_timer( iv_name = 'FULL_REPORT' ).
  DATA(go_timer_first_wait) = zcl_jpl_factory=>create_timer( iv_name = 'FIRST_FIRST_WAIT' io_parent_tiemr = go_timer_full_report ).
  DATA(go_timer_second_wait) = zcl_jpl_factory=>create_timer( iv_name = 'FIRST_SECOND_WAIT' io_parent_tiemr = go_timer_full_report ).


START-OF-SELECTION.


  go_timer_full_report->start(  ).

  go_timer_first_wait->start(  ).

  WAIT UP TO 5 SECONDS.

  go_timer_first_wait->accumulate(  ).


  go_timer_second_wait->start(  ).

  WAIT UP TO 4 SECONDS.

  go_timer_second_wait->accumulate(  ).

  go_timer_full_report->accumulate(  ).
