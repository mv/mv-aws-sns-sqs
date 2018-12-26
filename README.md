# mv-aws-sns-sqs

## SNS/SQS Messaging


SNS Topic and SQS Queue for messaging, with a dead letter and alarm on queue
depth.


## Naming

Those are the conventions:

    ```
    stack=stackname                        file.param.json: TopicName
    -------------------------------------- --------------------------
    1. sns-sqs-sample-01                   sns-sqs-sample
    2. sns-sqs-myorg-cloudtrail-alerts     myorg-cloudtrail-alerts
    3. sns-sqs-myorg-cloudtrail-deliveries myorg-cloudtrail-deliveries
    4. sns-sqs-myorg-notifications         myorg-notifications


    TopicName/QueueName            deadletter                     Alarm
    ------------------------------ ------------------------------ -------------------------------------
    1. sns-sqs-sample              sns-sqs-sample-dl              sqs-alarm-sns-sqs-sample
    2. myorg-cloudtrail-alerts     myorg-cloudtrail-alerts-dl     sqs-alarm-myorg-cloudtrail-alerts
    3. myorg-cloudtrail-deliveries myorg-cloudtrail-deliveries-dl sqs-alarm-myorg-cloudtrail-deliveries
    4. myorg-notifications         myorg-notifications-dl         sqs-alarm-myorg-notifications

    ```


## Basic workflow

1. A `env` file must defined to set your stack name and param file to be used:

    ```
    $ cat sample.env.sh
        export file=sns-sqs.template.yaml
        export stack=sns-sqs-sample-01
        export param=sample.param.json

    $ source ./sample.env.sh
    ```

2. A parameter file must be defined to set your stack parameters and `tags`.


    ```
    $ cat sample.param.json

    [
        { "ParameterKey": "TopicName" , "ParameterValue": "sns-sqs-sample" },
        { "ParameterKey": "Tag1Key"   , "ParameterValue": "App"    },
        { "ParameterKey": "Tag1Value" , "ParameterValue": "sample" },
        { "ParameterKey": "Tag2Key"   , "ParameterValue": "Env"    },
        { "ParameterKey": "Tag2Value" , "ParameterValue": "test"   },
        { "ParameterKey": "QueueRetentionPeriod" , "ParameterValue": "1209600" },
        { "ParameterKey": "QueueAlarmDepth"      , "ParameterValue": "10000"   }
    ]
    ```

3. Create your stack

    ```
    $ make cs  # create stack
    $ make se  # follow stack events
    ```



## Makefile

`Makefile` usage:

    ```
    Usage:
      $ make                                                          # show help
      $ file=filename.yml stack=stackname [param=paramfile] make show # show defined vars
      $ file=filename.yml stack=stackname [param=paramfile] make vt   # validate template
      $ file=filename.yml stack=stackname [param=paramfile] make cs   # create stack
      $ file=filename.yml stack=stackname [param=paramfile] make us   # update stack

    Where:
      filename.yml: AWS Cloudformation template file to be used.
      stackname:    AWS Cloudformation stack name to be created.
      paramfile:    Parameter file in JSON format.


    Usage (faster):
      $ make                    # show help
      $ source ./sample.env.sh  # define vars: file/stack/param
      $ make show               # show defined vars
      $ make vt                 # validate template
      $ make cs                 # create stack
      $ make se                 # follow stack events

    Where:
      sample.env.sh: shell script with environment variables.

    ```



