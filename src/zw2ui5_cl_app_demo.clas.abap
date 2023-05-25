CLASS zw2ui5_cl_app_demo DEFINITION PUBLIC.
  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA user  TYPE string.
    DATA date LIKE sy-datum.

    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zw2ui5_cl_app_demo IMPLEMENTATION.


  METHOD z2ui5_if_app~main.
    "event handling
    DATA: lv_date_string TYPE string,
          lv_datum       TYPE sy-datum.

    lv_datum = date.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      user  = 'Vignesh Narayan'.
      date = sy-datum.
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->popup_message_toast( |App executed on { date DATE = USER } by { user }| ).
    ENDCASE.

    client->set_next( VALUE #( xml_main = z2ui5_cl_xml_view=>factory(
            )->shell(
            )->page( title = 'abap2UI5 - First Example -Vignesh Narayan'
            )->simple_form( editable = abap_true
            )->content( 'form'
            )->title( 'Input'
            )->label( 'User'
            )->input( value = client->_bind( user )
                      placeholder = 'User'
                      )->label( 'Date'
                      )->date_picker( value = date placeholder = 'date'
                      )->button(  text  = 'post'
                                  press = client->_event( 'BUTTON_POST' ) )->get_root( )->xml_get( ) ) ).

  ENDMETHOD.
ENDCLASS.
