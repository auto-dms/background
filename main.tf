provider "google" {
  credentials = "auto-dms-ede951efff11.json"
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
