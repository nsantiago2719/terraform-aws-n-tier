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
			"sub-domain":       os.Getenv("SUBDOMAIN"),
			"hosted-zone-name": os.Getenv("HOSTEDZONENAME"),
			"domain-name":      os.Getenv("DOMAIN"),
		},
	}
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	domain := terraform.Output(t, terraformOptions, "domain")

	maxRetries := 30
	timeBetweenRetries := 5 * time.Second

	instanceText := "Welcome to nginx on Amazon Linux"

	http_helper.HttpGetWithRetry(t, domain, 200, instanceText, maxRetries, timeBetweenRetries)
}
