package test

import (
	"os"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCreateAll(t *testing.T) {

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/create-all",

		Vars: map[string]interface{}{
			"certificate-arn": os.Getenv("CERTIFICATE_ARN"),
		},
	}
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	elbUrl := terraform.Output(t, terraformOptions, "elb_dns")

	maxRetries := 30
	timeBetweenRetries := 5 * time.Second

	instanceText := "Welcome to nginx on Amazon Linux"

	http_helper.HttpGetWithRetry(t, elbUrl, 200, instanceText, maxRetries, timeBetweenRetries)
}
