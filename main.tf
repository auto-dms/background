provider "google" {
  credentials = "auto-dms-ede951efff11.json"
  project = "auto-dms"
  region = "asia-northeast1"
}

module "apply_extension" {
  source = "github.com/terraform-google-modules/terraform-google-event-function/"
  version = "0.1.0"

  entry_point = "apply_extension"

  event_trigger {
    event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource = "apply-extension"
  }

  name = "apply_extension"
  project_id = "auto-dms"
  region = "asia-northeast1"
  source_directory = "./functions/apply-extension"
  runtime = "python37"
}

module "publish_apply_extension_jobs" {
  source = "github.com/moreal/terraform-google-scheduled-function"
  version = "0.1.0"
  project_id = "auto-dms"

  job_name                  = "publish_apply_extension_jobs"
  job_schedule              = "30 17 1 * *"
  function_entry_point      = "publish_apply_extension_jobs"
  function_source_directory = "./functions/publish-apply-extension-jobs"
  function_runtime          = "python37"
  function_name             = "publish_apply_extension_jobs"
  region                    = "asia-northeast1"
  topic_name                = "start-publish-apply-extension"
  time_zone                 = "Asia/Seoul"

  function_environment_variables {
    GOOGLE_CLOUD_PROJECT="auto-dms"
  }
}