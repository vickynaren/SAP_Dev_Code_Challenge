CLASS zcl_w3_abap_mustache DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    TYPES:
      BEGIN OF ty_item,
        Name           TYPE string,
        MainCategory   TYPE string,
        sub_category   TYPE string,
        availablity    TYPE i,
        price_per_unit TYPE i,
        currency       TYPE string,
        supplier_id    TYPE string,
      END OF ty_item.

    DATA tt_items TYPE STANDARD TABLE OF ty_item.

    TYPES: BEGIN OF ty_supplier,
             id    TYPE string,
             Name  TYPE string,
             items LIKE tt_items,
           END OF ty_supplier.

    DATA tt_supplier TYPE STANDARD TABLE OF ty_supplier.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_w3_abap_mustache IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA : lr_data     TYPE REF TO ty_supplier,
           it_items    LIKE tt_items,
           it_supplier LIKE tt_supplier.

    DATA(c_nl) = cl_abap_char_utilities=>newline.

    it_supplier = VALUE #(
    ( id = '100000062'  Name = 'Supplier 1' items = VALUE #( ( Name = 'Flat XL'               MainCategory = 'Computer Components' sub_category = 'Flat Screen Monitors'        availablity = 5 price_per_unit = 1230 currency = 'MXN' ) ) )
    ( id = '100000065'  Name = 'Supplier 2' items = VALUE #( ( Name = 'Notebook Basic 18'     MainCategory = 'Computer Systems'    sub_category = 'Notebooks'                   availablity = 2 price_per_unit = 1570  currency = 'USD' )
                                                             ( Name = 'Notebook Basic 15'     MainCategory = 'Computer Systems'    sub_category = 'Notebooks'                   availablity = 3 price_per_unit = 956 currency = 'EUR'   )  )   )
    ( id = '100000080'  Name = 'Supplier 3' items = VALUE #( ( Name = 'Universal card reader' MainCategory = 'Computer Systems'    sub_category = 'Computer System Accessories' availablity = 0  price_per_unit = 1400  currency = 'JPY') ) ) ).

    TRY.
        DATA(lo_mustache_template) = zcl_mustache=>create(
            '{{Name}}: {{ ID }}' && c_nl &&
             '{{>items_template}}' ).

        DATA(lo_partial) = zcl_mustache=>create(
            ' {{#items}}' && c_nl &&
            ' {{name}} {{MainCategory}}/{{sub_category}} {{price_per_unit}}{{currency}}' && c_nl &&
            ' {{/items}}' && c_nl && c_nl ).

        lo_mustache_template->add_partial(   iv_name = 'items_template' io_obj  = lo_partial ).

        DATA(lv_text) =  lo_mustache_template->render( it_supplier ).
        out->write( lv_text ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
