#!/bin/bash

# REMOVE O ARQUIVO ANTIGO
cd /home/ubuntu/vroom && rm -rf aws_s3_vroom_backup_file.zip
# ZIPA O VOLUME DO ELASTICSEARCH
cd /home/ubuntu/vroom && zip -r aws_s3_vroom_backup_file.zip search/volume/data
# RODA O CONTAINER DA AWS PRA SALVAR O ARQUIVO NO S3
docker run --rm -e AWS_ACCESS_KEY_ID=AKIAVGD2TE2JOOBNUIHY -e AWS_SECRET_ACCESS_KEY=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 -v /home/ubuntu/vroom/aws_s3_vroom_backup_file.zip:/root/aws_s3_vroom_backup_file.zip amazon/aws-cli s3 cp ~/aws_s3_vroom_backup_file.zip s3://gohusky/aws_s3_vroom_backup_file.zip