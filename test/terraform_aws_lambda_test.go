package test

import (
	"os"
	"os/exec"
	"testing"

	// "github.com/gruntwork-io/terratest/modules/aws"
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
	lambda := terraform.OutputMap(t, terraformOptions, "lambda")

	assert.Equal(t, "arn:aws:lambda:us-east-1:000000000000:function:use1-development-testLambda", lambda["arn"])
	// Obtain working directory
	dirPath, _ := os.Getwd()

	// Test invoking Lambda function
	invokeLambdaCmd := "awslocal lambda invoke --function-name use1-development-testLambda response.json"
	exec.Command("bash", "-c", invokeLambdaCmd).Output()

	// if response.json is returned, that means the Lambda Invocation was successful
	assert.FileExists(t, dirPath+"/response.json")

	// Confirm CloudWatch Logs group created successfully
	cloudwatchLogsCmd := "awslocal logs describe-log-groups --log-group-name-prefix /aws/lambda/use1-development-testLambda | jq -r '.logGroups[].logGroupName'"
	out, _ := exec.Command("bash", "-c", cloudwatchLogsCmd).Output()

	assert.Equal(t, "/aws/lambda/use1-development-testLambda\n", string(out))

}
