# [AWS(Amazon Web Services)](https://aws.amazon.com)

## lambda

通过 AWS Lambda，无需预置或管理服务器即可运行代码。您只需按使用的计算时间付费 – 代码未运行时不产生费用。
借助 Lambda，您几乎可以为任何类型的应用程序或后端服务运行代码，而且完全无需管理。只需上传您的代码，Lambda 会处理运行和扩展高可用性代码所需的一切工作。您可以将您的代码设置为自动从其他 AWS 产品触发，或者直接从任何 Web 或移动应用程序调用。

## 新闻

* 亚马逊上海建立人工智能研究院

## 工具

* [aws/aws-cli](https://github.com/aws/aws-cli):Universal Command Line Interface for Amazon Web Services
  - `pip3 install awscli --upgrade --user`
  - `export PATH=~/.local/bin:$PATH`
* [awslabs/aws-sam-cli](https://github.com/awslabs/aws-sam-cli):AWS SAM CLI 🐿 is a CLI tool for local development and testing of Serverless applications
  - `brew tap aws/tap`
  - `brew install aws-sam-cli`
  - create a S3 bucket `aws s3 mb s3://<bucket-name>`
  - upload the code and generate the stack configuration:`sam package  --output-template-file .stack.yaml \ --s3-bucket <bucket-name>`
  - deploy the generated stack:`sam deploy  --template-file .stack.yaml  --capabilities CAPABILITY_IAM  --stack-name <stack-name>`
* [minio/minio](https://github.com/minio/minio):Minio is an open source object storage server compatible with Amazon S3 APIs https://minio.io/downloads.html#download-server
* [aws/opsworks-cookbooks](https://github.com/aws/opsworks-cookbooks):Chef Cookbooks for the AWS OpsWorks Service
* [minio/minio](https://github.com/minio/minio):Minio is an open source object storage server compatible with Amazon S3 APIs https://minio.io/downloads.html#download-server
* [awslabs/aws-devops-essential](https://github.com/awslabs/aws-devops-essential):In few hours, quickly learn how to effectively leverage various AWS services to improve developer productivity and reduce the overall time to market for new product capabilities.
* [mthenw/awesome-layers](https://github.com/mthenw/awesome-layers):λ A curated list of awesome AWS Lambda Layers.
* [lambci/lambci](https://github.com/lambci/lambci):A continuous integration system built on AWS Lambda
* [localstack/localstack](https://github.com/localstack/localstack):💻 A fully functional local AWS cloud stack. Develop and test your cloud & Serverless apps offline! https://localstack.cloud

## 参考

* [open-guides/og-aws](https://github.com/open-guides/og-aws):📙 Amazon Web Services — a practical guide
* [中国官网](https://amazonaws-china.com/cn/)
