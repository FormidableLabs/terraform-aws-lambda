package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAWSLambda(t *testing.T) {
	// Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../",
	})

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables and check they have the expected values.
	lambdaArn := terraform.Output(t, terraformOptions, "arn")
	assert.Equal(t, "arn:aws:lambda:us-east-1:848569143948:function:use1-development-testLambda2", lambdaArn)
	assert.Equal(t, "arn:aws:lambda:us-east-1:000000000000:function:use1-development-testLambda", lambdaArn)
}
