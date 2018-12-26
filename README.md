# mv-aws-sns-sqs

## SNS/SQS Messaging


SNS Topic and SQS Queue for messaging, with a dead letter and alarm on queue
depth.


## Naming

Those are the conventions:

    ```
    stack=stackname                     file.param.json: TopicName
    ----------------------------------- --------------------------
    1. sample-01                        sample
    2. mv-aws-cloudtrail-alerts         mv-aws-cloudtrail-alerts
    3. mv-aws-cloudtrail-deliveries     mv-aws-cloudtrail-deliveries
    4. mv-aws-notifications             mv-aws-notifications


    TopicName/QueueName            deadletter                     Alarm
    ------------------------------ ------------------------------ -------------------------------------
    1. sample                      sample-dl                      sqs-alarm-sample
    2. mvaws-cloudtrail-alerts     mvaws-cloudtrail-alerts-dl     sqs-alarm-mvaws-cloudtrail-alerts
    3. mvaws-cloudtrail-deliveries mvaws-cloudtrail-deliveries-dl sqs-alarm-mvaws-cloudtrail-deliveries
    4. mvaws-notifications         mvaws-notifications-dl         sqs-alarm-mvaws-notifications

    ```


## Basic workflow

A parameter file must be defined to create a topic/queue combination. Also,
`tags` are being used to track the cost of resources.


I built a `Makefile` with some helper tasks to accomplish that. For example:

    ```bash
    $
    #
    # Write cf code... or define your param file.
    #
    #   file:  sns-sqs.template.yaml
    #   stack: sample-01
    #   param: param.sample.json
    #
    $ file=sns-sqs.template.yaml stack=sample-01 param=param.sample.json make vt   # validate...
    $ file=sns-sqs.template.yaml stack=sample-01 param=param.sample.json make cs   # created!
    $ file=sns-sqs.template.yaml stack=sample-01 param=param.sample.json make se   # follow stack events
    $ file=sns-sqs.template.yaml stack=sample-01 param=param.sample.json make pub  # test: publish to topic
    ```


## Makefile

`Makefile` usage:

    ```
    Usage:
      make                                                    # show help
      file=filename name=stackname [param=paramfile] make vt  # validate template
      file=filename name=stackname [param=paramfile] make cs  # create stack
      file=filename name=stackname [param=paramfile] make us  # update stack


    Where:
      filename:   AWS Cloudformation template file to be used.
      stackname:  AWS Cloudformation stack name to be created.
      paramfile:  Parameter file in JSON format.

    Parameter file JSON format:
    ```
    ```javascript
    [
        { "ParameterKey": "TopicName" , "ParameterValue": "sample" },
        { "ParameterKey": "Tag1"      , "ParameterValue": "sample" },
        { "ParameterKey": "Tag2"      , "ParameterValue": "test"   }
    ]
    ```


