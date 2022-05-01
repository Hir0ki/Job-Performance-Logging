INTERFACE zif_jpl_timer
  PUBLIC .
  TYPES:
    BEGIN OF tty_jpl_timer_data,
      parent_ref       TYPE REF TO zif_jpl_timer,
      name             TYPE string,
      total_runtime_ms TYPE int8,
      total_loops      TYPE int4,
    END OF tty_jpl_timer_data.

  METHODS:
    "! <p class="shorttext synchronized" lang="en"></p>
    "! This call starts the timer.
    "! The timer ends when accumulate is called.
    start.

  METHODS:
    "! <p class="shorttext synchronized" lang="en"></p>
    "! This call ends the timer that was started with the start method call.
    "! It then adds the time since the start call to the total runtime
    accumulate.

  "! <p class="shorttext synchronized" lang="en"></p>
  "! Returns the current timer data.
  "! @parameter rs_timer_data | <p class="shorttext synchronized" lang="en"></p>
  METHODS get_timer_data
    RETURNING VALUE(rs_timer_data) TYPE zif_jpl_timer=>tty_jpl_timer_data.

ENDINTERFACE.
