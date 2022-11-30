package test

import (
	"log"
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
	os.Setenv("AWS_REGION", "us-east-1")
	os.Setenv("AWS_ACCESS_KEY_ID", "test")
	os.Setenv("AWS_SECRET_ACCESS_KEY", "test")

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
	assert.Equal(t, "arn:aws:lambda:us-east-1:000000000000:function:use1-development-testLambda", lambdaArn)
	// functionName := terraform.Output(t, terraformOptions, "function_name")

	// out, err := exec.Command("awslocal lambda invoke --function-name ", functionName, " response.json").Output()
	// if err != nil {
	// 	fmt.Printf("%s", err)
	// }
	// fmt.Println("Command Successfully Executed")
	// output := string(out[:])
	// fmt.Println(output)

	cmd := exec.Command("awslocal lambda invoke --function-name use1-development-testLambda response.json")

	err := cmd.Run()

	if err != nil {
		log.Fatal(err)
	}

	// awsRegion := "us-east-1"

	// testEvent := &HelloWorld{
	// 	Key: "value1",
	// }

	// testResponse := aws.InvokeFunction(t, awsRegion, functionName, testEvent)
	// assert.NotEmpty(t, testResponse)
}
