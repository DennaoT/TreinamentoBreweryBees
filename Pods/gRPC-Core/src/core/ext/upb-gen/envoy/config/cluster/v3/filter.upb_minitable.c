/* This file was generated by upb_generator from the input file:
 *
 *     envoy/config/cluster/v3/filter.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#include <stddef.h>
#include "upb/generated_code_support.h"
#include "envoy/config/cluster/v3/filter.upb_minitable.h"
#include "envoy/config/core/v3/config_source.upb_minitable.h"
#include "google/protobuf/any.upb_minitable.h"
#include "udpa/annotations/status.upb_minitable.h"
#include "udpa/annotations/versioning.upb_minitable.h"
#include "validate/validate.upb_minitable.h"

// Must be last.
#include "upb/port/def.inc"

static const upb_MiniTableSub envoy_config_cluster_v3_Filter_submsgs[2] = {
  {.submsg = &google__protobuf__Any_msg_init},
  {.submsg = &envoy__config__core__v3__ExtensionConfigSource_msg_init},
};

static const upb_MiniTableField envoy_config_cluster_v3_Filter__fields[3] = {
  {1, UPB_SIZE(12, 8), 0, kUpb_NoSub, 9, (int)kUpb_FieldMode_Scalar | ((int)kUpb_FieldRep_StringView << kUpb_FieldRep_Shift)},
  {2, UPB_SIZE(4, 24), 1, 0, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
  {3, UPB_SIZE(8, 32), 2, 1, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
};

const upb_MiniTable envoy__config__cluster__v3__Filter_msg_init = {
  &envoy_config_cluster_v3_Filter_submsgs[0],
  &envoy_config_cluster_v3_Filter__fields[0],
  UPB_SIZE(24, 40), 3, kUpb_ExtMode_NonExtendable, 3, UPB_FASTTABLE_MASK(24), 0,
  UPB_FASTTABLE_INIT({
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
    {0x000800003f00000a, &upb_pss_1bt},
    {0x0018000001000012, &upb_psm_1bt_maxmaxb},
    {0x002000000201001a, &upb_psm_1bt_maxmaxb},
  })
};

static const upb_MiniTable *messages_layout[1] = {
  &envoy__config__cluster__v3__Filter_msg_init,
};

const upb_MiniTableFile envoy_config_cluster_v3_filter_proto_upb_file_layout = {
  messages_layout,
  NULL,
  NULL,
  1,
  0,
  0,
};

#include "upb/port/undef.inc"

