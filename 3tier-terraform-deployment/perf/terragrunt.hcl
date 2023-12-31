terraform {
    source = "git::ssh://git@bitbucket.org/dptrealtime/3tier-terraform-module?ref=1.0"
    }
    remote_state {
      backend = "s3"
      config = {
        bucket         = "ed-eos-terraform-state"
        key            = "3tier/perf/terraform.tfstate"
        region         = "us-east-1"
    }
  }

inputs = {
env = "perf"
application = "ed-eos-web"
instance_profile = "ed-eos-ec2-global"
keypair = "ed-eos-key"
instance_type = "t2.micro"
asg_max_cap = "1"
asg_min_cap = "1"
asg_desired_cap = "1"
latest_snapshot_id = ""
rds_instance_type = "db.t3.medium"
database_name = "eos"
database_identifier = "ed-rds-01"
}
