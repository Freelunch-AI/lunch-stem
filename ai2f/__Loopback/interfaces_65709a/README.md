# Hardware Module Interfaces

The idea of the EML Toolbox is to be able to apply the same folder structure and scripts on different hardware to save a huge amount of customization and engineering effort.
To make it possible, each hardware with its native model optimizer and inference executor have to use a common interface for data exchange with the EML Toolbox. In this folder,
we added example interfaces to the hardware modules

The basic idea is to exchange data through csv files, which are very general. Each measurement set shall be added as one row in the file. For each interface certain column 
headers are defined. These headers are the interfaces, which shall be common. It is possible to merge latency and performance into one file with multiple or even sparse use of 
headers.

For developers, who are working with hardware modules, the following interfaces shall be developed for each hardware module.
- Latency Measurement Interface
- Object Detection Interface for object detection models

## Interface for Hardware Module Developers
The latency measurement interface consists of two components:
- csv file with measurements
- text file with a database key

The evaluation metric interface consists of the following component:
- detections.csv

### latency.csv
**This file shall be implemented for each hardware module.**

In the latency.csv, the latency measurements are collected. Each measurement has is a single record.

The following column headers shall be used for latency exchange:
- Index: Identifier for the measurement set that consists of the date in seconds + the model name, e.g. 20210610134408_tf2oda_ssdmobilenetv2_300x300_pets. The id is used to merge and enhance measurement sets to get everything as a single entry in a database
- Date: Format yyyy-MM-DD HH:mm:ss e.g. 2021-03-09 23:29:00
- Model: Long model name as used as file name, e.g. tf2oda_ssdmobilenetv2_320x320_pedestrian
- Model_Short: For usage in figures, a short version of the model should be used, e.g. ssdmobnet_320x320. In case no special short name is supposed to be used, the long name should be used.
- Framework: network framework, e.g. tf2oda	
- Network: network name as one word, e.g. ssdmobilenetv2
- Resolution: Width x height, e.g. 320x300
- Dataset: Dataset name, e.g. pedestrian
- Custom_Parameters: The last parameters are custom parameters like LR03 for learning rate 0.3
- Hardware: Hardware name, e.g. Xavier
- Hardware_Optimization: Hardware optimization framework and settings like trt_int8
- Batch_Size: default 1
- Throughput: measured value
- Mean_Latency: calculated value from single measurements
- Latencies: single latency measurements

In [ latency.csv](./latency.csv), we present an example interface to use as a guidance.

**Developer Hint**: The network specific settings can be extracted from the long name according to the naming convention mentioned above. Please use the method \"def get_info_from_modelname(model_name, model_short_name=None, model_optimizer_prefix=['TRT', 'OV'])\" from [inference_utils.py](../../inference_evaluation/inference_utils.py) for that task

**Developer Hint**: The index in the coloum index shall be generated with the method \"generate_measurement_index(model_name)\" from [inference_utils.py](../../inference_evaluation/inference_utils.py)

### index.txt
**This file shall be implemented for each hardware module.**

Usually, latency and evaluation metrics are measured separately. To be able to combine latency measurements with power or evaluation metric, we need to use a key value for the measurement.
This is done by writing the single string value into a file, [index.txt](./index.txt) after each measurement of latency. This value is written as the first row in the index file.

Default path:
```
./tmp/index.txt
```

Then, by the evaluation metric script, this value is the read by the evaluation metric script (performance) and used there as a key.

In [index.txt](./index.txt), an example is given.

**Developer Hint**: Set the index path as a script argument that can be customized. 

### Object Detection Interface
**This file shall be implemented for each hardware module.**

The result of the inference is latency and bounding boxes. Each framework has its special format. For further processing, the detections are brought into a common format. 
This format is based on the Tensorflow 2 used format. In the file, each bounding box is a row.

The format looks like the following:
- filename: Image file name
- width: Image width in pixels, e.g. 500
- height: Image height in pixels, e.g. 300
- class: Class integer starting with 1 for the first class (like in PASCAL VOC. If e.g. yolo, where the first class is 0, then add +1 to the class) 
- xmin: Relative position for x min, xmin[px]/image width[px]
- ymin: Relative position for y min, ymin[px]/image height[px]
- xmax: Relative position for x max, xmax[px]/image width[px]
- ymax: Relative position for y max, xmax[px]/image height[px]
- score: Confidence score from the inference engine. For ground truth, this value is 1

In [detections.csv](./detections.csv), an example is provided.

**Developer Hint**: Copy and modify the method \"convert_reduced_detections_tf2_to_df(image_filename, image_np, boxes, classes, scores, min_score=0.5)\" from [inference_utils.py](../../inference_evaluation/inference_utils.py) to 
implement this function.

## Performance Measurement Interface for Object Detection
The [ detections.csv](./detections.csv) file, which is created for each inference is then put into an evaluation metric. For detections, the standard evaluation metric is the Coco metric. 

The detections.csv is processed in the following way by the EML Tool:
1. converted by [convert_tfcsv_to_pycocodetections.py](../../conversion/convert_tfcsv_to_pycocodetections.py) to the Coco detections format, which is different
than the Coco ground truth format. 
2. Then, the coco detections file is evaluated by [objdet_pycoco_evaluation.py](../../inference_evaluation/objdet_pycoco_evaluation.py) and 
3. the result is saved in [performance.csv](./performance.csv)

The following column headers shall be used for performance of object detection exchange. The network+hardware identifier is 
- Index: Identifier for the measurement set, e.g. a hash like HJDSJD83. The id is used to merge and enhance measurement sets to get everything as a single entry in a database
- Date: Format yyyy-MM-DD HH:mm:ss e.g. 2021-03-09 23:29:00
- Model: Long model name as used as file name, e.g. tf2oda_ssdmobilenetv2_320x320_pedestrian
- Model_Short: For usage in figures, a short version of the model should be used, e.g. ssdmobnet_320x320. In case no special short name is supposed to be used, the long name should be used.
- Framework: network framework, e.g. tf2oda	
- Network: network name as one word, e.g. ssdmobilenetv2
- Resolution: Width x height, e.g. 320x300
- Dataset: Dataset name, e.g. pedestrian
- Custom_Parameters: The last parameters are custom parameters like LR03 for learning rate 0.3
- Hardware: Hardware name, e.g. Xavier
- Hardware_Optimization: Hardware optimization framework and settings like trt_int8
- DetectionBoxes_Precision/mAP: Part of the standard Coco metric
- DetectionBoxes_Precision/mAP@.50IOU: Part of the standard Coco metric
- DetectionBoxes_Precision/mAP@.75IOU: Part of the standard Coco metric
- DetectionBoxes_Precision/mAP (small): Part of the standard Coco metric
- DetectionBoxes_Precision/mAP (medium): Part of the standard Coco metric
- DetectionBoxes_Precision/mAP (large): Part of the standard Coco metric
- DetectionBoxes_Recall/AR@1: Part of the standard Coco metric
- DetectionBoxes_Recall/AR@10: Part of the standard Coco metric
- DetectionBoxes_Recall/AR@100: Part of the standard Coco metric
- DetectionBoxes_Recall/AR@100 (small): Part of the standard Coco metric
- DetectionBoxes_Recall/AR@100 (medium): Part of the standard Coco metric
- DetectionBoxes_Recall/AR@100 (large): Part of the standard Coco metric

An example can be found in [performance.csv](./performance.csv).

## Example Script for Complete Inference Execution
In the following, an example script for NVIDIA on Linux is visible to get a hint of how the interfaces are used. Here is the original script: [tf2_inf_eval_saved_model_TEMPLATE.sh](../../hardwaremodules/nvidia/sh/tf2_inf_eval_saved_model_TEMPLATE.sh)

Execute the inference script. In this case the standard TF2ODA script is executed.
```
echo #====================================#
echo # Infer Images from Known Model
echo #====================================#
echo Inference from model 
python3 $SCRIPTPREFIX/inference_evaluation/tf2oda_inference_from_saved_model.py \
--model_path "exported-models/$MODELNAME/saved_model/" \
--image_dir "images/validation" \
--labelmap "annotations/$LABELMAP" \
--detections_out="results/$MODELNAME/$HARDWARENAME/detections.csv" \
--latency_out="results/latency_$HARDWARENAME.csv" \
--min_score=0.5 \
--model_name=$MODELNAME \
--hardware_name=$HARDWARENAME \
--index_save_file="./tmp/index.txt"
```

Convert the detections.csv to coco_detections.json
```
echo #====================================#
echo # Convert to Pycoco Tools JSON Format
echo #====================================#
echo Convert TF CSV to Pycoco Tools csv
python3 $SCRIPTPREFIX/conversion/convert_tfcsv_to_pycocodetections.py \
--annotation_file="results/$MODELNAME/$HARDWARENAME/detections.csv" \
--output_file="results/$MODELNAME/$HARDWARENAME/coco_detections.json"
```

Evaluate coco_detections.json with the coco metrics.
```
echo #====================================#
echo # Evaluate with Coco Metrics
echo #====================================#
echo coco evaluation
python3 $SCRIPTPREFIX/inference_evaluation/objdet_pycoco_evaluation.py \
--groundtruth_file="annotations/coco_pets_validation_annotations.json" \
--detection_file="results/$MODELNAME/$HARDWARENAME/coco_detections.json" \
--output_file="results/performance_$HARDWARENAME.csv" \
--model_name=$MODELNAME \
--hardware_name=$HARDWARENAME \
--index_save_file="./tmp/index.txt"
```

Merge the latency and evaluation metrix (performance) to a common results file.
```
echo #====================================#
echo # Merge results to one result table
echo #====================================#
echo merge latency and evaluation metrics
python3 $SCRIPTPREFIX/inference_evaluation/merge_results.py ^
--latency_file="results/latency.csv" \
--coco_eval_file="results/performance.csv" \
--output_file="results/combined_results.csv"
```

## Upcoming
- Create a merge script that creates only one csv file entry from both
- We plan to create a database, where measurements are automatically inserted according to the interfaces above.
- Add performance segmentation interface
- Add performance classification interface (no prio)

<div align="center">
  <img src="./../../../_img/eml_logo_and_text.png", width="500">
</div>
