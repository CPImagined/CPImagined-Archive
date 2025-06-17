//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.mail.MailEngine
    {
        var __mail, __has_fetched, __has_messages, __on_response, __on_details_response, __on_next_set_response, __on_delete_user_mail_response, __total_mail, __total_mail_listeners, __new_mail_count, __new_mail_queue, __new_mail_count_on_server, __new_mail_listeners, __mail_recieved_listeners, __messages_per_set, __last_set_fetched, __total_sets, __last_recieved_id;
        function MailEngine () {
            this.initialize();
        }
        function initialize() {
            __mail = undefined;
            __has_fetched = false;
            __has_messages = false;
            __on_response = undefined;
            __on_details_response = undefined;
            __on_next_set_response = undefined;
            __on_delete_user_mail_response = undefined;
            __total_mail = undefined;
            __total_mail_listeners = undefined;
            __new_mail_count = 0;
            __new_mail_queue = undefined;
            __new_mail_count_on_server = 0;
            __new_mail_listeners = undefined;
            __mail_recieved_listeners = undefined;
            __messages_per_set = 12;
            __last_set_fetched = 0;
            __total_sets = undefined;
            __last_recieved_id = 0;
        }
        function set mail(_mailArray) {
            __mail = _mailArray;
            //return(mail);
        }
        function get mail() {
            return(__mail);
        }
        function set has_fetched(_bool) {
            __has_fetched = _bool;
            //return(has_fetched);
        }
        function get has_fetched() {
            return(__has_fetched);
        }
        function set has_messages(_bool) {
            __has_messages = _bool;
            //return(has_messages);
        }
        function get has_messages() {
            return(has_messages);
        }
        function set on_response(_func) {
            __on_response = _func;
            //return(on_response);
        }
        function get on_response() {
            return(__on_response);
        }
        function set on_details_response(_func) {
            __on_details_response = _func;
            //return(on_details_response);
        }
        function get on_details_response() {
            return(__on_details_response);
        }
        function set on_next_set_response(_func) {
            __on_next_set_response = _func;
            //return(on_next_set_response);
        }
        function get on_next_set_response() {
            return(__on_next_set_response);
        }
        function set on_delete_user_mail_response(_func) {
            __on_delete_user_mail_response = _func;
            //return(on_delete_user_mail_response);
        }
        function get on_delete_user_mail_response() {
            return(__on_delete_user_mail_response);
        }
        function set total_mail(_obj) {
            __total_mail = _obj;
            //return(total_mail);
        }
        function get total_mail() {
            return(__total_mail);
        }
        function set total_mail_listeners(_obj) {
            __total_mail_listeners = _obj;
            //return(total_mail_listeners);
        }
        function get total_mail_listeners() {
            return(__total_mail_listeners);
        }
        function set new_mail_count(_count) {
            __new_mail_count = _count;
            //return(new_mail_count);
        }
        function get new_mail_count() {
            return(__new_mail_count);
        }
        function set new_mail_queue(_obj) {
            __new_mail_queue = _obj;
            //return(new_mail_queue);
        }
        function get new_mail_queue() {
            return(__new_mail_queue);
        }
        function set new_mail_count_on_server(_count) {
            __new_mail_count_on_server = _count;
            //return(new_mail_count_on_server);
        }
        function get new_mail_count_on_server() {
            return(__new_mail_count_on_server);
        }
        function set new_mail_listeners(_obj) {
            __new_mail_listeners = _obj;
            //return(new_mail_listeners);
        }
        function get new_mail_listeners() {
            return(__new_mail_listeners);
        }
        function set mail_recieved_listeners(_obj) {
            __mail_recieved_listeners = _obj;
            //return(mail_recieved_listeners);
        }
        function get mail_recieved_listeners() {
            return(__mail_recieved_listeners);
        }
        function set messages_per_set(_count) {
            __messages_per_set = _count;
            //return(messages_per_set);
        }
        function get messages_per_set() {
            return(__messages_per_set);
        }
        function set last_set_fetched(_count) {
            __last_set_fetched = _count;
            //return(last_set_fetched);
        }
        function get last_set_fetched() {
            return(__last_set_fetched);
        }
        function set total_sets(_obj) {
            __total_sets = _obj;
            //return(total_sets);
        }
        function get total_sets() {
            return(__total_sets);
        }
        function set last_recieved_id(_count) {
            __last_recieved_id = _count;
            //return(last_recieved_id);
        }
        function get last_recieved_id() {
            return(__last_recieved_id);
        }
    }
