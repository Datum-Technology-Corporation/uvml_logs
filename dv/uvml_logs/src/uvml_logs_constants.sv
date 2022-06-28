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
"  $$$$$$$\\   $$$$$$\\   $$$$$$\\   $$$$$$\\  $$$$$$$$\\ $$$$$$$\\   \n",
"  $$  __$$\\ $$  __$$\\ $$  __$$\\ $$  __$$\\ $$  _____|$$  __$$\\  \n",
"  $$ |  $$ |$$ /  $$ |$$ /  \\__|$$ /  \\__|$$ |      $$ |  $$ | \n",
"  $$$$$$$  |$$$$$$$$ |\\$$$$$$\\  \\$$$$$$\\  $$$$$\\    $$ |  $$ | \n",
"  $$  ____/ $$  __$$ | \\____$$\\  \\____$$\\ $$  __|   $$ |  $$ | \n",
"  $$ |      $$ |  $$ |$$\\   $$ |$$\\   $$ |$$ |      $$ |  $$ | \n",
"  $$ |      $$ |  $$ |\\$$$$$$  |\\$$$$$$  |$$$$$$$$\\ $$$$$$$  | \n",
"  \\__|      \\__|  \\__| \\______/  \\______/ \\________|\\_______/  \n"
};
const string uvml_logs_sim_summary_sub_banner_passed = {
" -------------------------------------------------------------- \n",
"                 TEST PASSED WITH %0d WARNING(S)                \n",
" -------------------------------------------------------------- \n"
};
const string uvml_logs_sim_summary_banner_failed = {
"  $$$$$$$$\\  $$$$$$\\  $$$$$$\\ $$\\       $$$$$$$$\\ $$$$$$$\\    \n",
"  $$  _____|$$  __$$\\ \\_$$  _|$$ |      $$  _____|$$  __$$\\   \n",
"  $$ |      $$ /  $$ |  $$ |  $$ |      $$ |      $$ |  $$ |  \n",
"  $$$$$\\    $$$$$$$$ |  $$ |  $$ |      $$$$$\\    $$ |  $$ |  \n",
"  $$  __|   $$  __$$ |  $$ |  $$ |      $$  __|   $$ |  $$ |  \n",
"  $$ |      $$ |  $$ |  $$ |  $$ |      $$ |      $$ |  $$ |  \n",
"  $$ |      $$ |  $$ |$$$$$$\\ $$$$$$$$\\ $$$$$$$$\\ $$$$$$$  |  \n",
"  \\__|      \\__|  \\__|\\______|\\________|\\________|\\_______/   \n"
};
const string uvml_logs_sim_summary_sub_banner_failed_aborted = {
" ----------------------------------------------------------- \n",
"          TEST FAILED - ABORTED AFTER %0d ERROR(S)           \n",
" ----------------------------------------------------------- \n"
};
const string uvml_logs_sim_summary_sub_banner_failed_fatal = {
" ----------------------------------------------------------- \n",
"               TEST FAILED DUE TO FATAL ERROR                \n",
" ----------------------------------------------------------- \n"
};
const string uvml_logs_sim_summary_sub_banner_failed = {
" ----------------------------------------------------------- \n",
"               TEST FAILED WITH %0d ERROR(S)                 \n",
" ----------------------------------------------------------- \n"
};


/**
 * WARNING Vivado has a bug with $value$plusargs where it will only accept hardcoded strings. So this is here only for
 * reference
 */
const string uvml_logs_default_sim_dir_cli_arg = "TRN_LOG_DIR";


`endif // __UVML_LOGS_CONSTANTS_SV__
