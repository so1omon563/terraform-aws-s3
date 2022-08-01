# resource "aws_s3_bucket_replication_configuration" "replication" {
#   for_each = var.replication_configuration == null ? [] : var.replication_configuration

#   role = each.value.role
#   dynamic "rule" {
#     for_each = each.value.rule == null ? [] : each.value.rule

#     content {
#       id     = rule.value.id
#       prefix = rule.value.prefix
#       status = rule.value.status

#       dynamic "destination" {
#         for_each = rule.value.destination == null ? [] : rule.value.destination

#         content {
#           bucket             = destination.value.bucket
#           storage_class      = destination.value.storage_class
#           replica_kms_key_id = destination.value.replica_kms_key_id
#           account_id         = destination.value.account_id

#           dynamic "access_control_translation" {
#             for_each = destination.value.access_control_translation == null ? [] : destination.value.access_control_translation

#             content {
#               owner = access_control_translation.value.owner
#             }
#           }
#         }
#       }

#       dynamic "source_selection_criteria" {
#         for_each = rule.value.source_selection_criteria == null ? [] : rule.value.source_selection_criteria

#         content {
#           sse_kms_encrypted_objects {
#             enabled = source_selection_criteria.value.enabled
#           }
#         }
#       }
#     }
#   }
# }
