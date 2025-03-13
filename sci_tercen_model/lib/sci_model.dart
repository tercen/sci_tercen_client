library sci_model;

import "dart:convert";

import "package:sci_base/sci_base.dart" as base;

import "sci_model_base.dart";
import "package:sci_http_client/error.dart";
import "package:collection/collection.dart" as collection;

part 'src/model/impl/team.dart';
part 'src/model/impl/double_property.dart';
part 'src/model/impl/rectangle.dart';
part 'src/model/impl/running_state.dart';
part 'src/model/impl/where_relation.dart';
part 'src/model/impl/storage_profile.dart';
part 'src/model/impl/operator_output_spec.dart';
part 'src/model/impl/resource_summary.dart';
part 'src/model/impl/billing_info.dart';
part 'src/model/impl/patch_records.dart';
part 'src/model/impl/property.dart';
part 'src/model/impl/garbage_tasks.dart';
part 'src/model/impl/version.dart';
part 'src/model/impl/filters.dart';
part 'src/model/impl/chart_heatmap.dart';
part 'src/model/impl/statistic_node.dart';
part 'src/model/impl/cube_query.dart';
part 'src/model/impl/user.dart';
part 'src/model/impl/r_library.dart';
part 'src/model/impl/filter.dart';
part 'src/model/impl/group_step.dart';
part 'src/model/impl/task_log_event.dart';
part 'src/model/impl/user_session.dart';
part 'src/model/impl/table.dart';
part 'src/model/impl/docker_operator.dart';
part 'src/model/impl/acl.dart';
part 'src/model/impl/cube_axis_query.dart';
part 'src/model/impl/gate_node.dart';
part 'src/model/impl/task_summary.dart';
part 'src/model/impl/ramp_palette.dart';
part 'src/model/impl/distinct_relation.dart';
part 'src/model/impl/running_dependent_state.dart';
part 'src/model/impl/export_workflow_task.dart';
part 'src/model/impl/start_process.dart';
part 'src/model/impl/token.dart';
part 'src/model/impl/activity_count.dart';
part 'src/model/impl/join_operator.dart';
part 'src/model/impl/operator_model.dart';
part 'src/model/impl/c_s_v_file_metadata.dart';
part 'src/model/impl/table_step_model.dart';
part 'src/model/impl/melt_step.dart';
part 'src/model/impl/crosstab_table.dart';
part 'src/model/impl/x_y_axis_list.dart';
part 'src/model/impl/filter_top_expr.dart';
part 'src/model/impl/axis_spec.dart';
part 'src/model/impl/double_color_element.dart';
part 'src/model/impl/task_progress_event.dart';
part 'src/model/impl/garbage_object.dart';
part 'src/model/impl/crosstab.dart';
part 'src/model/impl/state.dart';
part 'src/model/impl/patch_record.dart';
part 'src/model/impl/operator.dart';
part 'src/model/impl/run_computation_task.dart';
part 'src/model/impl/project_task.dart';
part 'src/model/impl/worker_endpoint.dart';
part 'src/model/impl/column_schema_meta_data.dart';
part 'src/model/impl/privilege.dart';
part 'src/model/impl/c_s_v_task.dart';
part 'src/model/impl/activity.dart';
part 'src/model/impl/cube_query_task.dart';
part 'src/model/impl/vies_info.dart';
part 'src/model/impl/join_step_model.dart';
part 'src/model/impl/ulimits.dart';
part 'src/model/impl/r_description.dart';
part 'src/model/impl/meta_factor.dart';
part 'src/model/impl/jet_palette.dart';
part 'src/model/impl/table_relation.dart';
part 'src/model/impl/profile.dart';
part 'src/model/impl/date.dart';
part 'src/model/impl/step_state.dart';
part 'src/model/impl/project_document.dart';
part 'src/model/impl/operator_result.dart';
part 'src/model/impl/r_source_library.dart';
part 'src/model/impl/file_document.dart';
part 'src/model/impl/document.dart';
part 'src/model/impl/address.dart';
part 'src/model/impl/task_data_event.dart';
part 'src/model/impl/string_property.dart';
part 'src/model/impl/x_y_axis.dart';
part 'src/model/impl/id_object.dart';
part 'src/model/impl/principal.dart';
part 'src/model/impl/attribute.dart';
part 'src/model/impl/import_workflow_task.dart';
part 'src/model/impl/project.dart';
part 'src/model/impl/url.dart';
part 'src/model/impl/string_color_element.dart';
part 'src/model/impl/enumerated_property.dart';
part 'src/model/impl/test_operator_task.dart';
part 'src/model/impl/import_git_workflow_task.dart';
part 'src/model/impl/reference_relation.dart';
part 'src/model/impl/r_proxy.dart';
part 'src/model/impl/operator_spec.dart';
part 'src/model/impl/pair.dart';
part 'src/model/impl/in_memory_relation.dart';
part 'src/model/impl/relation.dart';
part 'src/model/impl/file_metadata.dart';
part 'src/model/impl/run_profile.dart';
part 'src/model/impl/save_computation_result_task.dart';
part 'src/model/impl/cpu_time_profile.dart';
part 'src/model/impl/axis_settings.dart';
part 'src/model/impl/mapping_filter.dart';
part 'src/model/impl/chart_bar.dart';
part 'src/model/impl/folder_document.dart';
part 'src/model/impl/lock.dart';
part 'src/model/impl/worker.dart';
part 'src/model/impl/import_git_dataset_task.dart';
part 'src/model/impl/ace.dart';
part 'src/model/impl/in_step.dart';
part 'src/model/impl/labels.dart';
part 'src/model/impl/renv_installed_library.dart';
part 'src/model/impl/operator_settings.dart';
part 'src/model/impl/cube_query_table_schema.dart';
part 'src/model/impl/category_palette.dart';
part 'src/model/impl/model_step.dart';
part 'src/model/impl/table_summary.dart';
part 'src/model/impl/task_event.dart';
part 'src/model/impl/point.dart';
part 'src/model/impl/column.dart';
part 'src/model/impl/summary.dart';
part 'src/model/impl/task_state_event.dart';
part 'src/model/impl/shiny_operator.dart';
part 'src/model/impl/errors.dart';
part 'src/model/impl/gl_task.dart';
part 'src/model/impl/failed_state.dart';
part 'src/model/impl/palette.dart';
part 'src/model/impl/canceled_state.dart';
part 'src/model/impl/run_workflow_task.dart';
part 'src/model/impl/graphical_factor.dart';
part 'src/model/impl/rename_relation.dart';
part 'src/model/impl/operator_input_spec.dart';
part 'src/model/impl/chart_line.dart';
part 'src/model/impl/color_list.dart';
part 'src/model/impl/relation_step.dart';
part 'src/model/impl/data_step.dart';
part 'src/model/impl/search_result.dart';
part 'src/model/impl/gate_operator_model.dart';
part 'src/model/impl/chart_size.dart';
part 'src/model/impl/annotation_model.dart';
part 'src/model/impl/schema.dart';
part 'src/model/impl/color_element.dart';
part 'src/model/impl/r_operator.dart';
part 'src/model/impl/out_step.dart';
part 'src/model/impl/library_task.dart';
part 'src/model/impl/pre_processor.dart';
part 'src/model/impl/input_port.dart';
part 'src/model/impl/properties.dart';
part 'src/model/impl/property_value.dart';
part 'src/model/impl/computation_task.dart';
part 'src/model/impl/done_state.dart';
part 'src/model/impl/acl_context.dart';
part 'src/model/impl/docker_web_app_operator.dart';
part 'src/model/impl/operator_unit_test.dart';
part 'src/model/impl/step_model.dart';
part 'src/model/impl/table_step.dart';
part 'src/model/impl/run_web_app_task.dart';
part 'src/model/impl/union_relation.dart';
part 'src/model/impl/profiles.dart';
part 'src/model/impl/step.dart';
part 'src/model/impl/filter_expr2d.dart';
part 'src/model/impl/factors_property.dart';
part 'src/model/impl/task.dart';
part 'src/model/impl/event.dart';
part 'src/model/impl/port.dart';
part 'src/model/impl/operator_ref.dart';
part 'src/model/impl/join_step.dart';
part 'src/model/impl/wizard_step.dart';
part 'src/model/impl/wizard_step_model.dart';
part 'src/model/impl/factor.dart';
part 'src/model/impl/init_state.dart';
part 'src/model/impl/simple_relation.dart';
part 'src/model/impl/pending_state.dart';
part 'src/model/impl/chart_point.dart';
part 'src/model/impl/column_pair.dart';
part 'src/model/impl/create_git_operator_task.dart';
part 'src/model/impl/crosstab_spec.dart';
part 'src/model/impl/filter_expr.dart';
part 'src/model/impl/table_schema.dart';
part 'src/model/impl/tax_id.dart';
part 'src/model/impl/plan.dart';
part 'src/model/impl/sci_object.dart';
part 'src/model/impl/c_s_v_parser_param.dart';
part 'src/model/impl/web_app_operator.dart';
part 'src/model/impl/export_table_task.dart';
part 'src/model/impl/generic_event.dart';
part 'src/model/impl/cross_tab_step.dart';
part 'src/model/impl/output_port.dart';
part 'src/model/impl/persistent_object.dart';
part 'src/model/impl/link.dart';
part 'src/model/impl/app_design.dart';
part 'src/model/impl/garbage_tasks2.dart';
part 'src/model/impl/workflow.dart';
part 'src/model/impl/named_filter.dart';
part 'src/model/impl/namespace_step.dart';
part 'src/model/impl/table_profile.dart';
part 'src/model/impl/melt_step_model.dart';
part 'src/model/impl/export_model.dart';
part 'src/model/impl/annotation_operator_model.dart';
part 'src/model/impl/axis.dart';
part 'src/model/impl/boolean_property.dart';
part 'src/model/impl/gather_relation.dart';
part 'src/model/impl/export_step.dart';
part 'src/model/impl/view_step.dart';
part 'src/model/impl/api_call_profile.dart';
part 'src/model/impl/colors.dart';
part 'src/model/impl/composite_relation.dart';
part 'src/model/impl/column_schema.dart';
part 'src/model/impl/git_project_task.dart';
part 'src/model/impl/computed_table_schema.dart';
part 'src/model/impl/table_properties.dart';
part 'src/model/impl/mapping_factor.dart';
part 'src/model/impl/chart.dart';
part 'src/model/impl/git_operator.dart';
part 'src/model/impl/subscription_plan.dart';
part 'src/model/impl/formula_property.dart';
part 'src/model/impl/user_secret.dart';
part 'src/model/impl/group_by_relation.dart';
