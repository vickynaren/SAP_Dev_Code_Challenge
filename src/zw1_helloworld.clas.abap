CLASS zw1_helloworld DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zw1_helloworld IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write('Hello World!').
  ENDMETHOD.
ENDCLASS.
