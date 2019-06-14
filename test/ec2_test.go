package test

import (
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCreateEc2(t *testing.T) {

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/ec2-test",
		Vars:         map[string]interface{}{},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	instanceURL := terraform.Output(t, terraformOptions, "instance-url")

	maxRetries := 30
	timeBetweenRetries := 5 * time.Second

	instanceText := "Welcome to nginx on Amazon Linux"

	http_helper.HttpGetWithRetry(t, instanceURL, 200, instanceText, maxRetries, timeBetweenRetries)
}
