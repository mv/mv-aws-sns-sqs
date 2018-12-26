# mv-aws-sns-sqs

## SNS/SQS Messaging


SNS Topic and SQS Queue for messaging, with a dead letter and alarm on queue
depth.


## Basic workflow


When creating new stacks in my dev account generally I need:

1. Write cf code.
2. Validate cf code.
3. Create a stack with a name.
4. Update that stack many times.
5. Update that stack many times, with parameters.
6. Create the same stack, with a different name.
7. Idem 4.
8. Idem 5.
9. Go back to 1.


I built a `Makefile` with some helper tasks to accomplish that. For example:

    ```bash
    $
    #
    # Write cf code... or define your param file.
    #
    #   file:  sns-sqs-messaging.cf.template.yaml
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


