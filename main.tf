provider "aws" {
  region = "us-west-2"  # Change this to your desired AWS region
}

resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "jupyter_lifecycle" {
  name = "jupyter-lifecycle-config"  # Change this to your desired name for the lifecycle configuration

  on_create {
    content_base64 = base64encode(<<EOF
#!/bin/bash
set -e

# Add your custom setup script here
# For example, you can install additional libraries or packages needed for your Jupyter server

# Example: Install a Python package
# pip install pandas

# Example: Clone a GitHub repository
# git clone https://github.com/username/repo.git

# Example: Run a shell script from a publicly accessible location
# curl -L https://example.com/setup_script.sh | bash

# After running your custom setup, start the Jupyter server
sudo -u ec2-user -i <<EOF2
jupyter notebook --ip=0.0.0.0 --no-browser
EOF2
EOF
    )
  }

  on_start {
    content_base64 = base64encode(<<EOF
#!/bin/bash
set -e

# Add your custom start script here (optional)
# This script will be executed each time the notebook instance is started.

# For example, you can activate a virtual environment or mount an EFS volume.

EOF
    )
  }
}
