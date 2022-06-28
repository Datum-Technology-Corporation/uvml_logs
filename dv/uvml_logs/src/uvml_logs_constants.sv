// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_LOGS_CONSTANTS_SV__
`define __UVML_LOGS_CONSTANTS_SV__


const string uvml_logs_default_trn_log_dir_name = "trn_log";
const string uvml_logs_default_trn_fextension = "log";

const string  uvml_logs_file_extensions[uvml_logs_format_enum] = '{
   UVML_LOGS_FORMAT_TEXT : "log" ,
   UVML_LOGS_FORMAT_JSON : "json",
   UVML_LOGS_FORMAT_XML  : "xml" ,
   UVML_LOGS_FORMAT_YAML : "yaml"
};

const string uvml_logs_sim_summary_banner_passed = {
"  _______ _______ _______ _______ _______ ______    \n",
" |   _   |   _   |   _   |   _   |   _   |   _  \\   \n",
" |   1   |   1   |   1___|   1___|   1___|   |   \\  \n",
" |   ____|   _   |____   |____   |   __)_|   |    \\  \n",
" |   |   |   |   |   1   |   1   |   1   |   1    /  \n",
" |   |   |   |   |       |       |       |       /   \n",
" `---'   `--- ---`-------`-------`-------`------'    "
};
const string uvml_logs_sim_summary_sub_banner_passed = {"\n",
"--------------------------------------------------- \n",
"           TEST PASSED WITH %0d WARNINGS            \n",
"--------------------------------------------------- \n"
};
const string uvml_logs_sim_summary_banner_failed = {
"    _______ _______ ___ ___     _______ ______      \n",
"   |   _   |   _   |   |   |   |   _   |   _  \\     \n",
"   |   0___|   0   |   |   |   |   0___|   |   \\    \n",
"   |   __) |   _   |   |   |___|   __)_|   |    \\   \n",
"   |   |   |   |   |   |   0   |   0   |   0    /   \n",
"   |   |   |   |   |   |       |       |       /    \n",
"   `---'   `--- ---`---`-------`-------`------'   "
};
const string uvml_logs_sim_summary_sub_banner_failed_aborted = {"\n",
"--------------------------------------------------- \n",
"       TEST FAILED - ABORTED AFTER %0d ERRORS       \n",
"--------------------------------------------------- \n"
};
const string uvml_logs_sim_summary_sub_banner_failed_fatal = {"\n",
"--------------------------------------------------- \n",
"           TEST FAILED DUE TO FATAL ERROR           \n",
"--------------------------------------------------- \n"
};
const string uvml_logs_sim_summary_sub_banner_failed = {"\n",
"--------------------------------------------------- \n",
"            TEST FAILED WITH %0d ERRORS             \n",
"--------------------------------------------------- \n"
};


/**
 * WARNING Vivado has a bug with $value$plusargs where it will only accept hardcoded strings. So this is here only for
 * reference
 */
const string uvml_logs_default_sim_dir_cli_arg = "TRN_LOG_DIR";


`endif // __UVML_LOGS_CONSTANTS_SV__
