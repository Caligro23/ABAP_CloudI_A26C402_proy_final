CLASS zcl_work_order_validator_pp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

 PUBLIC SECTION.
 METHODS:
 validate_create_order IMPORTING iv_customer_id TYPE ze_customer_id
 iv_technician_id TYPE ze_id_tecnico_pp
 iv_priority TYPE ze_priority_pp
 RETURNING VALUE(rv_valid) TYPE abap_bool,

validate_update_order IMPORTING iv_work_order_id TYPE ze_workorderid
iv_status TYPE ze_status_pp
RETURNING VALUE(rv_valid) TYPE abap_bool,

validate_delete_order IMPORTING iv_work_order_id TYPE ze_workorderid
iv_status TYPE ze_status_pp
RETURNING VALUE(rv_valid) TYPE abap_bool,

validate_status_and_priority IMPORTING iv_status TYPE ze_status_pp
iv_priority TYPE ze_priority_pp
RETURNING VALUE(rv_valid) TYPE abap_bool.

  PRIVATE SECTION.

  CONSTANTS: c_valid_status TYPE string VALUE 'PE CO', " Example statuses: Pending, Completed
                c_valid_priority TYPE string VALUE 'A B'. " Example priorities: High, Low

ENDCLASS.



CLASS zcl_work_order_validator_pp IMPLEMENTATION.


METHOD validate_create_order.


 " Check if customer exists
 select single
 from ztcustomer2
 fields customer_id
 where customer_id EQ @iv_customer_id
 into @DATA(lv_customer_exists).

 IF lv_customer_exists IS INITIAL.
 rv_valid = abap_false.
 RETURN.
 ENDIF.

 " Check if technician exists
  select single
 from zttechnician
 fields technician_id
 where technician_id  EQ @iv_technician_id
 into @DATA(lv_technician_exists).
 IF lv_technician_exists IS INITIAL.
 rv_valid = abap_false.
 RETURN.
 ENDIF.

 select from ztpriority_pp
 fiELDS 'I' as sign ,
        'EQ'  as option ,
        priority_code as low,
        priority_code as high
 into table @DATA(lt_priority_range).

 " Check if priority is valid
 IF iv_priority IN lt_priority_range and lt_priority_range is not initial.
 else.
 rv_valid = abap_false.
 RETURN.
 ENDIF.

 rv_valid = abap_true.
 ENDMETHOD.



 METHOD validate_update_order.
 " Check if the work order exists
 select single
 from ztwork_order
 fields work_order_id
 where work_order_id EQ @iv_work_order_id
 into @DATA(lv_order_exists).

 IF lv_order_exists IS INITIAL.
 rv_valid = abap_false.
 RETURN.
 ENDIF.

 " Check if the order status is editable (e.g., Pending)
 select from ztstatus_pp
 fiELDS 'I' as sign ,
        'EQ'  as option ,
        status_code as low,
        status_code as high
 into table @DATA(lt_status_range).

 IF iv_status IN lt_status_range and lt_status_range is not initial.
 else.
 rv_valid = abap_false.
 RETURN.
 ENDIF.

 rv_valid = abap_true.
 ENDMETHOD.

 METHOD validate_delete_order.
 " Check if the order exists
 select single
 from ztwork_order
 fields work_order_id
 where work_order_id EQ @iv_work_order_id
 into @DATA(lv_order_exists).

 IF lv_order_exists IS INITIAL.
 rv_valid = abap_false.
 RETURN.
 ENDIF.

" Check if the order status is "PE" (Pending)
IF iv_status NE 'PE'.
rv_valid = abap_false.
RETURN.
ENDIF.

" Check if the order has a history (i.e., if it has been modified before)
select single
from ztworkorder_hist
fields history_id
where work_order_id EQ @iv_work_order_id
into @DATA(lv_has_history).

IF lv_has_history IS NOT INITIAL.
rv_valid = abap_false.
RETURN.
ENDIF.

rv_valid = abap_true.
ENDMETHOD.

METHOD validate_status_and_priority.
" Validate the status value
 select from ztstatus_pp
 fiELDS 'I' as sign ,
        'EQ'  as option ,
        status_code as low,
        status_code as high
 into table @DATA(lt_status_range).

IF iv_status IN lt_status_range and lt_status_range is not initial.
else.
rv_valid = abap_false.
RETURN.
ENDIF.


 " Check if priority is valid
 select from ztpriority_pp
 fiELDS 'I' as sign ,
        'EQ'  as option ,
        priority_code as low,
        priority_code as high
 into table @DATA(lt_priority_range).

 IF iv_priority IN lt_priority_range and lt_priority_range is not initial.
 else.
 rv_valid = abap_false.
 RETURN.
 ENDIF.

 rv_valid = abap_true.
 ENDMETHOD.


ENDCLASS.
