param (
    [string] $operation,
    [string] $env,
    [string] $sfdcEntity,
    [string] $fileName,
    [string] $soql,
    [string] $externalId
)
$CONFIG_DIR="$PSScriptRoot/conf"
$PROCESS_OPTION="process.name=$env"
#$PROCESS_ENCRYPTION_KEY="process.encryptionKeyFile=`"$PSScriptRoot/conf/dataLoader.key`""
$DATA_ACCESS_NAME="dataAccess.name=CSVs/$fileName"
$PROCESS_OUTPUT_ERROR="process.outputError=/conf/logs/extractError-$operation-$sfdcEntity.csv"
$PROCESS_OUTPUT_SUCCESS="process.outputError=/conf/logs/extractSuccess-$operation-$sfdcEntity.csv"
$PROCESS_OPERATION="process.operation=$operation"
$sfdcEntity="sfdc.entity=$sfdcEntity"

Write-Host $CONFIG_DIR

if( "extract" -eq $operation ){
    $dataAccess="dataAccess.type=csvWrite"
    $soql="sfdc.extractionSOQL=$soql"
    $externalId=""
}
else {
    $dataAccess="dataAccess.type=csvRead"
    $soql="" 
    $externalId="sfdc.externalIdField=$externalId"
    $PROCESSS_MAPPING="process.mappingFile=`"$PSScriptRoot/conf\Mappings\$fileName.sdl`""
}

Write-Host java -cp ./bin/dataloader-60.0.0.jar com.salesforce.dataloader.process.DataLoaderRunner run.mode=batch salesforce.config.dir=$CONFIG_DIR $PROCESS_OPTION $PROCESS_OPERATION $sfdcEntity $PROCESS_ENCRYPTION_KEY $DATA_ACCESS_NAME $PROCESS_OUTPUT_ERROR $PROCESS_OUTPUT_SUCCESS $dataAccess $soql $externalId $PROCESSS_MAPPING
java -cp ./bin/dataloader-60.0.0.jar com.salesforce.dataloader.process.DataLoaderRunner run.mode=batch salesforce.config.dir=$CONFIG_DIR $PROCESS_OPTION $PROCESS_OPERATION $sfdcEntity $PROCESS_ENCRYPTION_KEY $DATA_ACCESS_NAME $PROCESS_OUTPUT_ERROR $PROCESS_OUTPUT_SUCCESS $dataAccess $soql $externalId $PROCESSS_MAPPING