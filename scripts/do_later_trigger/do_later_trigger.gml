/// Queue a callback function for execution when a trigger function returns <true>
/// 
/// If the defined callback function returns <true> then the operation *won't* be removed from Do Later's system
/// This will cause the operation to be evaluated continuously whilst the trigger functions returns <true>
///
/// @return A struct that represents the created and queued operation
/// @param triggerFunction    Trigger function to execute. When this function returns <true>, the callback function is executed. This function is rebound to the provided scope
/// @param callbackFunction   Function/method to execute

function do_later_trigger(_trigger_function, _callback_function)
{
    return do_later_trigger_ext(_trigger_function, _callback_function, -1, -1);
}

/// @return A struct that represents the created and queued operation
/// @param triggerFunction    Trigger function to execute. When this function returns <true>, the callback function is executed. This function is rebound to the provided scope
/// @param callbackFunction   Function to execute. This function is rebound to the provided scope
/// @param triggerScope       Scope to execute the trigger function in, which can be an instance or a struct. If triggerScope is a numeric value less than 0 then the trigger function will not be re-scoped
/// @param callbackScope      Scope to execute the callback function in, which can be an instance or a struct. If callbackScope is a numeric value less than 0 then the callback function will not be re-scoped
function do_later_trigger_ext(_trigger_function, _callback_function, _trigger_scope, _callback_scope)
{
    if (!is_numeric(_trigger_scope ) || (_trigger_scope  >= 0)) _trigger_function  = method(_trigger_scope , _trigger_function );
    if (!is_numeric(_callback_scope) || (_callback_scope >= 0)) _callback_function = method(_callback_scope, _callback_function);
    
    var struct = {
        list     : global.__do_later_trigger_list,
        trigger  : _trigger_function,
        callback : _callback_function,
        deleted  : false
    }
    
    ds_list_add(global.__do_later_trigger_list, struct);
    return struct;
}