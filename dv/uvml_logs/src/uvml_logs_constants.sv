// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
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


/**
 * WARNING Vivado has a bug with $value$plusargs where it will only accept hardcoded strings. So this is here only for
 * reference
 */
const string uvml_logs_default_sim_dir_cli_arg = "TRN_LOG_DIR";


`endif // __UVML_LOGS_CONSTANTS_SV__
