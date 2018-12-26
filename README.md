# mv-aws-sns-sqs

## SNS/SQS Messaging


SNS Topic and SQS Queue for messaging, with a dead letter and alarm on queue
depth.


## Basic workflow


A parameter file must be defined to create a topic/queue combination. Also,
`tags` are being used to track the cost of resources.


Those are the conventions:

    ```
    Stack             TopicName         QueueName         DeadLetter                   Alarm
    sample-01         sample-01         sample-01         sample-01-deadletter         sample-01
    sample-02         sample-02         sample-02         sample-02-deadletter         sample-02
    org-trail         org-trail         org-trail         org-trail-deadletter         org-trail
    trail-data-plane  trail-data-plane  trail-data-plane  trail-data-plane-deadletter  trail-data-plane
    ```



I built a `Makefile` with some helper tasks to accomplish that. For example:

    ```bash
    $
    #
    # Write cf code... or define your param file.
    #
    #   file:  sns-sqs-messaging.template.yaml
    #   stack: sample-01
    #   param: param.sample.json
    #
    $ file=sns-sqs-messaging stack=sample-01 param=param.sample.json make vt   # validate...
    $ file=sns-sqs-messaging stack=sample-01 param=param.sample.json make cs   # created!
    $ file=sns-sqs-messaging stack=sample-01 param=param.sample.json make se   # follow stack events
    $ file=sns-sqs-messaging stack=sample-01 param=param.sample.json make pub  # test: publish to topic
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


